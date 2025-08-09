from django.contrib import admin
from django.urls import path, include
from django.http import HttpResponse, JsonResponse
from rest_framework_simplejwt.views import (
    TokenBlacklistView,
    TokenRefreshView,
)

urlpatterns = [
    # Health/readiness probes (return 200 OK)
    path('', lambda request: HttpResponse('ok'), name='root_ok'),
    path('healthz/', lambda request: JsonResponse({'status': 'ok'}), name='healthz'),
    path('admin/', admin.site.urls),              
    path('api/v1/', include('pcbuilder.urls')),
    path('api-auth/', include('rest_framework.urls')),
    path('api/v1/logout/', TokenBlacklistView.as_view(), name='token_blacklist'), 
    path('api/v1/token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
]