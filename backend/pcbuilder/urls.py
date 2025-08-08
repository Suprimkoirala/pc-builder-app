from django.urls import path
from . import sql_views
from .auth_views import LoginView, LogoutView, MeView, MyTokenObtainPairView, RegisterView

urlpatterns = [
    # Authentication endpoints
    path('register/', RegisterView.as_view(), name='register'),
    path('login/', LoginView.as_view(), name='login'),
    path('logout/', LogoutView.as_view(), name='logout'),
    path('me/', MeView.as_view(), name='me'),
    path('token/', MyTokenObtainPairView.as_view(), name='token_obtain_pair'),
    
    # SQL-based API endpoints
    path('categories/', sql_views.get_categories, name='categories'),
    path('vendors/', sql_views.get_vendors, name='vendors'),
    path('components/', sql_views.get_components, name='components'),
    path('components/<int:component_id>/', sql_views.get_component_by_id, name='component_detail'),
    path('categories/<str:category_slug>/components/', sql_views.get_components_by_category, name='components_by_category'),
    path('search/', sql_views.search_components, name='search_components'),
    path('compatibility-rules/', sql_views.get_compatibility_rules, name='compatibility_rules'),
    
    # Build management
    path('builds/', sql_views.create_build, name='create_build'),
    path('users/<int:user_id>/builds/', sql_views.get_user_builds, name='user_builds'),
    path('builds/<int:build_id>/', sql_views.get_build_details, name='build_details'),
]
