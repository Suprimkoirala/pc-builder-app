-- Compatibility Checking Functions
-- These functions check compatibility between different PC components

-- ========================================
-- COMPATIBILITY CHECKING FUNCTIONS
-- ========================================

-- Function to check CPU ↔ Motherboard compatibility (socket match)
CREATE OR REPLACE FUNCTION check_cpu_motherboard_compatibility(cpu_id INTEGER, motherboard_id INTEGER)
RETURNS JSONB AS $$
DECLARE
    cpu_socket VARCHAR(50);
    mobo_socket VARCHAR(50);
    result JSONB;
BEGIN
    -- Get socket types
    SELECT socket_type INTO cpu_socket FROM cpus WHERE id = cpu_id;
    SELECT socket_type INTO mobo_socket FROM motherboards WHERE id = motherboard_id;
    
    -- Check compatibility
    IF cpu_socket = mobo_socket THEN
        result := jsonb_build_object(
            'compatible', true,
            'message', 'CPU and motherboard sockets are compatible',
            'severity', 'success'
        );
    ELSE
        result := jsonb_build_object(
            'compatible', false,
            'message', format('Socket mismatch: CPU uses %s, motherboard uses %s', cpu_socket, mobo_socket),
            'severity', 'error'
        );
    END IF;
    
    RETURN result;
END;
$$ LANGUAGE plpgsql;

-- Function to check Motherboard ↔ RAM compatibility
CREATE OR REPLACE FUNCTION check_motherboard_ram_compatibility(motherboard_id INTEGER, ram_id INTEGER)
RETURNS JSONB AS $$
DECLARE
    mobo_ram_type VARCHAR(20);
    mobo_ram_slots INTEGER;
    mobo_max_speed INTEGER;
    ram_type VARCHAR(20);
    ram_speed INTEGER;
    ram_modules INTEGER;
    result JSONB;
BEGIN
    -- Get motherboard specs
    SELECT ram_type, ram_slots, max_ram_speed INTO mobo_ram_type, mobo_ram_slots, mobo_max_speed 
    FROM motherboards WHERE id = motherboard_id;
    
    -- Get RAM specs
    SELECT ram_type, speed, modules_in_kit INTO ram_type, ram_speed, ram_modules 
    FROM ram_modules WHERE id = ram_id;
    
    -- Check compatibility
    IF mobo_ram_type != ram_type THEN
        result := jsonb_build_object(
            'compatible', false,
            'message', format('RAM type mismatch: Motherboard supports %s, RAM is %s', mobo_ram_type, ram_type),
            'severity', 'error'
        );
    ELSIF ram_modules > mobo_ram_slots THEN
        result := jsonb_build_object(
            'compatible', false,
            'message', format('Not enough RAM slots: Motherboard has %s slots, RAM kit has %s modules', mobo_ram_slots, ram_modules),
            'severity', 'error'
        );
    ELSIF ram_speed > mobo_max_speed THEN
        result := jsonb_build_object(
            'compatible', false,
            'message', format('RAM speed too high: Motherboard max %s MHz, RAM is %s MHz', mobo_max_speed, ram_speed),
            'severity', 'warning'
        );
    ELSE
        result := jsonb_build_object(
            'compatible', true,
            'message', 'Motherboard and RAM are compatible',
            'severity', 'success'
        );
    END IF;
    
    RETURN result;
END;
$$ LANGUAGE plpgsql;

-- Function to check GPU ↔ Case compatibility (length)
CREATE OR REPLACE FUNCTION check_gpu_case_compatibility(gpu_id INTEGER, case_id INTEGER)
RETURNS JSONB AS $$
DECLARE
    gpu_length INTEGER;
    case_max_length INTEGER;
    result JSONB;
BEGIN
    -- Get dimensions
    SELECT length_mm INTO gpu_length FROM gpus WHERE id = gpu_id;
    SELECT max_gpu_length_mm INTO case_max_length FROM cases WHERE id = case_id;
    
    -- Check compatibility
    IF gpu_length <= case_max_length THEN
        result := jsonb_build_object(
            'compatible', true,
            'message', format('GPU fits in case: GPU length %s mm, case max %s mm', gpu_length, case_max_length),
            'severity', 'success'
        );
    ELSE
        result := jsonb_build_object(
            'compatible', false,
            'message', format('GPU too long: GPU length %s mm, case max %s mm', gpu_length, case_max_length),
            'severity', 'error'
        );
    END IF;
    
    RETURN result;
END;
$$ LANGUAGE plpgsql;

-- Function to check Case ↔ Motherboard compatibility (form factor)
CREATE OR REPLACE FUNCTION check_case_motherboard_compatibility(case_id INTEGER, motherboard_id INTEGER)
RETURNS JSONB AS $$
DECLARE
    case_form_factors TEXT[];
    mobo_form_factor VARCHAR(20);
    result JSONB;
BEGIN
    -- Get form factors
    SELECT motherboard_form_factors INTO case_form_factors FROM cases WHERE id = case_id;
    SELECT form_factor INTO mobo_form_factor FROM motherboards WHERE id = motherboard_id;
    
    -- Check compatibility
    IF mobo_form_factor = ANY(case_form_factors) THEN
        result := jsonb_build_object(
            'compatible', true,
            'message', format('Case supports motherboard form factor: %s', mobo_form_factor),
            'severity', 'success'
        );
    ELSE
        result := jsonb_build_object(
            'compatible', false,
            'message', format('Case does not support motherboard form factor: %s. Supported: %s', mobo_form_factor, array_to_string(case_form_factors, ', ')),
            'severity', 'error'
        );
    END IF;
    
    RETURN result;
END;
$$ LANGUAGE plpgsql;

-- Function to check PSU wattage requirements
CREATE OR REPLACE FUNCTION check_psu_wattage_compatibility(psu_id INTEGER, cpu_id INTEGER, gpu_id INTEGER)
RETURNS JSONB AS $$
DECLARE
    psu_wattage INTEGER;
    cpu_tdp INTEGER;
    gpu_tdp INTEGER;
    gpu_recommended_psu INTEGER;
    total_required INTEGER;
    result JSONB;
BEGIN
    -- Get power requirements
    SELECT wattage INTO psu_wattage FROM power_supplies WHERE id = psu_id;
    SELECT tdp INTO cpu_tdp FROM cpus WHERE id = cpu_id;
    SELECT tdp, recommended_psu_watts INTO gpu_tdp, gpu_recommended_psu FROM gpus WHERE id = gpu_id;
    
    -- Calculate total required (CPU + GPU + 100W headroom)
    total_required := COALESCE(cpu_tdp, 0) + COALESCE(gpu_tdp, 0) + 100;
    
    -- Use GPU recommended PSU if higher
    IF gpu_recommended_psu > total_required THEN
        total_required := gpu_recommended_psu;
    END IF;
    
    -- Check compatibility
    IF psu_wattage >= total_required THEN
        result := jsonb_build_object(
            'compatible', true,
            'message', format('PSU wattage sufficient: %s W available, %s W required', psu_wattage, total_required),
            'severity', 'success'
        );
    ELSE
        result := jsonb_build_object(
            'compatible', false,
            'message', format('PSU wattage insufficient: %s W available, %s W required', psu_wattage, total_required),
            'severity', 'error'
        );
    END IF;
    
    RETURN result;
END;
$$ LANGUAGE plpgsql;

-- Function to check Storage ↔ Motherboard compatibility
CREATE OR REPLACE FUNCTION check_storage_motherboard_compatibility(storage_id INTEGER, motherboard_id INTEGER)
RETURNS JSONB AS $$
DECLARE
    storage_interface VARCHAR(20);
    storage_form_factor VARCHAR(20);
    mobo_sata_ports INTEGER;
    mobo_m2_slots INTEGER;
    mobo_m2_pcie_slots INTEGER;
    result JSONB;
BEGIN
    -- Get storage specs
    SELECT interface, form_factor INTO storage_interface, storage_form_factor 
    FROM storage_devices WHERE id = storage_id;
    
    -- Get motherboard specs
    SELECT sata_ports, m2_slots, m2_pcie_slots INTO mobo_sata_ports, mobo_m2_slots, mobo_m2_pcie_slots 
    FROM motherboards WHERE id = motherboard_id;
    
    -- Check compatibility
    IF storage_interface = 'SATA' AND mobo_sata_ports > 0 THEN
        result := jsonb_build_object(
            'compatible', true,
            'message', format('SATA storage compatible: Motherboard has %s SATA ports', mobo_sata_ports),
            'severity', 'success'
        );
    ELSIF storage_interface = 'PCIe' AND storage_form_factor = 'M.2' AND mobo_m2_pcie_slots > 0 THEN
        result := jsonb_build_object(
            'compatible', true,
            'message', format('NVMe M.2 storage compatible: Motherboard has %s M.2 PCIe slots', mobo_m2_pcie_slots),
            'severity', 'success'
        );
    ELSIF storage_interface = 'PCIe' AND storage_form_factor = 'M.2' AND mobo_m2_slots > 0 THEN
        result := jsonb_build_object(
            'compatible', true,
            'message', format('M.2 storage compatible: Motherboard has %s M.2 slots', mobo_m2_slots),
            'severity', 'success'
        );
    ELSE
        result := jsonb_build_object(
            'compatible', false,
            'message', format('Storage interface not supported: %s %s not compatible with motherboard', storage_interface, storage_form_factor),
            'severity', 'error'
        );
    END IF;
    
    RETURN result;
END;
$$ LANGUAGE plpgsql;

-- Function to check Cooler ↔ Case compatibility (height)
CREATE OR REPLACE FUNCTION check_cooler_case_compatibility(cooler_id INTEGER, case_id INTEGER)
RETURNS JSONB AS $$
DECLARE
    cooler_height INTEGER;
    case_max_height INTEGER;
    result JSONB;
BEGIN
    -- Get dimensions
    SELECT height_mm INTO cooler_height FROM cpu_coolers WHERE id = cooler_id;
    SELECT max_cooler_height_mm INTO case_max_height FROM cases WHERE id = case_id;
    
    -- Check compatibility
    IF cooler_height <= case_max_height THEN
        result := jsonb_build_object(
            'compatible', true,
            'message', format('Cooler fits in case: Cooler height %s mm, case max %s mm', cooler_height, case_max_height),
            'severity', 'success'
        );
    ELSE
        result := jsonb_build_object(
            'compatible', false,
            'message', format('Cooler too tall: Cooler height %s mm, case max %s mm', cooler_height, case_max_height),
            'severity', 'error'
        );
    END IF;
    
    RETURN result;
END;
$$ LANGUAGE plpgsql;

-- Function to check Cooler ↔ CPU compatibility (socket support)
CREATE OR REPLACE FUNCTION check_cooler_cpu_compatibility(cooler_id INTEGER, cpu_id INTEGER)
RETURNS JSONB AS $$
DECLARE
    cooler_sockets TEXT[];
    cpu_socket VARCHAR(50);
    result JSONB;
BEGIN
    -- Get socket information
    SELECT socket_support INTO cooler_sockets FROM cpu_coolers WHERE id = cooler_id;
    SELECT socket_type INTO cpu_socket FROM cpus WHERE id = cpu_id;
    
    -- Check compatibility
    IF cpu_socket = ANY(cooler_sockets) THEN
        result := jsonb_build_object(
            'compatible', true,
            'message', format('Cooler supports CPU socket: %s', cpu_socket),
            'severity', 'success'
        );
    ELSE
        result := jsonb_build_object(
            'compatible', false,
            'message', format('Cooler does not support CPU socket: %s. Supported: %s', cpu_socket, array_to_string(cooler_sockets, ', ')),
            'severity', 'error'
        );
    END IF;
    
    RETURN result;
END;
$$ LANGUAGE plpgsql;

-- ========================================
-- COMPREHENSIVE BUILD COMPATIBILITY CHECK
-- ========================================

-- Function to check compatibility for an entire build
CREATE OR REPLACE FUNCTION check_build_compatibility(build_id INTEGER)
RETURNS JSONB AS $$
DECLARE
    build_parts RECORD;
    compatibility_results JSONB := '[]'::jsonb;
    result JSONB;
    cpu_id INTEGER := NULL;
    motherboard_id INTEGER := NULL;
    ram_id INTEGER := NULL;
    gpu_id INTEGER := NULL;
    case_id INTEGER := NULL;
    psu_id INTEGER := NULL;
    storage_id INTEGER := NULL;
    cooler_id INTEGER := NULL;
BEGIN
    -- Get all parts for the build
    FOR build_parts IN 
        SELECT part_type, part_id FROM build_parts WHERE build_id = $1
    LOOP
        CASE build_parts.part_type
            WHEN 'cpu' THEN cpu_id := build_parts.part_id;
            WHEN 'motherboard' THEN motherboard_id := build_parts.part_id;
            WHEN 'ram' THEN ram_id := build_parts.part_id;
            WHEN 'gpu' THEN gpu_id := build_parts.part_id;
            WHEN 'case' THEN case_id := build_parts.part_id;
            WHEN 'psu' THEN psu_id := build_parts.part_id;
            WHEN 'storage' THEN storage_id := build_parts.part_id;
            WHEN 'cooler' THEN cooler_id := build_parts.part_id;
        END CASE;
    END LOOP;
    
    -- Check CPU ↔ Motherboard compatibility
    IF cpu_id IS NOT NULL AND motherboard_id IS NOT NULL THEN
        result := check_cpu_motherboard_compatibility(cpu_id, motherboard_id);
        compatibility_results := compatibility_results || jsonb_build_object(
            'check', 'cpu_motherboard',
            'result', result
        );
    END IF;
    
    -- Check Motherboard ↔ RAM compatibility
    IF motherboard_id IS NOT NULL AND ram_id IS NOT NULL THEN
        result := check_motherboard_ram_compatibility(motherboard_id, ram_id);
        compatibility_results := compatibility_results || jsonb_build_object(
            'check', 'motherboard_ram',
            'result', result
        );
    END IF;
    
    -- Check GPU ↔ Case compatibility
    IF gpu_id IS NOT NULL AND case_id IS NOT NULL THEN
        result := check_gpu_case_compatibility(gpu_id, case_id);
        compatibility_results := compatibility_results || jsonb_build_object(
            'check', 'gpu_case',
            'result', result
        );
    END IF;
    
    -- Check Case ↔ Motherboard compatibility
    IF case_id IS NOT NULL AND motherboard_id IS NOT NULL THEN
        result := check_case_motherboard_compatibility(case_id, motherboard_id);
        compatibility_results := compatibility_results || jsonb_build_object(
            'check', 'case_motherboard',
            'result', result
        );
    END IF;
    
    -- Check PSU wattage requirements
    IF psu_id IS NOT NULL AND (cpu_id IS NOT NULL OR gpu_id IS NOT NULL) THEN
        result := check_psu_wattage_compatibility(psu_id, cpu_id, gpu_id);
        compatibility_results := compatibility_results || jsonb_build_object(
            'check', 'psu_wattage',
            'result', result
        );
    END IF;
    
    -- Check Storage ↔ Motherboard compatibility
    IF storage_id IS NOT NULL AND motherboard_id IS NOT NULL THEN
        result := check_storage_motherboard_compatibility(storage_id, motherboard_id);
        compatibility_results := compatibility_results || jsonb_build_object(
            'check', 'storage_motherboard',
            'result', result
        );
    END IF;
    
    -- Check Cooler ↔ Case compatibility
    IF cooler_id IS NOT NULL AND case_id IS NOT NULL THEN
        result := check_cooler_case_compatibility(cooler_id, case_id);
        compatibility_results := compatibility_results || jsonb_build_object(
            'check', 'cooler_case',
            'result', result
        );
    END IF;
    
    -- Check Cooler ↔ CPU compatibility
    IF cooler_id IS NOT NULL AND cpu_id IS NOT NULL THEN
        result := check_cooler_cpu_compatibility(cooler_id, cpu_id);
        compatibility_results := compatibility_results || jsonb_build_object(
            'check', 'cooler_cpu',
            'result', result
        );
    END IF;
    
    -- Return comprehensive results
    RETURN jsonb_build_object(
        'build_id', build_id,
        'checks', compatibility_results,
        'overall_compatible', NOT EXISTS(
            SELECT 1 FROM jsonb_array_elements(compatibility_results) AS check_result
            WHERE (check_result->'result'->>'compatible')::boolean = false
        )
    );
END;
$$ LANGUAGE plpgsql;

-- ========================================
-- HELPER FUNCTIONS
-- ========================================

-- Function to get component details for a build
CREATE OR REPLACE FUNCTION get_build_components(build_id INTEGER)
RETURNS JSONB AS $$
DECLARE
    result JSONB := '{}'::jsonb;
BEGIN
    -- Get CPU
    SELECT jsonb_build_object('id', c.id, 'name', c.name, 'model', c.model, 'price', c.price, 'socket_type', c.socket_type, 'tdp', c.tdp)
    INTO result
    FROM build_parts bp
    JOIN cpus c ON bp.part_id = c.id
    WHERE bp.build_id = $1 AND bp.part_type = 'cpu';
    
    -- Get Motherboard
    SELECT result || jsonb_build_object('motherboard', jsonb_build_object('id', m.id, 'name', m.name, 'model', m.model, 'price', m.price, 'socket_type', m.socket_type, 'form_factor', m.form_factor, 'ram_type', m.ram_type, 'ram_slots', m.ram_slots))
    INTO result
    FROM build_parts bp
    JOIN motherboards m ON bp.part_id = m.id
    WHERE bp.build_id = $1 AND bp.part_type = 'motherboard';
    
    -- Get RAM
    SELECT result || jsonb_build_object('ram', jsonb_build_object('id', r.id, 'name', r.name, 'model', r.model, 'price', r.price, 'ram_type', r.ram_type, 'speed', r.speed, 'modules_in_kit', r.modules_in_kit))
    INTO result
    FROM build_parts bp
    JOIN ram_modules r ON bp.part_id = r.id
    WHERE bp.build_id = $1 AND bp.part_type = 'ram';
    
    -- Get GPU
    SELECT result || jsonb_build_object('gpu', jsonb_build_object('id', g.id, 'name', g.name, 'model', g.model, 'price', g.price, 'length_mm', g.length_mm, 'tdp', g.tdp, 'recommended_psu_watts', g.recommended_psu_watts))
    INTO result
    FROM build_parts bp
    JOIN gpus g ON bp.part_id = g.id
    WHERE bp.build_id = $1 AND bp.part_type = 'gpu';
    
    -- Get Case
    SELECT result || jsonb_build_object('case', jsonb_build_object('id', cs.id, 'name', cs.name, 'model', cs.model, 'price', cs.price, 'max_gpu_length_mm', cs.max_gpu_length_mm, 'max_cooler_height_mm', cs.max_cooler_height_mm, 'motherboard_form_factors', cs.motherboard_form_factors))
    INTO result
    FROM build_parts bp
    JOIN cases cs ON bp.part_id = cs.id
    WHERE bp.build_id = $1 AND bp.part_type = 'case';
    
    -- Get PSU
    SELECT result || jsonb_build_object('psu', jsonb_build_object('id', p.id, 'name', p.name, 'model', p.model, 'price', p.price, 'wattage', p.wattage))
    INTO result
    FROM build_parts bp
    JOIN power_supplies p ON bp.part_id = p.id
    WHERE bp.build_id = $1 AND bp.part_type = 'psu';
    
    -- Get Storage
    SELECT result || jsonb_build_object('storage', jsonb_build_object('id', s.id, 'name', s.name, 'model', s.model, 'price', s.price, 'interface', s.interface, 'form_factor', s.form_factor))
    INTO result
    FROM build_parts bp
    JOIN storage_devices s ON bp.part_id = s.id
    WHERE bp.build_id = $1 AND bp.part_type = 'storage';
    
    -- Get Cooler
    SELECT result || jsonb_build_object('cooler', jsonb_build_object('id', cc.id, 'name', cc.name, 'model', cc.model, 'price', cc.price, 'height_mm', cc.height_mm, 'socket_support', cc.socket_support))
    INTO result
    FROM build_parts bp
    JOIN cpu_coolers cc ON bp.part_id = cc.id
    WHERE bp.build_id = $1 AND bp.part_type = 'cooler';
    
    RETURN result;
END;
$$ LANGUAGE plpgsql;
