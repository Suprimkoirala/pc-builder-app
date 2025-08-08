from django.urls import path
from . import sql_views_v2 as sql_views
from .auth_views import LoginView, LogoutView, MeView, MyTokenObtainPairView, RegisterView

urlpatterns = [
    # Authentication endpoints
    path('register/', RegisterView.as_view(), name='register'),
    path('login/', LoginView.as_view(), name='login'),
    path('logout/', LogoutView.as_view(), name='logout'),
    path('me/', MeView.as_view(), name='me'),
    path('token/', MyTokenObtainPairView.as_view(), name='token_obtain_pair'),

    # Vendor endpoints
    path('vendors/', sql_views.get_vendors, name='vendors'),

    # Component-specific endpoints
    path('cpus/', sql_views.get_cpus, name='cpus'),
    path('cpus/<int:cpu_id>/', sql_views.get_cpu_by_id, name='cpu_detail'),
    path('motherboards/', sql_views.get_motherboards, name='motherboards'),
    path('ram/', sql_views.get_ram_modules, name='ram_modules'),
    path('gpus/', sql_views.get_gpus, name='gpus'),
    path('storage/', sql_views.get_storage_devices, name='storage_devices'),
    path('power-supplies/', sql_views.get_power_supplies, name='power_supplies'),
    path('cases/', sql_views.get_cases, name='cases'),
    path('cpu-coolers/', sql_views.get_cpu_coolers, name='cpu_coolers'),

    # Compatibility and search endpoints
    path('compatibility/', sql_views.check_compatibility, name='check_compatibility'),
    path('options-with-compatibility/', sql_views.get_options_with_compatibility, name='options_with_compatibility'),
    path('search/', sql_views.search_components, name='search_components'),

    # Build management
    path('builds/', sql_views.create_build, name='create_build'),
    path('users/<int:user_id>/builds/', sql_views.get_user_builds, name='user_builds'),
    path('builds/<int:build_id>/', sql_views.get_build_details, name='build_details'),
]
