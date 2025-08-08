-- PC Builder Database Schema
-- Comprehensive database structure with raw SQL

-- Drop existing tables if they exist (for clean setup)
DROP TABLE IF EXISTS build_components CASCADE;
DROP TABLE IF EXISTS builds CASCADE;
DROP TABLE IF EXISTS components CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS vendors CASCADE;
DROP TABLE IF EXISTS compatibility_rules CASCADE;
DROP TABLE IF EXISTS users CASCADE;

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

-- Categories table
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    slug VARCHAR(50) UNIQUE NOT NULL,
    icon VARCHAR(50),
    description TEXT,
    sort_order INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
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
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Components table (comprehensive)
CREATE TABLE components (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    model VARCHAR(100),
    description TEXT,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    category_id INTEGER REFERENCES categories(id) ON DELETE CASCADE,
    vendor_id INTEGER REFERENCES vendors(id) ON DELETE CASCADE,
    image_url VARCHAR(500),
    stock_quantity INTEGER DEFAULT 100 CHECK (stock_quantity >= 0),
    is_active BOOLEAN DEFAULT TRUE,
    
    -- Technical specifications (JSON for flexibility)
    specifications JSONB,
    
    -- Performance metrics
    performance_score DECIMAL(3, 1),
    power_consumption INTEGER, -- in watts
    dimensions JSONB, -- {"length": 300, "width": 120, "height": 40}
    
    -- Compatibility attributes
    socket_type VARCHAR(50),
    form_factor VARCHAR(50),
    memory_type VARCHAR(50),
    memory_speed INTEGER, -- in MHz
    memory_capacity INTEGER, -- in GB
    storage_type VARCHAR(50), -- SSD, HDD, NVMe
    storage_capacity INTEGER, -- in GB
    power_rating INTEGER, -- in watts
    
    -- Additional metadata
    release_date DATE,
    warranty_months INTEGER DEFAULT 12,
    rating DECIMAL(2, 1) CHECK (rating >= 0 AND rating <= 5),
    review_count INTEGER DEFAULT 0,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Builds table
CREATE TABLE builds (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    is_public BOOLEAN DEFAULT TRUE,
    total_price DECIMAL(12, 2) DEFAULT 0,
    estimated_power INTEGER, -- total power consumption
    compatibility_score DECIMAL(3, 1), -- 0-100 compatibility rating
    build_type VARCHAR(50), -- gaming, workstation, budget, etc.
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Build components junction table
CREATE TABLE build_components (
    id SERIAL PRIMARY KEY,
    build_id INTEGER REFERENCES builds(id) ON DELETE CASCADE,
    component_id INTEGER REFERENCES components(id) ON DELETE CASCADE,
    quantity INTEGER DEFAULT 1 CHECK (quantity > 0),
    notes VARCHAR(200),
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(build_id, component_id)
);

-- Compatibility rules table
CREATE TABLE compatibility_rules (
    id SERIAL PRIMARY KEY,
    source_category_id INTEGER REFERENCES categories(id) ON DELETE CASCADE,
    target_category_id INTEGER REFERENCES categories(id) ON DELETE CASCADE,
    rule_type VARCHAR(50), -- socket_match, form_factor, power_supply, etc.
    condition JSONB NOT NULL,
    severity VARCHAR(20) DEFAULT 'warning', -- error, warning, info
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- User favorites table
CREATE TABLE user_favorites (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    component_id INTEGER REFERENCES components(id) ON DELETE CASCADE,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, component_id)
);

-- Component reviews table
CREATE TABLE component_reviews (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    component_id INTEGER REFERENCES components(id) ON DELETE CASCADE,
    rating INTEGER CHECK (rating >= 1 AND rating <= 5),
    title VARCHAR(200),
    review_text TEXT,
    pros TEXT,
    cons TEXT,
    is_verified_purchase BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Price history table
CREATE TABLE price_history (
    id SERIAL PRIMARY KEY,
    component_id INTEGER REFERENCES components(id) ON DELETE CASCADE,
    price DECIMAL(10, 2) NOT NULL,
    recorded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for better performance
CREATE INDEX idx_components_category ON components(category_id);
CREATE INDEX idx_components_vendor ON components(vendor_id);
CREATE INDEX idx_components_price ON components(price);
CREATE INDEX idx_components_active ON components(is_active);
CREATE INDEX idx_builds_user ON builds(user_id);
CREATE INDEX idx_build_components_build ON build_components(build_id);
CREATE INDEX idx_build_components_component ON build_components(component_id);
CREATE INDEX idx_compatibility_rules_source ON compatibility_rules(source_category_id);
CREATE INDEX idx_compatibility_rules_target ON compatibility_rules(target_category_id);
CREATE INDEX idx_components_specifications ON components USING GIN(specifications);
CREATE INDEX idx_components_dimensions ON components USING GIN(dimensions);

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for updated_at
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_categories_updated_at BEFORE UPDATE ON categories FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_vendors_updated_at BEFORE UPDATE ON vendors FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_components_updated_at BEFORE UPDATE ON components FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_builds_updated_at BEFORE UPDATE ON builds FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_component_reviews_updated_at BEFORE UPDATE ON component_reviews FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Function to calculate build total price
CREATE OR REPLACE FUNCTION calculate_build_total_price(build_id_param INTEGER)
RETURNS DECIMAL AS $$
DECLARE
    total DECIMAL(12, 2);
BEGIN
    SELECT COALESCE(SUM(c.price * bc.quantity), 0)
    INTO total
    FROM build_components bc
    JOIN components c ON bc.component_id = c.id
    WHERE bc.build_id = build_id_param;
    
    UPDATE builds SET total_price = total WHERE id = build_id_param;
    RETURN total;
END;
$$ LANGUAGE plpgsql;

-- Trigger to update build total price when components are added/removed
CREATE OR REPLACE FUNCTION update_build_total_price()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'DELETE' THEN
        PERFORM calculate_build_total_price(OLD.build_id);
        RETURN OLD;
    ELSE
        PERFORM calculate_build_total_price(NEW.build_id);
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_build_total_price
    AFTER INSERT OR UPDATE OR DELETE ON build_components
    FOR EACH ROW EXECUTE FUNCTION update_build_total_price();
