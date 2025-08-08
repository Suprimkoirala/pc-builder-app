# PC Builder Database v2.0 - Comprehensive Component Management

## Overview

This is a complete redesign of the PC Builder database system with separate tables for each component type and comprehensive compatibility checking. The system now supports detailed specifications for each component type and automatic compatibility validation.

## Database Schema

### Core Tables

#### Users
- Extended user management with profile information
- Supports email-based authentication
- Tracks pro builder status and activity

#### Vendors
- Manufacturer information
- Website, logo, and country details
- Used across all component types

### Component Tables

#### CPUs (Processors)
- **Socket Type**: LGA1700, AM4, AM5, etc.
- **Performance Metrics**: Cores, threads, clock speeds, cache
- **Power**: TDP (Thermal Design Power)
- **Features**: Integrated graphics, overclocking support
- **Scores**: Performance, gaming, productivity ratings

#### Motherboards
- **Socket Support**: Must match CPU socket
- **Form Factor**: ATX, mATX, ITX, etc.
- **Memory**: RAM type, slots, capacity, speed support
- **Expansion**: PCIe slots, storage interfaces
- **Connectivity**: USB ports, networking, audio

#### RAM (Memory)
- **Type**: DDR4, DDR5
- **Capacity**: Per module and total kit capacity
- **Speed**: MHz and CAS latency
- **Physical**: Form factor, height, voltage
- **Features**: RGB, ECC support

#### GPUs (Graphics Cards)
- **Chipset**: RTX 4090, RX 7900 XTX, etc.
- **Memory**: Size, type, bus width
- **Physical**: Length, width, height, slot width
- **Power**: TDP, connectors, recommended PSU
- **Features**: Ray tracing, DLSS, FSR support

#### Storage Devices
- **Type**: SSD, HDD, NVMe
- **Interface**: SATA, PCIe, M.2
- **Performance**: Read/write speeds, IOPS
- **Physical**: Form factor, dimensions
- **Endurance**: TBW rating for SSDs

#### Power Supplies
- **Wattage**: Total power output
- **Efficiency**: 80+ ratings (Bronze, Gold, Platinum, Titanium)
- **Modularity**: Full, Semi, Non-modular
- **Connectors**: CPU, PCIe, SATA, Molex
- **Protection**: OVP, UVP, SCP

#### Cases
- **Form Factor Support**: Array of supported motherboard sizes
- **GPU Support**: Maximum length, width, height
- **Cooling**: Fan support, radiator compatibility
- **Storage**: Drive bay counts
- **Features**: Side panel type, dust filters, RGB

#### CPU Coolers
- **Type**: Air, Liquid, Hybrid
- **Socket Support**: Array of compatible sockets
- **Physical**: Height, width, depth
- **Performance**: TDP rating, fan specifications
- **Features**: RGB, PWM control

### Build Management

#### Builds Table
- User association
- Name and description
- Public/private visibility
- Automatic total price calculation

#### Build Parts Table (Flexible)
- Links builds to components
- Supports multiple components per type
- Quantity tracking
- Notes for customization

## Compatibility Checking

### Automatic Compatibility Rules

The system includes comprehensive compatibility checking functions:

#### CPU ↔ Motherboard
- **Socket Match**: CPU and motherboard must use same socket
- **Error**: "Socket mismatch: CPU uses LGA1700, motherboard uses AM5"

#### Motherboard ↔ RAM
- **Type Match**: DDR4/DDR5 compatibility
- **Slot Count**: RAM modules must fit available slots
- **Speed Support**: RAM speed within motherboard limits
- **Warning**: "RAM speed too high: Motherboard max 7200 MHz, RAM is 7600 MHz"

#### GPU ↔ Case
- **Length Check**: GPU must fit within case dimensions
- **Error**: "GPU too long: GPU length 304 mm, case max 300 mm"

#### Case ↔ Motherboard
- **Form Factor**: Case must support motherboard size
- **Error**: "Case does not support motherboard form factor: ATX. Supported: mATX, ITX"

#### PSU Wattage Requirements
- **Total Power**: CPU + GPU + 100W headroom
- **GPU Recommendations**: Respect GPU manufacturer recommendations
- **Error**: "PSU wattage insufficient: 650W available, 750W required"

#### Storage ↔ Motherboard
- **Interface Support**: SATA ports, M.2 slots, PCIe lanes
- **Error**: "Storage interface not supported: PCIe M.2 not compatible with motherboard"

#### Cooler ↔ Case
- **Height Check**: Cooler must fit within case clearance
- **Error**: "Cooler too tall: Cooler height 165 mm, case max 160 mm"

#### Cooler ↔ CPU
- **Socket Support**: Cooler must support CPU socket
- **Error**: "Cooler does not support CPU socket: LGA1700. Supported: AM4, AM5"

### Compatibility Functions

```sql
-- Check specific component compatibility
SELECT check_cpu_motherboard_compatibility(1, 5);
SELECT check_gpu_case_compatibility(3, 2);
SELECT check_psu_wattage_compatibility(4, 1, 3);

-- Check entire build compatibility
SELECT check_build_compatibility(123);
```

## API Endpoints

### Component Endpoints

#### CPUs
```
GET /api/v1/cpus/
GET /api/v1/cpus/?socket_type=LGA1700&min_price=300&max_price=600
GET /api/v1/cpus/1/
```

#### Motherboards
```
GET /api/v1/motherboards/
GET /api/v1/motherboards/?socket_type=AM5&form_factor=ATX&ram_type=DDR5
```

#### RAM
```
GET /api/v1/ram/
GET /api/v1/ram/?ram_type=DDR5&capacity=32&min_speed=6000
```

#### GPUs
```
GET /api/v1/gpus/
GET /api/v1/gpus/?min_memory=16&ray_tracing=true&max_price=1000
```

#### Storage
```
GET /api/v1/storage/
GET /api/v1/storage/?storage_type=SSD&interface=PCIe&min_capacity=1000
```

#### Power Supplies
```
GET /api/v1/power-supplies/
GET /api/v1/power-supplies/?min_wattage=750&efficiency_rating=80+ Gold
```

#### Cases
```
GET /api/v1/cases/
GET /api/v1/cases/?form_factor=ATX&min_gpu_length=300&side_panel_type=Glass
```

#### CPU Coolers
```
GET /api/v1/cpu-coolers/
GET /api/v1/cpu-coolers/?cooler_type=Air&socket_type=LGA1700&min_tdp=200
```

### Compatibility Endpoints

```
GET /api/v1/compatibility/?cpu_id=1&motherboard_id=5&gpu_id=3&case_id=2
```

### Build Management

```
POST /api/v1/builds/
{
  "user_id": 1,
  "name": "Gaming PC Build",
  "description": "High-end gaming setup",
  "parts": [
    {"part_type": "cpu", "part_id": 1, "quantity": 1},
    {"part_type": "motherboard", "part_id": 5, "quantity": 1},
    {"part_type": "ram", "part_id": 3, "quantity": 1},
    {"part_type": "gpu", "part_id": 2, "quantity": 1}
  ]
}

GET /api/v1/users/1/builds/
GET /api/v1/builds/123/
```

### Search

```
GET /api/v1/search/?q=RTX 4090&type=gpu
GET /api/v1/search/?q=Ryzen&type=cpu
```

## Database Setup

### 1. Create Database Schema

```bash
# Connect to PostgreSQL
psql -U postgres -d dbms_project

# Run schema creation
\i database_schema_v2.sql
```

### 2. Create Compatibility Functions

```bash
# Run compatibility functions
\i compatibility_functions.sql
```

### 3. Load Sample Data

```bash
# Load comprehensive sample data
\i sample_data_v2.sql
```

### 4. Verify Setup

```sql
-- Check tables
\dt

-- Test compatibility functions
SELECT check_cpu_motherboard_compatibility(1, 5);

-- View sample data
SELECT name, socket_type, performance_score FROM cpus LIMIT 5;
```

## Key Features

### 1. Detailed Specifications
- Each component type has comprehensive specifications
- Performance scores and ratings
- Physical dimensions and compatibility data
- Power requirements and thermal characteristics

### 2. Flexible Build System
- Support for multiple components per type
- Quantity tracking for RAM, storage, etc.
- Automatic price calculation
- Build versioning and history

### 3. Real-time Compatibility Checking
- Automatic validation of component combinations
- Detailed error messages with specific issues
- Warning system for suboptimal configurations
- Support for complex compatibility rules

### 4. Advanced Filtering
- Price range filtering
- Performance-based sorting
- Vendor and feature filtering
- Physical constraint filtering (size, power, etc.)

### 5. Search and Discovery
- Cross-component search
- Type-specific search
- Performance-based recommendations
- Compatibility-aware suggestions

## Performance Optimizations

### Indexes
- Performance scores for fast sorting
- Physical dimensions for compatibility checks
- Socket types and form factors for filtering
- Price ranges for budget filtering

### Triggers
- Automatic `updated_at` timestamp updates
- Real-time build price calculation
- Data integrity constraints

### Functions
- Optimized compatibility checking
- Efficient build total calculation
- Fast component lookup and filtering

## Migration from v1

### Schema Changes
1. **Separate Component Tables**: Each component type now has its own table
2. **Detailed Specifications**: Comprehensive specs for each component
3. **Compatibility Functions**: Built-in compatibility checking
4. **Flexible Build System**: Support for multiple components per type

### Data Migration
```sql
-- Example migration from old components table
INSERT INTO cpus (name, model, vendor_id, price, socket_type, cores, threads, tdp)
SELECT name, model, vendor_id, price, 
       specifications->>'socket_type' as socket_type,
       (specifications->>'cores')::int as cores,
       (specifications->>'threads')::int as threads,
       (specifications->>'tdp')::int as tdp
FROM components 
WHERE category_id = (SELECT id FROM categories WHERE slug = 'cpu');
```

## Future Enhancements

### Planned Features
1. **Price Tracking**: Historical price data and trends
2. **User Reviews**: Component ratings and reviews
3. **Build Sharing**: Public build sharing and community features
4. **Advanced Filters**: More sophisticated filtering options
5. **Performance Benchmarks**: Real-world performance data
6. **Stock Tracking**: Real-time availability and pricing
7. **Alternative Suggestions**: Compatibility-aware alternatives

### API Extensions
1. **Bulk Operations**: Batch component operations
2. **Advanced Search**: Full-text search with filters
3. **Build Templates**: Pre-configured build templates
4. **Export Features**: Build export in various formats
5. **Webhook Support**: Real-time updates and notifications

## Troubleshooting

### Common Issues

#### Compatibility Check Failures
```sql
-- Debug compatibility issues
SELECT check_cpu_motherboard_compatibility(1, 5);
SELECT check_gpu_case_compatibility(3, 2);
```

#### Performance Issues
```sql
-- Check query performance
EXPLAIN ANALYZE SELECT * FROM cpus WHERE socket_type = 'LGA1700';
```

#### Data Integrity
```sql
-- Verify data consistency
SELECT COUNT(*) FROM cpus WHERE socket_type IS NULL;
SELECT COUNT(*) FROM motherboards WHERE ram_slots = 0;
```

### Support

For issues and questions:
1. Check the compatibility functions for specific error messages
2. Verify component specifications in the database
3. Test individual compatibility checks
4. Review the API response format and error handling

## Conclusion

This v2.0 system provides a robust foundation for PC component management with comprehensive compatibility checking, detailed specifications, and flexible build management. The separate component tables allow for detailed specifications while maintaining data integrity and performance.
