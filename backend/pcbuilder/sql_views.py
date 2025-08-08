import psycopg2
from psycopg2.extras import RealDictCursor
from django.conf import settings
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
import json
from django.db import connection

def get_db_connection():
    """Get database connection"""
    return psycopg2.connect(
        host=settings.DATABASES['default']['HOST'],
        database=settings.DATABASES['default']['NAME'],
        user=settings.DATABASES['default']['USER'],
        password=settings.DATABASES['default']['PASSWORD'],
        port=settings.DATABASES['default']['PORT']
    )

@api_view(['GET'])
def get_categories(request):
    """Get all categories using raw SQL"""
    try:
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT id, name, slug, icon, description, sort_order, is_active, created_at, updated_at
                FROM categories 
                WHERE is_active = TRUE 
                ORDER BY sort_order, name
            """)
            columns = [col[0] for col in cursor.description]
            categories = [dict(zip(columns, row)) for row in cursor.fetchall()]
        
        return Response(categories)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
def get_vendors(request):
    """Get all vendors using raw SQL"""
    try:
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT id, name, website, logo_url, country, description, is_active, created_at, updated_at
                FROM vendors 
                WHERE is_active = TRUE 
                ORDER BY name
            """)
            columns = [col[0] for col in cursor.description]
            vendors = [dict(zip(columns, row)) for row in cursor.fetchall()]
        
        return Response(vendors)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
def get_components(request):
    """Get all components using raw SQL with optional filtering"""
    try:
        category_id = request.GET.get('category_id')
        vendor_id = request.GET.get('vendor_id')
        min_price = request.GET.get('min_price')
        max_price = request.GET.get('max_price')
        
        query = """
            SELECT 
                c.id, c.name, c.model, c.description, c.price, c.image_url, 
                c.stock_quantity, c.is_active, c.specifications, c.performance_score,
                c.power_consumption, c.socket_type, c.form_factor, c.memory_type,
                c.memory_speed, c.memory_capacity, c.storage_type, c.storage_capacity,
                c.power_rating, c.release_date, c.warranty_months, c.rating, c.review_count,
                c.created_at, c.updated_at,
                cat.id as category_id, cat.name as category_name, cat.slug as category_slug,
                v.id as vendor_id, v.name as vendor_name, v.website as vendor_website
            FROM components c
            JOIN categories cat ON c.category_id = cat.id
            JOIN vendors v ON c.vendor_id = v.id
            WHERE c.is_active = TRUE
        """
        
        params = []
        
        if category_id:
            query += " AND c.category_id = %s"
            params.append(category_id)
        
        if vendor_id:
            query += " AND c.vendor_id = %s"
            params.append(vendor_id)
        
        if min_price:
            query += " AND c.price >= %s"
            params.append(float(min_price))
        
        if max_price:
            query += " AND c.price <= %s"
            params.append(float(max_price))
        
        query += " ORDER BY c.performance_score DESC, c.price"
        
        with connection.cursor() as cursor:
            cursor.execute(query, params)
            columns = [col[0] for col in cursor.description]
            components = []
            for row in cursor.fetchall():
                component = dict(zip(columns, row))
                # Parse JSON fields
                if component['specifications']:
                    component['specifications'] = json.loads(component['specifications'])
                components.append(component)
        
        return Response(components)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
def get_component_by_id(request, component_id):
    """Get a specific component by ID using raw SQL"""
    try:
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT 
                    c.id, c.name, c.model, c.description, c.price, c.image_url, 
                    c.stock_quantity, c.is_active, c.specifications, c.performance_score,
                    c.power_consumption, c.socket_type, c.form_factor, c.memory_type,
                    c.memory_speed, c.memory_capacity, c.storage_type, c.storage_capacity,
                    c.power_rating, c.release_date, c.warranty_months, c.rating, c.review_count,
                    c.created_at, c.updated_at,
                    cat.id as category_id, cat.name as category_name, cat.slug as category_slug,
                    v.id as vendor_id, v.name as vendor_name, v.website as vendor_website
                FROM components c
                JOIN categories cat ON c.category_id = cat.id
                JOIN vendors v ON c.vendor_id = v.id
                WHERE c.id = %s AND c.is_active = TRUE
            """, [component_id])
            
            columns = [col[0] for col in cursor.description]
            row = cursor.fetchone()
            
            if not row:
                return Response({'error': 'Component not found'}, status=status.HTTP_404_NOT_FOUND)
            
            component = dict(zip(columns, row))
            if component['specifications']:
                component['specifications'] = json.loads(component['specifications'])
        
        return Response(component)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
def get_components_by_category(request, category_slug):
    """Get components by category slug using raw SQL"""
    try:
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT 
                    c.id, c.name, c.model, c.description, c.price, c.image_url, 
                    c.stock_quantity, c.is_active, c.specifications, c.performance_score,
                    c.power_consumption, c.socket_type, c.form_factor, c.memory_type,
                    c.memory_speed, c.memory_capacity, c.storage_type, c.storage_capacity,
                    c.power_rating, c.release_date, c.warranty_months, c.rating, c.review_count,
                    c.created_at, c.updated_at,
                    cat.id as category_id, cat.name as category_name, cat.slug as category_slug,
                    v.id as vendor_id, v.name as vendor_name, v.website as vendor_website
                FROM components c
                JOIN categories cat ON c.category_id = cat.id
                JOIN vendors v ON c.vendor_id = v.id
                WHERE cat.slug = %s AND c.is_active = TRUE
                ORDER BY c.performance_score DESC, c.price
            """, [category_slug])
            
            columns = [col[0] for col in cursor.description]
            components = []
            for row in cursor.fetchall():
                component = dict(zip(columns, row))
                if component['specifications']:
                    component['specifications'] = json.loads(component['specifications'])
                components.append(component)
        
        return Response(components)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['POST'])
def create_build(request):
    """Create a new build using raw SQL"""
    try:
        user_id = request.data.get('user_id')
        name = request.data.get('name')
        description = request.data.get('description', '')
        is_public = request.data.get('is_public', True)
        build_type = request.data.get('build_type', 'custom')
        components = request.data.get('components', [])
        
        if not user_id or not name:
            return Response({'error': 'user_id and name are required'}, status=status.HTTP_400_BAD_REQUEST)
        
        with connection.cursor() as cursor:
            # Create build
            cursor.execute("""
                INSERT INTO builds (user_id, name, description, is_public, build_type)
                VALUES (%s, %s, %s, %s, %s)
                RETURNING id
            """, [user_id, name, description, is_public, build_type])
            
            build_id = cursor.fetchone()[0]
            
            # Add components to build
            for component_data in components:
                component_id = component_data.get('component_id')
                quantity = component_data.get('quantity', 1)
                notes = component_data.get('notes', '')
                
                cursor.execute("""
                    INSERT INTO build_components (build_id, component_id, quantity, notes)
                    VALUES (%s, %s, %s, %s)
                """, [build_id, component_id, quantity, notes])
            
            # Calculate total price
            cursor.execute("SELECT calculate_build_total_price(%s)", [build_id])
            
            connection.commit()
        
        return Response({'id': build_id, 'message': 'Build created successfully'}, status=status.HTTP_201_CREATED)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
def get_user_builds(request, user_id):
    """Get builds for a specific user using raw SQL"""
    try:
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT 
                    b.id, b.name, b.description, b.is_public, b.total_price,
                    b.estimated_power, b.compatibility_score, b.build_type,
                    b.created_at, b.updated_at,
                    u.id as user_id, u.username as user_username
                FROM builds b
                JOIN users u ON b.user_id = u.id
                WHERE b.user_id = %s
                ORDER BY b.created_at DESC
            """, [user_id])
            
            columns = [col[0] for col in cursor.description]
            builds = [dict(zip(columns, row)) for row in cursor.fetchall()]
        
        return Response(builds)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
def get_build_details(request, build_id):
    """Get detailed build information including components using raw SQL"""
    try:
        with connection.cursor() as cursor:
            # Get build info
            cursor.execute("""
                SELECT 
                    b.id, b.name, b.description, b.is_public, b.total_price,
                    b.estimated_power, b.compatibility_score, b.build_type,
                    b.created_at, b.updated_at,
                    u.id as user_id, u.username as user_username
                FROM builds b
                JOIN users u ON b.user_id = u.id
                WHERE b.id = %s
            """, [build_id])
            
            build_columns = [col[0] for col in cursor.description]
            build_row = cursor.fetchone()
            
            if not build_row:
                return Response({'error': 'Build not found'}, status=status.HTTP_404_NOT_FOUND)
            
            build = dict(zip(build_columns, build_row))
            
            # Get build components
            cursor.execute("""
                SELECT 
                    bc.id, bc.quantity, bc.notes, bc.added_at,
                    c.id as component_id, c.name as component_name, c.model as component_model,
                    c.price as component_price, c.image_url as component_image,
                    c.specifications as component_specs, c.performance_score,
                    cat.name as category_name, cat.slug as category_slug,
                    v.name as vendor_name
                FROM build_components bc
                JOIN components c ON bc.component_id = c.id
                JOIN categories cat ON c.category_id = cat.id
                JOIN vendors v ON c.vendor_id = v.id
                WHERE bc.build_id = %s
                ORDER BY cat.sort_order, c.name
            """, [build_id])
            
            component_columns = [col[0] for col in cursor.description]
            components = []
            for row in cursor.fetchall():
                component = dict(zip(component_columns, row))
                if component['component_specs']:
                    component['component_specs'] = json.loads(component['component_specs'])
                components.append(component)
            
            build['components'] = components
        
        return Response(build)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
def search_components(request):
    """Search components using raw SQL"""
    try:
        query = request.GET.get('q', '')
        category = request.GET.get('category', '')
        min_price = request.GET.get('min_price')
        max_price = request.GET.get('max_price')
        
        if not query:
            return Response({'error': 'Search query is required'}, status=status.HTTP_400_BAD_REQUEST)
        
        sql_query = """
            SELECT 
                c.id, c.name, c.model, c.description, c.price, c.image_url, 
                c.stock_quantity, c.is_active, c.specifications, c.performance_score,
                c.power_consumption, c.socket_type, c.form_factor, c.memory_type,
                c.memory_speed, c.memory_capacity, c.storage_type, c.storage_capacity,
                c.power_rating, c.release_date, c.warranty_months, c.rating, c.review_count,
                c.created_at, c.updated_at,
                cat.id as category_id, cat.name as category_name, cat.slug as category_slug,
                v.id as vendor_id, v.name as vendor_name, v.website as vendor_website
            FROM components c
            JOIN categories cat ON c.category_id = cat.id
            JOIN vendors v ON c.vendor_id = v.id
            WHERE c.is_active = TRUE 
            AND (c.name ILIKE %s OR c.model ILIKE %s OR c.description ILIKE %s)
        """
        
        params = [f'%{query}%', f'%{query}%', f'%{query}%']
        
        if category:
            sql_query += " AND cat.slug = %s"
            params.append(category)
        
        if min_price:
            sql_query += " AND c.price >= %s"
            params.append(float(min_price))
        
        if max_price:
            sql_query += " AND c.price <= %s"
            params.append(float(max_price))
        
        sql_query += " ORDER BY c.performance_score DESC, c.price"
        
        with connection.cursor() as cursor:
            cursor.execute(sql_query, params)
            columns = [col[0] for col in cursor.description]
            components = []
            for row in cursor.fetchall():
                component = dict(zip(columns, row))
                if component['specifications']:
                    component['specifications'] = json.loads(component['specifications'])
                components.append(component)
        
        return Response(components)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
def get_compatibility_rules(request):
    """Get compatibility rules using raw SQL"""
    try:
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT 
                    cr.id, cr.rule_type, cr.condition, cr.severity, cr.description, cr.created_at,
                    sc.id as source_category_id, sc.name as source_category_name, sc.slug as source_category_slug,
                    tc.id as target_category_id, tc.name as target_category_name, tc.slug as target_category_slug
                FROM compatibility_rules cr
                JOIN categories sc ON cr.source_category_id = sc.id
                JOIN categories tc ON cr.target_category_id = tc.id
                ORDER BY sc.sort_order, tc.sort_order
            """)
            
            columns = [col[0] for col in cursor.description]
            rules = []
            for row in cursor.fetchall():
                rule = dict(zip(columns, row))
                if rule['condition']:
                    rule['condition'] = json.loads(rule['condition'])
                rules.append(rule)
        
        return Response(rules)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
