-- Initialize Components with Sample Data
-- This script populates the database with various PC components

-- Insert CPUs
INSERT INTO components (name, model, description, price, category_id, vendor_id, image_url, specifications, performance_score, power_consumption, socket_type, release_date, rating, review_count) VALUES
-- Intel CPUs
('Intel Core i9-13900K', '13900K', '24-core (8P + 16E) processor with up to 5.8GHz boost', 589.99, 1, 1, 'https://example.com/i9-13900k.jpg', 
 '{"cores": 24, "threads": 32, "base_clock": "3.0GHz", "boost_clock": "5.8GHz", "cache": "36MB", "tdp": "253W", "architecture": "Raptor Lake", "process": "10nm"}', 
 9.8, 253, 'LGA1700', '2022-10-20', 4.7, 1250),

('Intel Core i7-13700K', '13700K', '16-core (8P + 8E) processor with up to 5.4GHz boost', 409.99, 1, 1, 'https://example.com/i7-13700k.jpg',
 '{"cores": 16, "threads": 24, "base_clock": "3.4GHz", "boost_clock": "5.4GHz", "cache": "30MB", "tdp": "253W", "architecture": "Raptor Lake", "process": "10nm"}',
 9.2, 253, 'LGA1700', '2022-10-20', 4.6, 890),

('Intel Core i5-13600K', '13600K', '14-core (6P + 8E) processor with up to 5.1GHz boost', 319.99, 1, 1, 'https://example.com/i5-13600k.jpg',
 '{"cores": 14, "threads": 20, "base_clock": "3.5GHz", "boost_clock": "5.1GHz", "cache": "24MB", "tdp": "181W", "architecture": "Raptor Lake", "process": "10nm"}',
 8.8, 181, 'LGA1700', '2022-10-20', 4.5, 756),

-- AMD CPUs
('AMD Ryzen 9 7950X', '7950X', '16-core processor with up to 5.7GHz boost', 699.99, 1, 2, 'https://example.com/ryzen-9-7950x.jpg',
 '{"cores": 16, "threads": 32, "base_clock": "4.5GHz", "boost_clock": "5.7GHz", "cache": "80MB", "tdp": "170W", "architecture": "Zen 4", "process": "5nm"}',
 9.9, 170, 'AM5', '2022-09-27', 4.8, 1100),

('AMD Ryzen 7 7700X', '7700X', '8-core processor with up to 5.4GHz boost', 399.99, 1, 2, 'https://example.com/ryzen-7-7700x.jpg',
 '{"cores": 8, "threads": 16, "base_clock": "4.5GHz", "boost_clock": "5.4GHz", "cache": "40MB", "tdp": "105W", "architecture": "Zen 4", "process": "5nm"}',
 9.0, 105, 'AM5', '2022-09-27', 4.6, 920),

('AMD Ryzen 5 7600X', '7600X', '6-core processor with up to 5.3GHz boost', 299.99, 1, 2, 'https://example.com/ryzen-5-7600x.jpg',
 '{"cores": 6, "threads": 12, "base_clock": "4.7GHz", "boost_clock": "5.3GHz", "cache": "38MB", "tdp": "105W", "architecture": "Zen 4", "process": "5nm"}',
 8.5, 105, 'AM5', '2022-09-27', 4.4, 680);

-- Insert GPUs
INSERT INTO components (name, model, description, price, category_id, vendor_id, image_url, specifications, performance_score, power_consumption, dimensions, release_date, rating, review_count) VALUES
-- NVIDIA GPUs
('NVIDIA GeForce RTX 4090', 'RTX 4090', 'Flagship 24GB GDDR6X graphics card', 1599.99, 2, 3, 'https://example.com/rtx-4090.jpg',
 '{"memory": "24GB GDDR6X", "memory_speed": "21000MHz", "cuda_cores": 16384, "boost_clock": "2520MHz", "memory_bus": "384-bit", "ray_tracing_cores": 144, "tensor_cores": 576}',
 10.0, 450, '{"length": 304, "width": 137, "height": 61}', '2022-10-12', 4.9, 890),

('NVIDIA GeForce RTX 4080', 'RTX 4080', '16GB GDDR6X graphics card for 4K gaming', 1199.99, 2, 3, 'https://example.com/rtx-4080.jpg',
 '{"memory": "16GB GDDR6X", "memory_speed": "22400MHz", "cuda_cores": 9728, "boost_clock": "2505MHz", "memory_bus": "256-bit", "ray_tracing_cores": 76, "tensor_cores": 304}',
 9.5, 320, '{"length": 304, "width": 137, "height": 61}', '2022-11-16', 4.7, 650),

('NVIDIA GeForce RTX 4070 Ti', 'RTX 4070 Ti', '12GB GDDR6X graphics card for high-end gaming', 799.99, 2, 3, 'https://example.com/rtx-4070-ti.jpg',
 '{"memory": "12GB GDDR6X", "memory_speed": "21000MHz", "cuda_cores": 7680, "boost_clock": "2610MHz", "memory_bus": "192-bit", "ray_tracing_cores": 60, "tensor_cores": 240}',
 9.0, 285, '{"length": 285, "width": 112, "height": 50}', '2023-01-05', 4.6, 520),

-- AMD GPUs
('AMD Radeon RX 7900 XTX', 'RX 7900 XTX', '24GB GDDR6 graphics card with advanced features', 999.99, 2, 2, 'https://example.com/rx-7900-xtx.jpg',
 '{"memory": "24GB GDDR6", "memory_speed": "20000MHz", "stream_processors": 12288, "boost_clock": "2500MHz", "memory_bus": "384-bit", "ray_accelerators": 96}',
 9.7, 355, '{"length": 287, "width": 135, "height": 50}', '2022-12-13', 4.8, 720),

('AMD Radeon RX 7900 XT', 'RX 7900 XT', '20GB GDDR6 graphics card for 4K gaming', 899.99, 2, 2, 'https://example.com/rx-7900-xt.jpg',
 '{"memory": "20GB GDDR6", "memory_speed": "20000MHz", "stream_processors": 10752, "boost_clock": "2400MHz", "memory_bus": "320-bit", "ray_accelerators": 84}',
 9.3, 315, '{"length": 287, "width": 135, "height": 50}', '2022-12-13', 4.6, 580),

('AMD Radeon RX 7800 XT', 'RX 7800 XT', '16GB GDDR6 graphics card for high-performance gaming', 499.99, 2, 2, 'https://example.com/rx-7800-xt.jpg',
 '{"memory": "16GB GDDR6", "memory_speed": "19500MHz", "stream_processors": 3840, "boost_clock": "2430MHz", "memory_bus": "256-bit", "ray_accelerators": 60}',
 8.8, 263, '{"length": 267, "width": 120, "height": 50}', '2023-09-06', 4.5, 420);

-- Insert Motherboards
INSERT INTO components (name, model, description, price, category_id, vendor_id, image_url, specifications, performance_score, power_consumption, socket_type, form_factor, dimensions, release_date, rating, review_count) VALUES
-- Intel Motherboards
('ASUS ROG Maximus Z790 Hero', 'Z790 Hero', 'Premium Intel Z790 motherboard with advanced features', 499.99, 3, 4, 'https://example.com/maximus-z790-hero.jpg',
 '{"chipset": "Z790", "memory_slots": 4, "max_memory": "128GB", "memory_speed": "7800MHz", "pcie_slots": 3, "m2_slots": 4, "wifi": true, "bluetooth": true, "lan_ports": 2}',
 9.5, 15, 'LGA1700', 'ATX', '{"length": 305, "width": 244, "height": 6}', '2022-10-20', 4.7, 320),

('MSI MPG Z790 Gaming Edge WiFi', 'Z790 Gaming Edge', 'Gaming-focused Z790 motherboard with WiFi 6E', 399.99, 3, 5, 'https://example.com/mpg-z790-gaming-edge.jpg',
 '{"chipset": "Z790", "memory_slots": 4, "max_memory": "128GB", "memory_speed": "7200MHz", "pcie_slots": 3, "m2_slots": 4, "wifi": true, "bluetooth": true, "lan_ports": 1}',
 9.2, 12, 'LGA1700', 'ATX', '{"length": 305, "width": 244, "height": 6}', '2022-10-20', 4.6, 280),

('Gigabyte Z790 Aorus Elite AX', 'Z790 Aorus Elite', 'Feature-rich Z790 motherboard with excellent value', 299.99, 3, 6, 'https://example.com/z790-aorus-elite.jpg',
 '{"chipset": "Z790", "memory_slots": 4, "max_memory": "128GB", "memory_speed": "7600MHz", "pcie_slots": 3, "m2_slots": 4, "wifi": true, "bluetooth": true, "lan_ports": 1}',
 9.0, 10, 'LGA1700', 'ATX', '{"length": 305, "width": 244, "height": 6}', '2022-10-20', 4.5, 240),

-- AMD Motherboards
('ASUS ROG Crosshair X670E Hero', 'X670E Hero', 'Premium AMD X670E motherboard for Ryzen 7000', 449.99, 3, 4, 'https://example.com/crosshair-x670e-hero.jpg',
 '{"chipset": "X670E", "memory_slots": 4, "max_memory": "128GB", "memory_speed": "6400MHz", "pcie_slots": 3, "m2_slots": 4, "wifi": true, "bluetooth": true, "lan_ports": 2}',
 9.6, 14, 'AM5', 'ATX', '{"length": 305, "width": 244, "height": 6}', '2022-09-27', 4.8, 290),

('MSI MPG X670E Carbon WiFi', 'X670E Carbon', 'High-end X670E motherboard with carbon fiber design', 399.99, 3, 5, 'https://example.com/mpg-x670e-carbon.jpg',
 '{"chipset": "X670E", "memory_slots": 4, "max_memory": "128GB", "memory_speed": "6600MHz", "pcie_slots": 3, "m2_slots": 4, "wifi": true, "bluetooth": true, "lan_ports": 1}',
 9.3, 11, 'AM5', 'ATX', '{"length": 305, "width": 244, "height": 6}', '2022-09-27', 4.7, 260),

('Gigabyte X670E Aorus Pro', 'X670E Aorus Pro', 'Professional X670E motherboard with excellent features', 349.99, 3, 6, 'https://example.com/x670e-aorus-pro.jpg',
 '{"chipset": "X670E", "memory_slots": 4, "max_memory": "128GB", "memory_speed": "6400MHz", "pcie_slots": 3, "m2_slots": 4, "wifi": true, "bluetooth": true, "lan_ports": 1}',
 9.1, 9, 'AM5', 'ATX', '{"length": 305, "width": 244, "height": 6}', '2022-09-27', 4.6, 220);

-- Insert Memory (RAM)
INSERT INTO components (name, model, description, price, category_id, vendor_id, image_url, specifications, performance_score, power_consumption, memory_type, memory_speed, memory_capacity, dimensions, release_date, rating, review_count) VALUES
-- DDR5 Memory
('Corsair Dominator Platinum RGB', 'CMT32GX5M2X7200C34', '32GB (2x16GB) DDR5-7200 CL34 RGB memory', 299.99, 4, 7, 'https://example.com/dominator-platinum-rgb.jpg',
 '{"capacity": "32GB", "modules": "2x16GB", "speed": "7200MHz", "cas_latency": 34, "voltage": "1.4V", "xmp_profiles": 2, "rgb": true}',
 9.8, 8, 'DDR5', 7200, 32, '{"length": 137, "width": 8, "height": 44}', '2022-10-20', 4.8, 450),

('G.Skill Trident Z5 RGB', 'F5-7200J3445G16GX2-TZ5RK', '32GB (2x16GB) DDR5-7200 CL34 RGB memory', 289.99, 4, 7, 'https://example.com/trident-z5-rgb.jpg',
 '{"capacity": "32GB", "modules": "2x16GB", "speed": "7200MHz", "cas_latency": 34, "voltage": "1.4V", "xmp_profiles": 2, "rgb": true}',
 9.7, 8, 'DDR5', 7200, 32, '{"length": 137, "width": 8, "height": 44}', '2022-10-20', 4.7, 420),

('Kingston Fury Beast RGB', 'KF572C36BBEK2-32', '32GB (2x16GB) DDR5-7200 CL36 RGB memory', 279.99, 4, 7, 'https://example.com/fury-beast-rgb.jpg',
 '{"capacity": "32GB", "modules": "2x16GB", "speed": "7200MHz", "cas_latency": 36, "voltage": "1.35V", "xmp_profiles": 2, "rgb": true}',
 9.5, 7, 'DDR5', 7200, 32, '{"length": 137, "width": 8, "height": 44}', '2022-10-20', 4.6, 380),

-- DDR4 Memory
('Corsair Vengeance LPX', 'CMK32GX4M2D3600C18', '32GB (2x16GB) DDR4-3600 CL18 memory', 129.99, 4, 7, 'https://example.com/vengeance-lpx.jpg',
 '{"capacity": "32GB", "modules": "2x16GB", "speed": "3600MHz", "cas_latency": 18, "voltage": "1.35V", "xmp_profiles": 1, "rgb": false}',
 8.5, 6, 'DDR4', 3600, 32, '{"length": 137, "width": 8, "height": 31}', '2020-03-15', 4.4, 650),

('G.Skill Ripjaws V', 'F4-3600C18D-32GVK', '32GB (2x16GB) DDR4-3600 CL18 memory', 119.99, 4, 7, 'https://example.com/ripjaws-v.jpg',
 '{"capacity": "32GB", "modules": "2x16GB", "speed": "3600MHz", "cas_latency": 18, "voltage": "1.35V", "xmp_profiles": 1, "rgb": false}',
 8.4, 6, 'DDR4', 3600, 32, '{"length": 137, "width": 8, "height": 31}', '2020-03-15', 4.3, 580);

-- Insert Storage
INSERT INTO components (name, model, description, price, category_id, vendor_id, image_url, specifications, performance_score, power_consumption, storage_type, storage_capacity, dimensions, release_date, rating, review_count) VALUES
-- NVMe SSDs
('Samsung 990 Pro', 'MZ-V9P2T0BW', '2TB PCIe 4.0 NVMe SSD with up to 7450MB/s read', 199.99, 5, 8, 'https://example.com/990-pro.jpg',
 '{"capacity": "2TB", "interface": "PCIe 4.0 x4", "read_speed": "7450MB/s", "write_speed": "6900MB/s", "endurance": "1200TBW", "nand_type": "V-NAND 3-bit MLC"}',
 9.9, 5, 'NVMe', 2048, '{"length": 80.15, "width": 22.15, "height": 2.38}', '2022-10-20', 4.9, 890),

('WD Black SN850X', 'WDS200T2X0E', '2TB PCIe 4.0 NVMe SSD with up to 7300MB/s read', 189.99, 5, 10, 'https://example.com/sn850x.jpg',
 '{"capacity": "2TB", "interface": "PCIe 4.0 x4", "read_speed": "7300MB/s", "write_speed": "6600MB/s", "endurance": "1200TBW", "nand_type": "BiCS5 112-Layer TLC"}',
 9.7, 5, 'NVMe', 2048, '{"length": 80.15, "width": 22.15, "height": 2.38}', '2022-07-15', 4.8, 720),

('Crucial P5 Plus', 'CT2000P5PSSD8', '2TB PCIe 4.0 NVMe SSD with up to 6600MB/s read', 179.99, 5, 8, 'https://example.com/p5-plus.jpg',
 '{"capacity": "2TB", "interface": "PCIe 4.0 x4", "read_speed": "6600MB/s", "write_speed": "5000MB/s", "endurance": "1200TBW", "nand_type": "Micron 176-Layer TLC"}',
 9.5, 4, 'NVMe', 2048, '{"length": 80.15, "width": 22.15, "height": 2.38}', '2021-06-15', 4.7, 650),

-- SATA SSDs
('Samsung 870 EVO', 'MZ-77E2T0B/AM', '2TB SATA III SSD with up to 560MB/s read', 149.99, 5, 8, 'https://example.com/870-evo.jpg',
 '{"capacity": "2TB", "interface": "SATA III", "read_speed": "560MB/s", "write_speed": "530MB/s", "endurance": "1200TBW", "nand_type": "V-NAND 3-bit MLC"}',
 8.5, 3, 'SSD', 2048, '{"length": 100, "width": 69.85, "height": 6.8}', '2021-01-15', 4.6, 520),

-- HDDs
('Seagate Barracuda', 'ST2000DM008', '2TB 7200RPM SATA III HDD', 49.99, 5, 11, 'https://example.com/barracuda.jpg',
 '{"capacity": "2TB", "interface": "SATA III", "rpm": 7200, "cache": "256MB", "form_factor": "3.5-inch"}',
 6.5, 8, 'HDD', 2048, '{"length": 146.99, "width": 101.6, "height": 20.17}', '2020-03-15', 4.2, 380),

('Western Digital Blue', 'WD20EZBX', '2TB 7200RPM SATA III HDD', 49.99, 5, 10, 'https://example.com/wd-blue.jpg',
 '{"capacity": "2TB", "interface": "SATA III", "rpm": 7200, "cache": "256MB", "form_factor": "3.5-inch"}',
 6.4, 8, 'HDD', 2048, '{"length": 146.99, "width": 101.6, "height": 20.17}', '2020-03-15', 4.1, 350);

-- Insert Power Supplies
INSERT INTO components (name, model, description, price, category_id, vendor_id, image_url, specifications, performance_score, power_consumption, power_rating, dimensions, release_date, rating, review_count) VALUES
('Corsair HX1200', 'CP-9020140-NA', '1200W 80+ Platinum fully modular power supply', 249.99, 6, 7, 'https://example.com/hx1200.jpg',
 '{"wattage": 1200, "efficiency": "80+ Platinum", "modularity": "Fully Modular", "form_factor": "ATX", "fan_size": "135mm", "protections": ["OVP", "UVP", "SCP", "OCP", "OTP"]}',
 9.8, 1200, 1200, '{"length": 180, "width": 150, "height": 86}', '2021-06-15', 4.9, 420),

('EVGA SuperNOVA 1000 GT', '220-GT-1000-X1', '1000W 80+ Gold fully modular power supply', 199.99, 6, 12, 'https://example.com/supernova-1000gt.jpg',
 '{"wattage": 1000, "efficiency": "80+ Gold", "modularity": "Fully Modular", "form_factor": "ATX", "fan_size": "135mm", "protections": ["OVP", "UVP", "SCP", "OCP", "OTP"]}',
 9.5, 1000, 1000, '{"length": 180, "width": 150, "height": 86}', '2021-03-15', 4.7, 380),

('be quiet! Straight Power 11', 'BN297', '850W 80+ Gold fully modular power supply', 149.99, 6, 13, 'https://example.com/straight-power-11.jpg',
 '{"wattage": 850, "efficiency": "80+ Gold", "modularity": "Fully Modular", "form_factor": "ATX", "fan_size": "135mm", "protections": ["OVP", "UVP", "SCP", "OCP", "OTP"]}',
 9.3, 850, 850, '{"length": 180, "width": 150, "height": 86}', '2020-09-15', 4.6, 320),

('Corsair RM750x', 'CP-9020199-NA', '750W 80+ Gold fully modular power supply', 119.99, 6, 7, 'https://example.com/rm750x.jpg',
 '{"wattage": 750, "efficiency": "80+ Gold", "modularity": "Fully Modular", "form_factor": "ATX", "fan_size": "135mm", "protections": ["OVP", "UVP", "SCP", "OCP", "OTP"]}',
 9.1, 750, 750, '{"length": 180, "width": 150, "height": 86}', '2020-06-15', 4.5, 280);

-- Insert Cases
INSERT INTO components (name, model, description, price, category_id, vendor_id, image_url, specifications, performance_score, dimensions, form_factor, release_date, rating, review_count) VALUES
('Fractal Design Torrent', 'FD-C-TOR1N-01', 'High-airflow ATX case with 180mm fans', 189.99, 7, 14, 'https://example.com/torrent.jpg',
 '{"form_factor": "ATX", "max_gpu_length": "467mm", "max_cpu_cooler_height": "188mm", "fan_slots": 7, "included_fans": 2, "material": "Steel/Plastic", "side_panel": "Tempered Glass"}',
 9.7, '{"length": 467, "width": 240, "height": 467}', 'ATX', '2021-08-15', 4.8, 520),

('NZXT H7 Flow', 'CA-H7FW-B1', 'Mid-tower ATX case with mesh front panel', 129.99, 7, 15, 'https://example.com/h7-flow.jpg',
 '{"form_factor": "ATX", "max_gpu_length": "400mm", "max_cpu_cooler_height": "185mm", "fan_slots": 6, "included_fans": 3, "material": "Steel/Plastic", "side_panel": "Tempered Glass"}',
 9.3, '{"length": 460, "width": 230, "height": 446}', 'ATX', '2021-10-15', 4.6, 420),

('Lian Li O11 Dynamic EVO', 'O11DEX', 'Premium ATX case with modular design', 169.99, 7, 15, 'https://example.com/o11-dynamic-evo.jpg',
 '{"form_factor": "ATX", "max_gpu_length": "420mm", "max_cpu_cooler_height": "167mm", "fan_slots": 10, "included_fans": 0, "material": "Aluminum/Steel", "side_panel": "Tempered Glass"}',
 9.5, '{"length": 459, "width": 272, "height": 459}', 'ATX', '2022-01-15', 4.7, 480),

('be quiet! Pure Base 500DX', 'BGW37', 'Silent-focused ATX case with RGB', 99.99, 7, 13, 'https://example.com/pure-base-500dx.jpg',
 '{"form_factor": "ATX", "max_gpu_length": "369mm", "max_cpu_cooler_height": "190mm", "fan_slots": 3, "included_fans": 3, "material": "Steel/Plastic", "side_panel": "Tempered Glass"}',
 9.1, '{"length": 450, "width": 232, "height": 463}', 'ATX', '2020-03-15', 4.5, 380);

-- Insert Cooling
INSERT INTO components (name, model, description, price, category_id, vendor_id, image_url, specifications, performance_score, power_consumption, dimensions, release_date, rating, review_count) VALUES
-- Air Coolers
('Noctua NH-D15', 'NH-D15', 'Premium dual-tower air cooler with 140mm fans', 99.99, 8, 12, 'https://example.com/nh-d15.jpg',
 '{"cooler_type": "Air", "fan_size": "140mm", "fan_count": 2, "heatpipes": 6, "max_tdp": "220W", "noise_level": "24.6dB", "socket_support": ["LGA1700", "AM5", "AM4"]}',
 9.8, 6, '{"length": 165, "width": 150, "height": 161}', '2014-05-15', 4.9, 890),

('be quiet! Dark Rock Pro 4', 'BK022', 'Silent dual-tower air cooler', 89.99, 8, 13, 'https://example.com/dark-rock-pro-4.jpg',
 '{"cooler_type": "Air", "fan_size": "135mm", "fan_count": 1, "heatpipes": 7, "max_tdp": "250W", "noise_level": "24.3dB", "socket_support": ["LGA1700", "AM5", "AM4"]}',
 9.6, 5, '{"length": 163, "width": 136, "height": 163}', '2018-06-15', 4.8, 720),

('DeepCool AK620', 'R-AK620-BKNNMT-G', 'High-performance dual-tower air cooler', 69.99, 8, 13, 'https://example.com/ak620.jpg',
 '{"cooler_type": "Air", "fan_size": "120mm", "fan_count": 2, "heatpipes": 6, "max_tdp": "260W", "noise_level": "27dB", "socket_support": ["LGA1700", "AM5", "AM4"]}',
 9.3, 6, '{"length": 160, "width": 138, "height": 160}', '2021-08-15', 4.6, 580),

-- Liquid Coolers
('Corsair H150i Elite Capellix', 'CW-9060048-WW', '360mm AIO liquid cooler with RGB', 189.99, 8, 7, 'https://example.com/h150i-elite-capellix.jpg',
 '{"cooler_type": "AIO Liquid", "radiator_size": "360mm", "fan_size": "120mm", "fan_count": 3, "max_tdp": "300W", "noise_level": "28dB", "socket_support": ["LGA1700", "AM5", "AM4"]}',
 9.7, 12, '{"length": 394, "width": 120, "height": 27}', '2020-09-15', 4.8, 650),

('NZXT Kraken X73', 'RL-KRX73-01', '360mm AIO liquid cooler', 159.99, 8, 15, 'https://example.com/kraken-x73.jpg',
 '{"cooler_type": "AIO Liquid", "radiator_size": "360mm", "fan_size": "120mm", "fan_count": 3, "max_tdp": "280W", "noise_level": "27dB", "socket_support": ["LGA1700", "AM5", "AM4"]}',
 9.5, 11, '{"length": 394, "width": 120, "height": 27}', '2020-03-15', 4.7, 520),

('Arctic Liquid Freezer II 360', 'ACFRE00068A', '360mm AIO liquid cooler with thick radiator', 129.99, 8, 13, 'https://example.com/liquid-freezer-ii-360.jpg',
 '{"cooler_type": "AIO Liquid", "radiator_size": "360mm", "fan_size": "120mm", "fan_count": 3, "max_tdp": "300W", "noise_level": "22.5dB", "socket_support": ["LGA1700", "AM5", "AM4"]}',
 9.4, 10, '{"length": 394, "width": 120, "height": 38}', '2019-08-15', 4.6, 480);
