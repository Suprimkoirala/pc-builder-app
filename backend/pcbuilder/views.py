from urllib import response
from rest_framework import viewsets, permissions
from .models import *
from rest_framework.views import APIView
from .serializers import *

class IsOwnerOrReadOnly(permissions.BasePermission):
    def has_object_permission(self, request, view, obj):
        return obj.user == request.user

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = []

class CurrentUserView(APIView):
    permission_classes = []

    def get(self, request):
        serializer = UserSerializer(request.user)
        return response(serializer.data)

class CategoryViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Category.objects.all()
    serializer_class = CategorySerializer
    permission_classes = []

class VendorViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Vendor.objects.all()
    serializer_class = VendorSerializer
    permission_classes = []

class ComponentViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Component.objects.all()
    serializer_class = ComponentSerializer
    permission_classes = []

class BuildViewSet(viewsets.ModelViewSet):
    queryset = Build.objects.all() 
    serializer_class = BuildSerializer
    permission_classes = [IsOwnerOrReadOnly]

    def get_queryset(self):
        return Build.objects.filter(user=self.request.user)