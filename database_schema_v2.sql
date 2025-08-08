-- PC Builder Database Schema v2.0
-- Separate tables for each component type with comprehensive compatibility checks

-- Users table (extended from Django auth)
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(150) UNIQUE NOT NULL,
    email VARCHAR(254) UNIQUE NOT NULL,
    password_hash VARCHAR(128) NOT NULL,
    first_name VARCHAR(150),
    last_name VARCHAR(150),
    bio TEXT,
    avatar_url VARCHAR(500),
    is_pro_builder BOOLEAN DEFAULT FALSE,
    is_staff BOOLEAN DEFAULT FALSE,
    is_superuser BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    date_joined TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Vendors table
CREATE TABLE vendors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    website VARCHAR(500),
    logo_url VARCHAR(500),
    country VARCHAR(100),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================================
-- COMPONENT TABLES
-- ========================================

-- CPUs (Processors)
CREATE TABLE cpus (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    model VARCHAR(100) NOT NULL,
    vendor_id INTEGER REFERENCES vendors(id),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    image_url VARCHAR(500),
    description TEXT,
    
    -- CPU Specifications
    socket_type VARCHAR(50) NOT NULL, -- LGA1700, AM4, AM5, etc.
    cores INTEGER NOT NULL,
    threads INTEGER NOT NULL,
    base_clock DECIMAL(4,2) NOT NULL, -- GHz
    boost_clock DECIMAL(4,2) NOT NULL, -- GHz
    cache_size VARCHAR(20) NOT NULL, -- e.g., "36MB"
    tdp INTEGER NOT NULL, -- Thermal Design Power in watts
    architecture VARCHAR(50) NOT NULL, -- e.g., "Raptor Lake", "Zen 4"
    process_node VARCHAR(20) NOT NULL, -- e.g., "10nm", "5nm"
    integrated_graphics BOOLEAN DEFAULT FALSE,
    overclockable BOOLEAN DEFAULT FALSE,
    
    -- Performance metrics
    performance_score DECIMAL(3,1) CHECK (performance_score >= 0 AND performance_score <= 10),
    gaming_score DECIMAL(3,1) CHECK (gaming_score >= 0 AND gaming_score <= 10),
    productivity_score DECIMAL(3,1) CHECK (productivity_score >= 0 AND productivity_score <= 10),
    
    -- Additional info
    release_date DATE,
    rating DECIMAL(2,1) DEFAULT 0 CHECK (rating >= 0 AND rating <= 5),
    review_count INTEGER DEFAULT 0,
    stock_quantity INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Motherboards
CREATE TABLE motherboards (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    model VARCHAR(100) NOT NULL,
    vendor_id INTEGER REFERENCES vendors(id),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    image_url VARCHAR(500),
    description TEXT,
    
    -- Socket and Form Factor
    socket_type VARCHAR(50) NOT NULL, -- Must match CPU socket
    form_factor VARCHAR(20) NOT NULL, -- ATX, mATX, ITX, etc.
    
    -- Memory Support
    ram_type VARCHAR(20) NOT NULL, -- DDR4, DDR5
    ram_slots INTEGER NOT NULL, -- Number of RAM slots
    max_ram_capacity VARCHAR(20) NOT NULL, -- e.g., "128GB"
    max_ram_speed INTEGER NOT NULL, -- MHz
    
    -- Expansion Slots
    pcie_slots INTEGER DEFAULT 0,
    pcie_x16_slots INTEGER DEFAULT 0,
    pcie_x8_slots INTEGER DEFAULT 0,
    pcie_x4_slots INTEGER DEFAULT 0,
    pcie_x1_slots INTEGER DEFAULT 0,
    
    -- Storage
    sata_ports INTEGER DEFAULT 0,
    m2_slots INTEGER DEFAULT 0,
    m2_pcie_slots INTEGER DEFAULT 0, -- NVMe slots
    
    -- Connectivity
    usb_ports INTEGER DEFAULT 0,
    usb_3_2_ports INTEGER DEFAULT 0,
    usb_3_1_ports INTEGER DEFAULT 0,
    usb_2_0_ports INTEGER DEFAULT 0,
    ethernet_ports INTEGER DEFAULT 1,
    wifi BOOLEAN DEFAULT FALSE,
    bluetooth BOOLEAN DEFAULT FALSE,
    
    -- Power
    power_connector VARCHAR(50) NOT NULL, -- e.g., "24-pin + 8-pin"
    
    -- Performance
    performance_score DECIMAL(3,1) CHECK (performance_score >= 0 AND performance_score <= 10),
    overclocking_score DECIMAL(3,1) CHECK (overclocking_score >= 0 AND overclocking_score <= 10),
    
    -- Additional info
    release_date DATE,
    rating DECIMAL(2,1) DEFAULT 0 CHECK (rating >= 0 AND rating <= 5),
    review_count INTEGER DEFAULT 0,
    stock_quantity INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- RAM (Memory)
CREATE TABLE ram_modules (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    model VARCHAR(100) NOT NULL,
    vendor_id INTEGER REFERENCES vendors(id),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    image_url VARCHAR(500),
    description TEXT,
    
    -- Memory Specifications
    capacity INTEGER NOT NULL, -- GB per module
    capacity_per_module INTEGER NOT NULL, -- GB per individual stick
    modules_in_kit INTEGER NOT NULL, -- Number of sticks in kit
    ram_type VARCHAR(20) NOT NULL, -- DDR4, DDR5
    speed INTEGER NOT NULL, -- MHz
    cas_latency INTEGER NOT NULL, -- CL
    voltage DECIMAL(3,2) NOT NULL, -- V
    
    -- Physical
    form_factor VARCHAR(20) NOT NULL, -- DIMM, SODIMM
    height_mm INTEGER,
    
    -- Features
    rgb BOOLEAN DEFAULT FALSE,
    heatsink BOOLEAN DEFAULT TRUE,
    ecc BOOLEAN DEFAULT FALSE,
    
    -- Performance
    performance_score DECIMAL(3,1) CHECK (performance_score >= 0 AND performance_score <= 10),
    
    -- Additional info
    release_date DATE,
    rating DECIMAL(2,1) DEFAULT 0 CHECK (rating >= 0 AND rating <= 5),
    review_count INTEGER DEFAULT 0,
    stock_quantity INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- GPUs (Graphics Cards)
CREATE TABLE gpus (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    model VARCHAR(100) NOT NULL,
    vendor_id INTEGER REFERENCES vendors(id),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    image_url VARCHAR(500),
    description TEXT,
    
    -- GPU Specifications
    chipset VARCHAR(100) NOT NULL, -- e.g., "RTX 4090", "RX 7900 XTX"
    memory_size INTEGER NOT NULL, -- GB
    memory_type VARCHAR(20) NOT NULL, -- GDDR6, GDDR6X, HBM2, etc.
    memory_bus_width INTEGER NOT NULL, -- bits
    base_clock INTEGER NOT NULL, -- MHz
    boost_clock INTEGER NOT NULL, -- MHz
    
    -- Physical Dimensions
    length_mm INTEGER NOT NULL,
    width_mm INTEGER NOT NULL,
    height_mm INTEGER NOT NULL,
    slot_width INTEGER NOT NULL, -- Number of PCIe slots it occupies
    
    -- Power
    tdp INTEGER NOT NULL, -- Watts
    power_connector VARCHAR(100) NOT NULL, -- e.g., "8-pin + 8-pin"
    recommended_psu_watts INTEGER NOT NULL,
    
    -- Performance
    performance_score DECIMAL(3,1) CHECK (performance_score >= 0 AND performance_score <= 10),
    gaming_score DECIMAL(3,1) CHECK (gaming_score >= 0 AND gaming_score <= 10),
    mining_score DECIMAL(3,1) CHECK (mining_score >= 0 AND mining_score <= 10),
    
    -- Features
    ray_tracing BOOLEAN DEFAULT FALSE,
    dlss BOOLEAN DEFAULT FALSE,
    fsr BOOLEAN DEFAULT FALSE,
    
    -- Additional info
    release_date DATE,
    rating DECIMAL(2,1) DEFAULT 0 CHECK (rating >= 0 AND rating <= 5),
    review_count INTEGER DEFAULT 0,
    stock_quantity INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Storage Devices
CREATE TABLE storage_devices (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    model VARCHAR(100) NOT NULL,
    vendor_id INTEGER REFERENCES vendors(id),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    image_url VARCHAR(500),
    description TEXT,
    
    -- Storage Specifications
    capacity INTEGER NOT NULL, -- GB
    storage_type VARCHAR(20) NOT NULL, -- SSD, HDD, NVMe
    interface VARCHAR(20) NOT NULL, -- SATA, PCIe, M.2
    form_factor VARCHAR(20) NOT NULL, -- 2.5", 3.5", M.2, etc.
    
    -- Performance
    read_speed INTEGER, -- MB/s
    write_speed INTEGER, -- MB/s
    random_read_iops INTEGER,
    random_write_iops INTEGER,
    
    -- Physical
    height_mm INTEGER,
    width_mm INTEGER,
    depth_mm INTEGER,
    
    -- Features
    cache_size VARCHAR(20), -- e.g., "2GB"
    nand_type VARCHAR(50), -- e.g., "TLC", "QLC"
    endurance_tbw INTEGER, -- Terabytes Written
    
    -- Performance
    performance_score DECIMAL(3,1) CHECK (performance_score >= 0 AND performance_score <= 10),
    
    -- Additional info
    release_date DATE,
    rating DECIMAL(2,1) DEFAULT 0 CHECK (rating >= 0 AND rating <= 5),
    review_count INTEGER DEFAULT 0,
    stock_quantity INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Power Supplies
CREATE TABLE power_supplies (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    model VARCHAR(100) NOT NULL,
    vendor_id INTEGER REFERENCES vendors(id),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    image_url VARCHAR(500),
    description TEXT,
    
    -- Power Specifications
    wattage INTEGER NOT NULL, -- Watts
    efficiency_rating VARCHAR(20) NOT NULL, -- 80+ Bronze, Gold, Platinum, etc.
    modular_type VARCHAR(20) NOT NULL, -- Full, Semi, Non-modular
    
    -- Connectors
    atx_24pin INTEGER DEFAULT 1,
    cpu_4pin INTEGER DEFAULT 0,
    cpu_8pin INTEGER DEFAULT 0,
    cpu_4_4pin INTEGER DEFAULT 0, -- 4+4 pin
    pcie_6pin INTEGER DEFAULT 0,
    pcie_8pin INTEGER DEFAULT 0,
    pcie_6_2pin INTEGER DEFAULT 0, -- 6+2 pin
    sata_connectors INTEGER DEFAULT 0,
    molex_connectors INTEGER DEFAULT 0,
    
    -- Physical
    form_factor VARCHAR(20) NOT NULL, -- ATX, SFX, etc.
    height_mm INTEGER,
    width_mm INTEGER,
    depth_mm INTEGER,
    
    -- Features
    fanless BOOLEAN DEFAULT FALSE,
    rgb BOOLEAN DEFAULT FALSE,
    overvoltage_protection BOOLEAN DEFAULT TRUE,
    undervoltage_protection BOOLEAN DEFAULT TRUE,
    short_circuit_protection BOOLEAN DEFAULT TRUE,
    
    -- Performance
    performance_score DECIMAL(3,1) CHECK (performance_score >= 0 AND performance_score <= 10),
    efficiency_score DECIMAL(3,1) CHECK (efficiency_score >= 0 AND efficiency_score <= 10),
    
    -- Additional info
    release_date DATE,
    rating DECIMAL(2,1) DEFAULT 0 CHECK (rating >= 0 AND rating <= 5),
    review_count INTEGER DEFAULT 0,
    stock_quantity INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Cases
CREATE TABLE cases (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    model VARCHAR(100) NOT NULL,
    vendor_id INTEGER REFERENCES vendors(id),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    image_url VARCHAR(500),
    description TEXT,
    
    -- Form Factor Support
    motherboard_form_factors JSON NOT NULL, -- Array of supported form factors
    
    -- Physical Dimensions
    height_mm INTEGER NOT NULL,
    width_mm INTEGER NOT NULL,
    depth_mm INTEGER NOT NULL,
    volume_liters DECIMAL(6,2),
    
    -- GPU Support
    max_gpu_length_mm INTEGER NOT NULL,
    max_gpu_width_mm INTEGER,
    max_gpu_height_mm INTEGER,
    
    -- CPU Cooler Support
    max_cooler_height_mm INTEGER NOT NULL,
    
    -- Storage Support
    drive_bays_3_5 INTEGER DEFAULT 0,
    drive_bays_2_5 INTEGER DEFAULT 0,
    
    -- Cooling
    included_fans INTEGER DEFAULT 0,
    max_fans INTEGER DEFAULT 0,
    fan_sizes JSON, -- Array of supported fan sizes
    radiator_support JSON, -- Array of radiator support info
    
    -- Features
    side_panel_type VARCHAR(20) NOT NULL, -- Glass, Steel, Acrylic
    front_panel_io TEXT, -- USB ports, audio jacks, etc.
    dust_filters BOOLEAN DEFAULT FALSE,
    tempered_glass BOOLEAN DEFAULT FALSE,
    rgb BOOLEAN DEFAULT FALSE,
    
    -- Performance
    airflow_score DECIMAL(3,1) CHECK (airflow_score >= 0 AND airflow_score <= 10),
    noise_level_score DECIMAL(3,1) CHECK (noise_level_score >= 0 AND noise_level_score <= 10),
    
    -- Additional info
    release_date DATE,
    rating DECIMAL(2,1) DEFAULT 0 CHECK (rating >= 0 AND rating <= 5),
    review_count INTEGER DEFAULT 0,
    stock_quantity INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- CPU Coolers
CREATE TABLE cpu_coolers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    model VARCHAR(100) NOT NULL,
    vendor_id INTEGER REFERENCES vendors(id),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    image_url VARCHAR(500),
    description TEXT,
    
    -- Cooler Type
    cooler_type VARCHAR(20) NOT NULL, -- Air, Liquid, Hybrid
    
    -- Socket Support
    socket_support JSON NOT NULL, -- Array of supported sockets
    
    -- Physical Dimensions
    height_mm INTEGER NOT NULL,
    width_mm INTEGER NOT NULL,
    depth_mm INTEGER NOT NULL,
    
    -- Fan Specifications (for air coolers)
    fan_size_mm INTEGER,
    fan_count INTEGER DEFAULT 1,
    fan_speed_min INTEGER, -- RPM
    fan_speed_max INTEGER, -- RPM
    fan_noise_min DECIMAL(4,1), -- dB
    fan_noise_max DECIMAL(4,1), -- dB
    
    -- Liquid Cooler Specifications
    radiator_size_mm INTEGER,
    pump_speed INTEGER, -- RPM
    
    -- Performance
    tdp_rating INTEGER NOT NULL, -- Watts
    performance_score DECIMAL(3,1) CHECK (performance_score >= 0 AND performance_score <= 10),
    noise_level_score DECIMAL(3,1) CHECK (noise_level_score >= 0 AND noise_level_score <= 10),
    
    -- Features
    rgb BOOLEAN DEFAULT FALSE,
    pwm_control BOOLEAN DEFAULT TRUE,
    
    -- Additional info
    release_date DATE,
    rating DECIMAL(2,1) DEFAULT 0 CHECK (rating >= 0 AND rating <= 5),
    review_count INTEGER DEFAULT 0,
    stock_quantity INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================================
-- BUILD TABLES
-- ========================================

-- Builds table
CREATE TABLE builds (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    name VARCHAR(200) NOT NULL,
    description TEXT,
    is_public BOOLEAN DEFAULT TRUE,
    total_price DECIMAL(12,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Build parts table (flexible for multiple components)
CREATE TABLE build_parts (
    id SERIAL PRIMARY KEY,
    build_id INTEGER REFERENCES builds(id) ON DELETE CASCADE,
    part_type VARCHAR(20) NOT NULL, -- 'cpu', 'motherboard', 'ram', 'gpu', 'storage', 'psu', 'case', 'cooler'
    part_id INTEGER NOT NULL, -- ID from corresponding part table
    quantity INTEGER DEFAULT 1 CHECK (quantity > 0),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================================
-- COMPATIBILITY RULES
-- ========================================

-- Compatibility rules table
CREATE TABLE compatibility_rules (
    id SERIAL PRIMARY KEY,
    rule_name VARCHAR(100) NOT NULL,
    rule_type VARCHAR(50) NOT NULL, -- 'socket_match', 'form_factor', 'power_requirement', etc.
    source_component VARCHAR(20) NOT NULL, -- 'cpu', 'motherboard', etc.
    target_component VARCHAR(20) NOT NULL, -- 'motherboard', 'case', etc.
    rule_condition JSON NOT NULL, -- Detailed compatibility logic
    error_message TEXT NOT NULL,
    severity VARCHAR(20) DEFAULT 'error', -- 'error', 'warning', 'info'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================================
-- INDEXES
-- ========================================

-- Performance indexes
CREATE INDEX idx_cpus_socket_type ON cpus(socket_type);
CREATE INDEX idx_cpus_performance_score ON cpus(performance_score);
CREATE INDEX idx_motherboards_socket_type ON motherboards(socket_type);
CREATE INDEX idx_motherboards_form_factor ON motherboards(form_factor);
CREATE INDEX idx_ram_modules_ram_type ON ram_modules(ram_type);
CREATE INDEX idx_gpus_length ON gpus(length_mm);
CREATE INDEX idx_cases_max_gpu_length ON cases(max_gpu_length_mm);
CREATE INDEX idx_cases_max_cooler_height ON cases(max_cooler_height_mm);
CREATE INDEX idx_cpu_coolers_height ON cpu_coolers(height_mm);
CREATE INDEX idx_power_supplies_wattage ON power_supplies(wattage);

-- Build indexes
CREATE INDEX idx_builds_user_id ON builds(user_id);
CREATE INDEX idx_build_parts_build_id ON build_parts(build_id);
CREATE INDEX idx_build_parts_part_type ON build_parts(part_type);

-- ========================================
-- TRIGGERS AND FUNCTIONS
-- ========================================





DELIMITER $$
-- Function to update updated_at timestamp
CREATE TRIGGER update_users_updated_at
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END$$

-- Apply updated_at trigger to all tables
CREATE TRIGGER update_vendors_updated_at
BEFORE UPDATE ON vendors
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END$$

CREATE TRIGGER update_cpus_updated_at
BEFORE UPDATE ON cpus
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END$$

CREATE TRIGGER update_motherboards_updated_at
BEFORE UPDATE ON motherboards
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END$$

CREATE TRIGGER update_ram_modules_updated_at
BEFORE UPDATE ON ram_modules
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END$$

CREATE TRIGGER update_gpus_updated_at
BEFORE UPDATE ON gpus
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END$$

CREATE TRIGGER update_storage_devices_updated_at
BEFORE UPDATE ON storage_devices
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END$$

CREATE TRIGGER update_power_supplies_updated_at
BEFORE UPDATE ON power_supplies
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END$$

CREATE TRIGGER update_cases_updated_at
BEFORE UPDATE ON cases
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END$$

CREATE TRIGGER update_cpu_coolers_updated_at
BEFORE UPDATE ON cpu_coolers
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END$$

CREATE TRIGGER update_builds_updated_at
BEFORE UPDATE ON builds
FOR EACH ROW
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END$$

DELIMITER ;

-- Function to calculate build total price
DELIMITER $$

CREATE FUNCTION calculate_build_total_price(build_id_param INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(12,2) DEFAULT 0;

    SELECT COALESCE(SUM(
        CASE 
            WHEN bp.part_type = 'cpu' THEN c.price * bp.quantity
            WHEN bp.part_type = 'motherboard' THEN m.price * bp.quantity
            WHEN bp.part_type = 'ram' THEN r.price * bp.quantity
            WHEN bp.part_type = 'gpu' THEN g.price * bp.quantity
            WHEN bp.part_type = 'storage' THEN s.price * bp.quantity
            WHEN bp.part_type = 'psu' THEN p.price * bp.quantity
            WHEN bp.part_type = 'case' THEN cs.price * bp.quantity
            WHEN bp.part_type = 'cooler' THEN cc.price * bp.quantity
            ELSE 0
        END
    ), 0) INTO total
    FROM build_parts bp
    LEFT JOIN cpus c ON bp.part_type = 'cpu' AND bp.part_id = c.id
    LEFT JOIN motherboards m ON bp.part_type = 'motherboard' AND bp.part_id = m.id
    LEFT JOIN ram_modules r ON bp.part_type = 'ram' AND bp.part_id = r.id
    LEFT JOIN gpus g ON bp.part_type = 'gpu' AND bp.part_id = g.id
    LEFT JOIN storage_devices s ON bp.part_type = 'storage' AND bp.part_id = s.id
    LEFT JOIN power_supplies p ON bp.part_type = 'psu' AND bp.part_id = p.id
    LEFT JOIN cases cs ON bp.part_type = 'case' AND bp.part_id = cs.id
    LEFT JOIN cpu_coolers cc ON bp.part_type = 'cooler' AND bp.part_id = cc.id
    WHERE bp.build_id = build_id_param;

    RETURN total;
END$$

DELIMITER ;


-- Trigger to update build total price when parts change
DELIMITER $$

CREATE TRIGGER trigger_update_build_total_price
AFTER INSERT ON build_parts
FOR EACH ROW
BEGIN
    UPDATE builds
    SET total_price = calculate_build_total_price(NEW.build_id)
    WHERE id = NEW.build_id;
END$$

CREATE TRIGGER trigger_update_build_total_price_update
AFTER UPDATE ON build_parts
FOR EACH ROW
BEGIN
    UPDATE builds
    SET total_price = calculate_build_total_price(NEW.build_id)
    WHERE id = NEW.build_id;
END$$

CREATE TRIGGER trigger_update_build_total_price_delete
AFTER DELETE ON build_parts
FOR EACH ROW
BEGIN
    UPDATE builds
    SET total_price = calculate_build_total_price(OLD.build_id)
    WHERE id = OLD.build_id;
END$$

DELIMITER ;
