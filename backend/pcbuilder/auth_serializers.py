from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from django.contrib.auth import authenticate
from rest_framework.exceptions import AuthenticationFailed

class MyTokenObtainPairSerializer(TokenObtainPairSerializer):
    username_field = 'email'
    
    def validate(self, attrs):
        email = attrs.get('email')
        password = attrs.get('password')
        
        if email and password:
            user = authenticate(email=email, password=password)
            if not user:
                raise AuthenticationFailed('Invalid credentials')
            if not user.is_active:
                raise AuthenticationFailed('User account is disabled')
        else:
            raise AuthenticationFailed('Must include email and password')
        
        attrs['user'] = user
        return super().validate(attrs) 
