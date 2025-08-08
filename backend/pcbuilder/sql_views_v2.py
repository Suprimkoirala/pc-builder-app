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

# ========================================
# VENDOR ENDPOINTS
# ========================================

@api_view(['GET'])
def get_vendors(request):
    """Get all vendors"""
    try:
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT id, name, website, logo_url, country, description, created_at, updated_at
                FROM vendors
                ORDER BY name
            """)
            columns = [col[0] for col in cursor.description]
            vendors = [dict(zip(columns, row)) for row in cursor.fetchall()]

        return Response(vendors)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

# ========================================
# CPU ENDPOINTS
# ========================================

@api_view(['GET'])
def get_cpus(request):
    """Get all CPUs with filtering options"""
    try:
        socket_type = request.GET.get('socket_type')
        min_price = request.GET.get('min_price')
        max_price = request.GET.get('max_price')
        vendor_id = request.GET.get('vendor_id')
        
        query = """
            SELECT c.*, v.name as vendor_name
            FROM cpus c
            JOIN vendors v ON c.vendor_id = v.id
            WHERE c.is_active = TRUE
        """
        params = []
        
        if socket_type:
            query += " AND c.socket_type = %s"
            params.append(socket_type)
        
        if min_price:
            query += " AND c.price >= %s"
            params.append(float(min_price))
        
        if max_price:
            query += " AND c.price <= %s"
            params.append(float(max_price))
        
        if vendor_id:
            query += " AND c.vendor_id = %s"
            params.append(int(vendor_id))
        
        query += " ORDER BY c.performance_score DESC, c.price"
        
        with connection.cursor() as cursor:
            cursor.execute(query, params)
            columns = [col[0] for col in cursor.description]
            cpus = [dict(zip(columns, row)) for row in cursor.fetchall()]

        return Response(cpus)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
def get_cpu_by_id(request, cpu_id):
    """Get specific CPU by ID"""
    try:
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT c.*, v.name as vendor_name
                FROM cpus c
                JOIN vendors v ON c.vendor_id = v.id
                WHERE c.id = %s AND c.is_active = TRUE
            """, [cpu_id])
            
            columns = [col[0] for col in cursor.description]
            cpu = dict(zip(columns, cursor.fetchone())) if cursor.fetchone() else None

        if not cpu:
            return Response({'error': 'CPU not found'}, status=status.HTTP_404_NOT_FOUND)

        return Response(cpu)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

# ========================================
# MOTHERBOARD ENDPOINTS
# ========================================

@api_view(['GET'])
def get_motherboards(request):
    """Get all motherboards with filtering options"""
    try:
        socket_type = request.GET.get('socket_type')
        form_factor = request.GET.get('form_factor')
        ram_type = request.GET.get('ram_type')
        min_price = request.GET.get('min_price')
        max_price = request.GET.get('max_price')
        vendor_id = request.GET.get('vendor_id')
        
        query = """
            SELECT m.*, v.name as vendor_name
            FROM motherboards m
            JOIN vendors v ON m.vendor_id = v.id
            WHERE m.is_active = TRUE
        """
        params = []
        
        if socket_type:
            query += " AND m.socket_type = %s"
            params.append(socket_type)
        
        if form_factor:
            query += " AND m.form_factor = %s"
            params.append(form_factor)
        
        if ram_type:
            query += " AND m.ram_type = %s"
            params.append(ram_type)
        
        if min_price:
            query += " AND m.price >= %s"
            params.append(float(min_price))
        
        if max_price:
            query += " AND m.price <= %s"
            params.append(float(max_price))
        
        if vendor_id:
            query += " AND m.vendor_id = %s"
            params.append(int(vendor_id))
        
        query += " ORDER BY m.performance_score DESC, m.price"
        
        with connection.cursor() as cursor:
            cursor.execute(query, params)
            columns = [col[0] for col in cursor.description]
            motherboards = [dict(zip(columns, row)) for row in cursor.fetchall()]

        return Response(motherboards)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

# ========================================
# RAM ENDPOINTS
# ========================================

@api_view(['GET'])
def get_ram_modules(request):
    """Get all RAM modules with filtering options"""
    try:
        ram_type = request.GET.get('ram_type')
        capacity = request.GET.get('capacity')
        min_speed = request.GET.get('min_speed')
        max_speed = request.GET.get('max_speed')
        min_price = request.GET.get('min_price')
        max_price = request.GET.get('max_price')
        vendor_id = request.GET.get('vendor_id')
        
        query = """
            SELECT r.*, v.name as vendor_name
            FROM ram_modules r
            JOIN vendors v ON r.vendor_id = v.id
            WHERE r.is_active = TRUE
        """
        params = []
        
        if ram_type:
            query += " AND r.ram_type = %s"
            params.append(ram_type)
        
        if capacity:
            query += " AND r.capacity = %s"
            params.append(int(capacity))
        
        if min_speed:
            query += " AND r.speed >= %s"
            params.append(int(min_speed))
        
        if max_speed:
            query += " AND r.speed <= %s"
            params.append(int(max_speed))
        
        if min_price:
            query += " AND r.price >= %s"
            params.append(float(min_price))
        
        if max_price:
            query += " AND r.price <= %s"
            params.append(float(max_price))
        
        if vendor_id:
            query += " AND r.vendor_id = %s"
            params.append(int(vendor_id))
        
        query += " ORDER BY r.performance_score DESC, r.price"
        
        with connection.cursor() as cursor:
            cursor.execute(query, params)
            columns = [col[0] for col in cursor.description]
            ram_modules = [dict(zip(columns, row)) for row in cursor.fetchall()]

        return Response(ram_modules)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

# ========================================
# GPU ENDPOINTS
# ========================================

@api_view(['GET'])
def get_gpus(request):
    """Get all GPUs with filtering options"""
    try:
        min_memory = request.GET.get('min_memory')
        max_memory = request.GET.get('max_memory')
        min_price = request.GET.get('min_price')
        max_price = request.GET.get('max_price')
        vendor_id = request.GET.get('vendor_id')
        ray_tracing = request.GET.get('ray_tracing')
        
        query = """
            SELECT g.*, v.name as vendor_name
            FROM gpus g
            JOIN vendors v ON g.vendor_id = v.id
            WHERE g.is_active = TRUE
        """
        params = []
        
        if min_memory:
            query += " AND g.memory_size >= %s"
            params.append(int(min_memory))
        
        if max_memory:
            query += " AND g.memory_size <= %s"
            params.append(int(max_memory))
        
        if min_price:
            query += " AND g.price >= %s"
            params.append(float(min_price))
        
        if max_price:
            query += " AND g.price <= %s"
            params.append(float(max_price))
        
        if vendor_id:
            query += " AND g.vendor_id = %s"
            params.append(int(vendor_id))
        
        if ray_tracing:
            query += " AND g.ray_tracing = %s"
            params.append(ray_tracing.lower() == 'true')
        
        query += " ORDER BY g.performance_score DESC, g.price"
        
        with connection.cursor() as cursor:
            cursor.execute(query, params)
            columns = [col[0] for col in cursor.description]
            gpus = [dict(zip(columns, row)) for row in cursor.fetchall()]

        return Response(gpus)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

# ========================================
# STORAGE ENDPOINTS
# ========================================

@api_view(['GET'])
def get_storage_devices(request):
    """Get all storage devices with filtering options"""
    try:
        storage_type = request.GET.get('storage_type')
        interface = request.GET.get('interface')
        min_capacity = request.GET.get('min_capacity')
        max_capacity = request.GET.get('max_capacity')
        min_price = request.GET.get('min_price')
        max_price = request.GET.get('max_price')
        vendor_id = request.GET.get('vendor_id')
        
        query = """
            SELECT s.*, v.name as vendor_name
            FROM storage_devices s
            JOIN vendors v ON s.vendor_id = v.id
            WHERE s.is_active = TRUE
        """
        params = []
        
        if storage_type:
            query += " AND s.storage_type = %s"
            params.append(storage_type)
        
        if interface:
            query += " AND s.interface = %s"
            params.append(interface)
        
        if min_capacity:
            query += " AND s.capacity >= %s"
            params.append(int(min_capacity))
        
        if max_capacity:
            query += " AND s.capacity <= %s"
            params.append(int(max_capacity))
        
        if min_price:
            query += " AND s.price >= %s"
            params.append(float(min_price))
        
        if max_price:
            query += " AND s.price <= %s"
            params.append(float(max_price))
        
        if vendor_id:
            query += " AND s.vendor_id = %s"
            params.append(int(vendor_id))
        
        query += " ORDER BY s.performance_score DESC, s.price"
        
        with connection.cursor() as cursor:
            cursor.execute(query, params)
            columns = [col[0] for col in cursor.description]
            storage_devices = [dict(zip(columns, row)) for row in cursor.fetchall()]

        return Response(storage_devices)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

# ========================================
# POWER SUPPLY ENDPOINTS
# ========================================

@api_view(['GET'])
def get_power_supplies(request):
    """Get all power supplies with filtering options"""
    try:
        min_wattage = request.GET.get('min_wattage')
        max_wattage = request.GET.get('max_wattage')
        efficiency_rating = request.GET.get('efficiency_rating')
        modular_type = request.GET.get('modular_type')
        min_price = request.GET.get('min_price')
        max_price = request.GET.get('max_price')
        vendor_id = request.GET.get('vendor_id')
        
        query = """
            SELECT p.*, v.name as vendor_name
            FROM power_supplies p
            JOIN vendors v ON p.vendor_id = v.id
            WHERE p.is_active = TRUE
        """
        params = []
        
        if min_wattage:
            query += " AND p.wattage >= %s"
            params.append(int(min_wattage))
        
        if max_wattage:
            query += " AND p.wattage <= %s"
            params.append(int(max_wattage))
        
        if efficiency_rating:
            query += " AND p.efficiency_rating = %s"
            params.append(efficiency_rating)
        
        if modular_type:
            query += " AND p.modular_type = %s"
            params.append(modular_type)
        
        if min_price:
            query += " AND p.price >= %s"
            params.append(float(min_price))
        
        if max_price:
            query += " AND p.price <= %s"
            params.append(float(max_price))
        
        if vendor_id:
            query += " AND p.vendor_id = %s"
            params.append(int(vendor_id))
        
        query += " ORDER BY p.wattage DESC, p.price"
        
        with connection.cursor() as cursor:
            cursor.execute(query, params)
            columns = [col[0] for col in cursor.description]
            power_supplies = [dict(zip(columns, row)) for row in cursor.fetchall()]

        return Response(power_supplies)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

# ========================================
# CASE ENDPOINTS
# ========================================

@api_view(['GET'])
def get_cases(request):
    """Get all cases with filtering options"""
    try:
        form_factor = request.GET.get('form_factor')
        min_gpu_length = request.GET.get('min_gpu_length')
        max_gpu_length = request.GET.get('max_gpu_length')
        min_price = request.GET.get('min_price')
        max_price = request.GET.get('max_price')
        vendor_id = request.GET.get('vendor_id')
        side_panel_type = request.GET.get('side_panel_type')
        
        query = """
            SELECT c.*, v.name as vendor_name
            FROM cases c
            JOIN vendors v ON c.vendor_id = v.id
            WHERE c.is_active = TRUE
        """
        params = []
        
        if form_factor:
            query += " AND %s = ANY(c.motherboard_form_factors)"
            params.append(form_factor)
        
        if min_gpu_length:
            query += " AND c.max_gpu_length_mm >= %s"
            params.append(int(min_gpu_length))
        
        if max_gpu_length:
            query += " AND c.max_gpu_length_mm <= %s"
            params.append(int(max_gpu_length))
        
        if min_price:
            query += " AND c.price >= %s"
            params.append(float(min_price))
        
        if max_price:
            query += " AND c.price <= %s"
            params.append(float(max_price))
        
        if vendor_id:
            query += " AND c.vendor_id = %s"
            params.append(int(vendor_id))
        
        if side_panel_type:
            query += " AND c.side_panel_type = %s"
            params.append(side_panel_type)
        
        query += " ORDER BY c.airflow_score DESC, c.price"
        
        with connection.cursor() as cursor:
            cursor.execute(query, params)
            columns = [col[0] for col in cursor.description]
            cases = [dict(zip(columns, row)) for row in cursor.fetchall()]

        return Response(cases)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

# ========================================
# CPU COOLER ENDPOINTS
# ========================================

@api_view(['GET'])
def get_cpu_coolers(request):
    """Get all CPU coolers with filtering options"""
    try:
        cooler_type = request.GET.get('cooler_type')
        socket_type = request.GET.get('socket_type')
        min_tdp = request.GET.get('min_tdp')
        max_tdp = request.GET.get('max_tdp')
        min_price = request.GET.get('min_price')
        max_price = request.GET.get('max_price')
        vendor_id = request.GET.get('vendor_id')
        
        query = """
            SELECT cc.*, v.name as vendor_name
            FROM cpu_coolers cc
            JOIN vendors v ON cc.vendor_id = v.id
            WHERE cc.is_active = TRUE
        """
        params = []
        
        if cooler_type:
            query += " AND cc.cooler_type = %s"
            params.append(cooler_type)
        
        if socket_type:
            query += " AND %s = ANY(cc.socket_support)"
            params.append(socket_type)
        
        if min_tdp:
            query += " AND cc.tdp_rating >= %s"
            params.append(int(min_tdp))
        
        if max_tdp:
            query += " AND cc.tdp_rating <= %s"
            params.append(int(max_tdp))
        
        if min_price:
            query += " AND cc.price >= %s"
            params.append(float(min_price))
        
        if max_price:
            query += " AND cc.price <= %s"
            params.append(float(max_price))
        
        if vendor_id:
            query += " AND cc.vendor_id = %s"
            params.append(int(vendor_id))
        
        query += " ORDER BY cc.performance_score DESC, cc.price"
        
        with connection.cursor() as cursor:
            cursor.execute(query, params)
            columns = [col[0] for col in cursor.description]
            cpu_coolers = [dict(zip(columns, row)) for row in cursor.fetchall()]

        return Response(cpu_coolers)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

# ========================================
# BUILD MANAGEMENT
# ========================================

@api_view(['POST'])
def create_build(request):
    """Create a new build"""
    try:
        user_id = request.data.get('user_id')
        name = request.data.get('name')
        description = request.data.get('description', '')
        parts = request.data.get('parts', [])  # List of {part_type, part_id, quantity}
        
        if not user_id or not name:
            return Response({'error': 'user_id and name are required'}, status=status.HTTP_400_BAD_REQUEST)
        
        with connection.cursor() as cursor:
            # Create build
            cursor.execute("""
                INSERT INTO builds (user_id, name, description)
                VALUES (%s, %s, %s)
                RETURNING id
            """, [user_id, name, description])
            
            build_id = cursor.fetchone()[0]
            
            # Add parts to build
            for part in parts:
                cursor.execute("""
                    INSERT INTO build_parts (build_id, part_type, part_id, quantity)
                    VALUES (%s, %s, %s, %s)
                """, [build_id, part['part_type'], part['part_id'], part.get('quantity', 1)])
            
            connection.commit()
            
            return Response({'build_id': build_id, 'message': 'Build created successfully'}, status=status.HTTP_201_CREATED)
            
    except Exception as e:
        connection.rollback()
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
def get_user_builds(request, user_id):
    """Get all builds for a user"""
    try:
        with connection.cursor() as cursor:
            cursor.execute("""
                SELECT b.*, 
                       COUNT(bp.id) as part_count,
                       b.total_price
                FROM builds b
                LEFT JOIN build_parts bp ON b.id = bp.build_id
                WHERE b.user_id = %s
                GROUP BY b.id
                ORDER BY b.created_at DESC
            """, [user_id])
            
            columns = [col[0] for col in cursor.description]
            builds = [dict(zip(columns, row)) for row in cursor.fetchall()]

        return Response(builds)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
def get_build_details(request, build_id):
    """Get detailed build information with parts and compatibility"""
    try:
        with connection.cursor() as cursor:
            # Get build info
            cursor.execute("""
                SELECT b.*, u.username as user_name
                FROM builds b
                JOIN users u ON b.user_id = u.id
                WHERE b.id = %s
            """, [build_id])
            
            build_columns = [col[0] for col in cursor.description]
            build = dict(zip(build_columns, cursor.fetchone())) if cursor.fetchone() else None
            
            if not build:
                return Response({'error': 'Build not found'}, status=status.HTTP_404_NOT_FOUND)
            
            # Get build parts with component details
            cursor.execute("""
                SELECT bp.*, 
                       CASE 
                           WHEN bp.part_type = 'cpu' THEN c.name
                           WHEN bp.part_type = 'motherboard' THEN m.name
                           WHEN bp.part_type = 'ram' THEN r.name
                           WHEN bp.part_type = 'gpu' THEN g.name
                           WHEN bp.part_type = 'storage' THEN s.name
                           WHEN bp.part_type = 'psu' THEN p.name
                           WHEN bp.part_type = 'case' THEN cs.name
                           WHEN bp.part_type = 'cooler' THEN cc.name
                       END as component_name,
                       CASE 
                           WHEN bp.part_type = 'cpu' THEN c.price
                           WHEN bp.part_type = 'motherboard' THEN m.price
                           WHEN bp.part_type = 'ram' THEN r.price
                           WHEN bp.part_type = 'gpu' THEN g.price
                           WHEN bp.part_type = 'storage' THEN s.price
                           WHEN bp.part_type = 'psu' THEN p.price
                           WHEN bp.part_type = 'case' THEN cs.price
                           WHEN bp.part_type = 'cooler' THEN cc.price
                       END as component_price
                FROM build_parts bp
                LEFT JOIN cpus c ON bp.part_type = 'cpu' AND bp.part_id = c.id
                LEFT JOIN motherboards m ON bp.part_type = 'motherboard' AND bp.part_id = m.id
                LEFT JOIN ram_modules r ON bp.part_type = 'ram' AND bp.part_id = r.id
                LEFT JOIN gpus g ON bp.part_type = 'gpu' AND bp.part_id = g.id
                LEFT JOIN storage_devices s ON bp.part_type = 'storage' AND bp.part_id = s.id
                LEFT JOIN power_supplies p ON bp.part_type = 'psu' AND bp.part_id = p.id
                LEFT JOIN cases cs ON bp.part_type = 'case' AND bp.part_id = cs.id
                LEFT JOIN cpu_coolers cc ON bp.part_type = 'cooler' AND bp.part_id = cc.id
                WHERE bp.build_id = %s
                ORDER BY bp.part_type
            """, [build_id])
            
            parts_columns = [col[0] for col in cursor.description]
            parts = [dict(zip(parts_columns, row)) for row in cursor.fetchall()]
            
            # Check compatibility
            cursor.execute("SELECT check_build_compatibility(%s)", [build_id])
            compatibility_result = cursor.fetchone()[0]
            
            build['parts'] = parts
            build['compatibility'] = compatibility_result

        return Response(build)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

# ========================================
# COMPATIBILITY ENDPOINTS
# ========================================

@api_view(['GET'])
def check_compatibility(request):
    """Check compatibility between specific components"""
    try:
        cpu_id = request.GET.get('cpu_id')
        motherboard_id = request.GET.get('motherboard_id')
        ram_id = request.GET.get('ram_id')
        gpu_id = request.GET.get('gpu_id')
        case_id = request.GET.get('case_id')
        psu_id = request.GET.get('psu_id')
        storage_id = request.GET.get('storage_id')
        cooler_id = request.GET.get('cooler_id')
        
        results = {}
        
        with connection.cursor() as cursor:
            if cpu_id and motherboard_id:
                cursor.execute("SELECT check_cpu_motherboard_compatibility(%s, %s)", [cpu_id, motherboard_id])
                results['cpu_motherboard'] = cursor.fetchone()[0]
            
            if motherboard_id and ram_id:
                cursor.execute("SELECT check_motherboard_ram_compatibility(%s, %s)", [motherboard_id, ram_id])
                results['motherboard_ram'] = cursor.fetchone()[0]
            
            if gpu_id and case_id:
                cursor.execute("SELECT check_gpu_case_compatibility(%s, %s)", [gpu_id, case_id])
                results['gpu_case'] = cursor.fetchone()[0]
            
            if case_id and motherboard_id:
                cursor.execute("SELECT check_case_motherboard_compatibility(%s, %s)", [case_id, motherboard_id])
                results['case_motherboard'] = cursor.fetchone()[0]
            
            if psu_id and (cpu_id or gpu_id):
                cursor.execute("SELECT check_psu_wattage_compatibility(%s, %s, %s)", [psu_id, cpu_id, gpu_id])
                results['psu_wattage'] = cursor.fetchone()[0]
            
            if storage_id and motherboard_id:
                cursor.execute("SELECT check_storage_motherboard_compatibility(%s, %s)", [storage_id, motherboard_id])
                results['storage_motherboard'] = cursor.fetchone()[0]
            
            if cooler_id and case_id:
                cursor.execute("SELECT check_cooler_case_compatibility(%s, %s)", [cooler_id, case_id])
                results['cooler_case'] = cursor.fetchone()[0]
            
            if cooler_id and cpu_id:
                cursor.execute("SELECT check_cooler_cpu_compatibility(%s, %s)", [cooler_id, cpu_id])
                results['cooler_cpu'] = cursor.fetchone()[0]

        return Response(results)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

# ========================================
# SEARCH ENDPOINTS
# ========================================

@api_view(['GET'])
def search_components(request):
    """Search across all component types"""
    try:
        query = request.GET.get('q', '')
        component_type = request.GET.get('type', 'all')  # all, cpu, motherboard, etc.
        
        if not query:
            return Response({'error': 'Search query is required'}, status=status.HTTP_400_BAD_REQUEST)
        
        search_term = f"%{query}%"
        results = {}
        
        with connection.cursor() as cursor:
            if component_type in ['all', 'cpu']:
                cursor.execute("""
                    SELECT 'cpu' as type, id, name, model, price, performance_score, socket_type
                    FROM cpus 
                    WHERE (name ILIKE %s OR model ILIKE %s) AND is_active = TRUE
                    ORDER BY performance_score DESC
                    LIMIT 10
                """, [search_term, search_term])
                results['cpus'] = [dict(zip(['type', 'id', 'name', 'model', 'price', 'performance_score', 'socket_type'], row)) 
                                 for row in cursor.fetchall()]
            
            if component_type in ['all', 'motherboard']:
                cursor.execute("""
                    SELECT 'motherboard' as type, id, name, model, price, performance_score, socket_type, form_factor
                    FROM motherboards 
                    WHERE (name ILIKE %s OR model ILIKE %s) AND is_active = TRUE
                    ORDER BY performance_score DESC
                    LIMIT 10
                """, [search_term, search_term])
                results['motherboards'] = [dict(zip(['type', 'id', 'name', 'model', 'price', 'performance_score', 'socket_type', 'form_factor'], row)) 
                                         for row in cursor.fetchall()]
            
            if component_type in ['all', 'gpu']:
                cursor.execute("""
                    SELECT 'gpu' as type, id, name, model, price, performance_score, memory_size, chipset
                    FROM gpus 
                    WHERE (name ILIKE %s OR model ILIKE %s) AND is_active = TRUE
                    ORDER BY performance_score DESC
                    LIMIT 10
                """, [search_term, search_term])
                results['gpus'] = [dict(zip(['type', 'id', 'name', 'model', 'price', 'performance_score', 'memory_size', 'chipset'], row)) 
                                 for row in cursor.fetchall()]

        return Response(results)
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
