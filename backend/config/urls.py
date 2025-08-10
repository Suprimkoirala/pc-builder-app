from django.contrib import admin
from django.urls import path, include
from django.http import JsonResponse
from rest_framework_simplejwt.views import (
    TokenBlacklistView,
    TokenRefreshView,
)

urlpatterns = [
    path('admin/', admin.site.urls),              
    path('api/v1/', include('pcbuilder.urls')),
    path('api-auth/', include('rest_framework.urls')),
    path('api/v1/logout/', TokenBlacklistView.as_view(), name='token_blacklist'), 
    path('api/v1/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    path('healthz/', lambda request: JsonResponse({"status": "ok"})),
]