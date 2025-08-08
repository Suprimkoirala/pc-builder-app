from rest_framework import status, permissions
from rest_framework.response import Response
from rest_framework.views import APIView
from django.contrib.auth import login, logout
from rest_framework_simplejwt.tokens import RefreshToken
from django.contrib.auth import authenticate
from pcbuilder.models import User
from .serializers import UserSerializer

# from rest_framework_simplejwt.views import TokenObtainPairView
# from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
# from rest_framework.exceptions import AuthenticationFailed
# from django.contrib.auth import get_user_model
# from django.contrib.auth.backends import ModelBackend

# class EmailTokenObtainPairSerializer(TokenObtainPairSerializer):
#     def validate(self, attrs):
#         username = attrs.get("username")  # actually this will be email
#         password = attrs.get("password")

#         user_model = get_user_model()
#         try:
#             user = user_model.objects.get(email=username)
#         except user_model.DoesNotExist:
#             raise AuthenticationFailed("No user with this email")

#         if not user.check_password(password):
#             raise AuthenticationFailed("Incorrect password")

#         attrs["username"] = user.username  # fallback to username for JWT logic
#         return super().validate(attrs)

# class EmailTokenObtainPairView(TokenObtainPairView):
#     serializer_class = EmailTokenObtainPairSerializer

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated

from rest_framework_simplejwt.views import TokenObtainPairView
from .auth_serializers import MyTokenObtainPairSerializer

class MyTokenObtainPairView(TokenObtainPairView):
    serializer_class = MyTokenObtainPairSerializer

class MeView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        user = request.user
        return Response({
            "id": user.id,
            "username": user.username,
            "email": user.email,
        })


class RegisterView(APIView):
    permission_classes = [permissions.AllowAny]

    def post(self, request):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            refresh = RefreshToken.for_user(user)
            return Response({
                'refresh': str(refresh),
                'access': str(refresh.access_token),
                'user': UserSerializer(user).data
            }, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class LoginView(APIView):
    permission_classes = [permissions.AllowAny]

    def post(self, request):
        email = request.data.get('email')
        password = request.data.get('password')

        if not email or not password:
            return Response({'error': 'Email and password are required'}, status=status.HTTP_400_BAD_REQUEST)

        try:
            user = authenticate(email=email, password=password)
            if user:
                refresh = RefreshToken.for_user(user)
                return Response({
                    'refresh': str(refresh),
                    'access': str(refresh.access_token),
                    'user': UserSerializer(user).data
                })
            else:
                return Response({'error': 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)
        except Exception as e:
            return Response({'error': 'Authentication failed'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

class LogoutView(APIView):
    permission_classes = [permissions.IsAuthenticated]
    
    def post(self, request):
        try:
            refresh_token = request.data.get("refresh")
            token = RefreshToken(refresh_token)
            token.blacklist()
            return Response(status=status.HTTP_205_RESET_CONTENT)
        except Exception as e:
            return Response(status=status.HTTP_400_BAD_REQUEST)