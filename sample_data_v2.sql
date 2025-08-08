-- Sample Data for PC Builder Database v2.0
-- Comprehensive data for all component types

-- ========================================
-- VENDORS
-- ========================================

INSERT INTO vendors (name, website, logo_url, country, description) VALUES
('Intel', 'https://www.intel.com', 'https://example.com/intel-logo.png', 'USA', 'Leading CPU manufacturer'),
('AMD', 'https://www.amd.com', 'https://example.com/amd-logo.png', 'USA', 'Advanced Micro Devices'),
('NVIDIA', 'https://www.nvidia.com', 'https://example.com/nvidia-logo.png', 'USA', 'Graphics technology company'),
('ASUS', 'https://www.asus.com', 'https://example.com/asus-logo.png', 'Taiwan', 'Computer hardware manufacturer'),
('MSI', 'https://www.msi.com', 'https://example.com/msi-logo.png', 'Taiwan', 'Gaming hardware manufacturer'),
('Gigabyte', 'https://www.gigabyte.com', 'https://example.com/gigabyte-logo.png', 'Taiwan', 'Computer hardware manufacturer'),
('Corsair', 'https://www.corsair.com', 'https://example.com/corsair-logo.png', 'USA', 'Gaming peripherals and components'),
('Samsung', 'https://www.samsung.com', 'https://example.com/samsung-logo.png', 'South Korea', 'Electronics manufacturer'),
('Western Digital', 'https://www.westerndigital.com', 'https://example.com/wd-logo.png', 'USA', 'Data storage company'),
('Seagate', 'https://www.seagate.com', 'https://example.com/seagate-logo.png', 'USA', 'Data storage company'),
('EVGA', 'https://www.evga.com', 'https://example.com/evga-logo.png', 'USA', 'Graphics cards and power supplies'),
('Noctua', 'https://www.noctua.at', 'https://example.com/noctua-logo.png', 'Austria', 'Premium cooling solutions'),
('be quiet!', 'https://www.bequiet.com', 'https://example.com/bequiet-logo.png', 'Germany', 'Silent PC components'),
('Fractal Design', 'https://www.fractal-design.com', 'https://example.com/fractal-logo.png', 'Sweden', 'PC cases and cooling'),
('NZXT', 'https://www.nzxt.com', 'https://example.com/nzxt-logo.png', 'USA', 'Gaming PC cases and accessories'),
('Crucial', 'https://www.crucial.com', 'https://example.com/crucial-logo.png', 'USA', 'Memory and storage solutions'),
('G.Skill', 'https://www.gskill.com', 'https://example.com/gskill-logo.png', 'Taiwan', 'High-performance memory'),
('Kingston', 'https://www.kingston.com', 'https://example.com/kingston-logo.png', 'USA', 'Memory and storage solutions'),
('Cooler Master', 'https://www.coolermaster.com', 'https://example.com/coolermaster-logo.png', 'Taiwan', 'PC cooling and cases'),
('Phanteks', 'https://www.phanteks.com', 'https://example.com/phanteks-logo.png', 'Netherlands', 'PC cases and cooling');

-- ========================================
-- CPUs (Processors)
-- ========================================

INSERT INTO cpus (name, model, vendor_id, price, image_url, description, socket_type, cores, threads, base_clock, boost_clock, cache_size, tdp, architecture, process_node, integrated_graphics, overclockable, performance_score, gaming_score, productivity_score, release_date, rating, review_count, stock_quantity) VALUES
-- Intel CPUs
('Intel Core i9-13900K', '13900K', 1, 589.99, 'https://example.com/i9-13900k.jpg', '24-core (8P + 16E) processor with up to 5.8GHz boost', 'LGA1700', 24, 32, 3.0, 5.8, '36MB', 253, 'Raptor Lake', '10nm', true, true, 9.8, 9.9, 9.7, '2022-10-20', 4.7, 1250, 50),
('Intel Core i7-13700K', '13700K', 1, 409.99, 'https://example.com/i7-13700k.jpg', '16-core (8P + 8E) processor with up to 5.4GHz boost', 'LGA1700', 16, 24, 3.4, 5.4, '30MB', 253, 'Raptor Lake', '10nm', true, true, 9.2, 9.4, 9.0, '2022-10-20', 4.6, 980, 75),
('Intel Core i5-13600K', '13600K', 1, 319.99, 'https://example.com/i5-13600k.jpg', '14-core (6P + 8E) processor with up to 5.1GHz boost', 'LGA1700', 14, 20, 3.5, 5.1, '24MB', 181, 'Raptor Lake', '10nm', true, true, 8.5, 8.8, 8.2, '2022-10-20', 4.5, 850, 100),
('Intel Core i9-14900K', '14900K', 1, 599.99, 'https://example.com/i9-14900k.jpg', '24-core (8P + 16E) processor with up to 6.0GHz boost', 'LGA1700', 24, 32, 3.2, 6.0, '36MB', 253, 'Raptor Lake Refresh', '10nm', true, true, 9.9, 10.0, 9.8, '2023-10-17', 4.8, 650, 30),

-- AMD CPUs
('AMD Ryzen 9 7950X', '7950X', 2, 699.99, 'https://example.com/ryzen-9-7950x.jpg', '16-core processor with up to 5.7GHz boost', 'AM5', 16, 32, 4.5, 5.7, '80MB', 170, 'Zen 4', '5nm', true, true, 9.7, 9.8, 9.6, '2022-09-27', 4.7, 1100, 40),
('AMD Ryzen 7 7700X', '7700X', 2, 399.99, 'https://example.com/ryzen-7-7700x.jpg', '8-core processor with up to 5.4GHz boost', 'AM5', 8, 16, 4.5, 5.4, '40MB', 105, 'Zen 4', '5nm', true, true, 8.8, 9.1, 8.5, '2022-09-27', 4.6, 920, 80),
('AMD Ryzen 5 7600X', '7600X', 2, 299.99, 'https://example.com/ryzen-5-7600x.jpg', '6-core processor with up to 5.3GHz boost', 'AM5', 6, 12, 4.7, 5.3, '38MB', 105, 'Zen 4', '5nm', true, true, 8.2, 8.5, 7.9, '2022-09-27', 4.5, 780, 120),
('AMD Ryzen 9 7900X3D', '7900X3D', 2, 599.99, 'https://example.com/ryzen-9-7900x3d.jpg', '12-core processor with 3D V-Cache technology', 'AM5', 12, 24, 4.4, 5.6, '140MB', 120, 'Zen 4', '5nm', true, true, 9.6, 9.9, 9.3, '2023-02-28', 4.8, 450, 25);

-- ========================================
-- MOTHERBOARDS
-- ========================================

INSERT INTO motherboards (name, model, vendor_id, price, image_url, description, socket_type, form_factor, ram_type, ram_slots, max_ram_capacity, max_ram_speed, pcie_slots, pcie_x16_slots, pcie_x8_slots, pcie_x4_slots, pcie_x1_slots, sata_ports, m2_slots, m2_pcie_slots, usb_ports, usb_3_2_ports, usb_3_1_ports, usb_2_0_ports, ethernet_ports, wifi, bluetooth, power_connector, performance_score, overclocking_score, release_date, rating, review_count, stock_quantity) VALUES
-- Intel LGA1700 Motherboards
('ASUS ROG Maximus Z790 Hero', 'Z790 Hero', 4, 449.99, 'https://example.com/asus-z790-hero.jpg', 'High-end Intel Z790 motherboard with premium features', 'LGA1700', 'ATX', 'DDR5', 4, '128GB', 7800, 4, 2, 1, 1, 0, 4, 4, 3, 12, 4, 4, 4, 1, true, true, '24-pin + 8-pin + 8-pin', 9.5, 9.8, '2022-10-20', 4.7, 320, 45),
('MSI MPG Z790 Gaming Edge WiFi', 'Z790 Gaming Edge', 5, 399.99, 'https://example.com/msi-z790-gaming-edge.jpg', 'Gaming-focused Z790 motherboard with WiFi 6E', 'LGA1700', 'ATX', 'DDR5', 4, '128GB', 7200, 4, 2, 1, 1, 0, 4, 4, 3, 10, 3, 4, 3, 1, true, true, '24-pin + 8-pin + 8-pin', 9.2, 9.5, '2022-10-20', 4.6, 280, 60),
('Gigabyte Z790 Aorus Elite AX', 'Z790 Aorus Elite', 6, 349.99, 'https://example.com/gigabyte-z790-aorus-elite.jpg', 'Feature-rich Z790 motherboard with excellent value', 'LGA1700', 'ATX', 'DDR5', 4, '128GB', 7600, 4, 2, 1, 1, 0, 4, 4, 3, 11, 3, 4, 4, 1, true, true, '24-pin + 8-pin + 8-pin', 9.0, 9.3, '2022-10-20', 4.5, 250, 80),

-- AMD AM5 Motherboards
('ASUS ROG Crosshair X670E Hero', 'X670E Hero', 4, 499.99, 'https://example.com/asus-x670e-hero.jpg', 'Premium AMD X670E motherboard for enthusiasts', 'AM5', 'ATX', 'DDR5', 4, '128GB', 6400, 4, 2, 1, 1, 0, 4, 4, 3, 12, 4, 4, 4, 1, true, true, '24-pin + 8-pin + 8-pin', 9.6, 9.9, '2022-09-27', 4.8, 180, 35),
('MSI MPG X670E Carbon WiFi', 'X670E Carbon', 5, 449.99, 'https://example.com/msi-x670e-carbon.jpg', 'High-performance X670E motherboard with carbon design', 'AM5', 'ATX', 'DDR5', 4, '128GB', 6600, 4, 2, 1, 1, 0, 4, 4, 3, 11, 3, 4, 4, 1, true, true, '24-pin + 8-pin + 8-pin', 9.3, 9.6, '2022-09-27', 4.7, 150, 50),
('Gigabyte X670E Aorus Master', 'X670E Aorus Master', 6, 479.99, 'https://example.com/gigabyte-x670e-aorus-master.jpg', 'Feature-packed X670E motherboard with premium build', 'AM5', 'ATX', 'DDR5', 4, '128GB', 6400, 4, 2, 1, 1, 0, 4, 4, 3, 12, 4, 4, 4, 1, true, true, '24-pin + 8-pin + 8-pin', 9.4, 9.7, '2022-09-27', 4.7, 120, 40);

-- ========================================
-- RAM (Memory)
-- ========================================

INSERT INTO ram_modules (name, model, vendor_id, price, image_url, description, capacity, capacity_per_module, modules_in_kit, ram_type, speed, cas_latency, voltage, form_factor, height_mm, rgb, heatsink, ecc, performance_score, release_date, rating, review_count, stock_quantity) VALUES
-- DDR5 RAM
('Corsair Dominator Platinum RGB', 'CMT32GX5M2X6000C36', 7, 199.99, 'https://example.com/corsair-dominator-ddr5.jpg', 'Premium DDR5 memory with RGB lighting', 32, 16, 2, 'DDR5', 6000, 36, 1.35, 'DIMM', 51, true, true, false, 9.5, '2022-10-20', 4.7, 420, 85),
('G.Skill Trident Z5 RGB', 'F5-6000J3636F16GX2-TZ5RK', 17, 189.99, 'https://example.com/gskill-trident-z5.jpg', 'High-performance DDR5 memory with RGB', 32, 16, 2, 'DDR5', 6000, 36, 1.35, 'DIMM', 44, true, true, false, 9.4, '2022-10-20', 4.6, 380, 95),
('Crucial Ballistix Max RGB', 'BLM2K16G56C36U4B', 16, 179.99, 'https://example.com/crucial-ballistix-max.jpg', 'Fast DDR5 memory with customizable RGB', 32, 16, 2, 'DDR5', 5600, 36, 1.25, 'DIMM', 39, true, true, false, 9.2, '2022-10-20', 4.5, 310, 110),

-- DDR4 RAM
('Corsair Vengeance RGB Pro', 'CMW32GX4M2D3600C18', 7, 149.99, 'https://example.com/corsair-vengeance-rgb.jpg', 'Popular DDR4 memory with RGB lighting', 32, 16, 2, 'DDR4', 3600, 18, 1.35, 'DIMM', 51, true, true, false, 8.8, '2021-03-15', 4.6, 1250, 200),
('G.Skill Ripjaws V', 'F4-3600C18D-32GVK', 17, 129.99, 'https://example.com/gskill-ripjaws-v.jpg', 'Reliable DDR4 memory with good performance', 32, 16, 2, 'DDR4', 3600, 18, 1.35, 'DIMM', 42, false, true, false, 8.6, '2021-03-15', 4.5, 980, 180),
('Kingston Fury Beast RGB', 'KF436C18BBK2/32', 18, 139.99, 'https://example.com/kingston-fury-beast.jpg', 'DDR4 memory with RGB and good value', 32, 16, 2, 'DDR4', 3600, 18, 1.35, 'DIMM', 42, true, true, false, 8.7, '2021-03-15', 4.5, 850, 160);

-- ========================================
-- GPUs (Graphics Cards)
-- ========================================

INSERT INTO gpus (name, model, vendor_id, price, image_url, description, chipset, memory_size, memory_type, memory_bus_width, base_clock, boost_clock, length_mm, width_mm, height_mm, slot_width, tdp, power_connector, recommended_psu_watts, performance_score, gaming_score, mining_score, ray_tracing, dlss, fsr, release_date, rating, review_count, stock_quantity) VALUES
-- NVIDIA RTX 40 Series
('NVIDIA GeForce RTX 4090', 'RTX 4090', 3, 1599.99, 'https://example.com/rtx-4090.jpg', 'Flagship graphics card with 24GB GDDR6X', 'RTX 4090', 24, 'GDDR6X', 384, 2235, 2520, 304, 137, 61, 3, 450, '16-pin', 850, 10.0, 10.0, 9.8, true, true, false, '2022-10-12', 4.9, 890, 15),
('NVIDIA GeForce RTX 4080', 'RTX 4080', 3, 1199.99, 'https://example.com/rtx-4080.jpg', 'High-end graphics card with 16GB GDDR6X', 'RTX 4080', 16, 'GDDR6X', 256, 2205, 2505, 304, 137, 61, 3, 320, '16-pin', 750, 9.5, 9.7, 9.3, true, true, false, '2022-11-16', 4.8, 650, 25),
('NVIDIA GeForce RTX 4070 Ti', 'RTX 4070 Ti', 3, 799.99, 'https://example.com/rtx-4070-ti.jpg', 'Mid-high graphics card with 12GB GDDR6X', 'RTX 4070 Ti', 12, 'GDDR6X', 192, 2310, 2610, 285, 112, 62, 2, 285, '8-pin + 8-pin', 700, 9.0, 9.2, 8.8, true, true, false, '2023-01-05', 4.7, 520, 40),

-- AMD RX 7000 Series
('AMD Radeon RX 7900 XTX', 'RX 7900 XTX', 2, 999.99, 'https://example.com/rx-7900-xtx.jpg', 'AMD flagship with 24GB GDDR6', 'RX 7900 XTX', 24, 'GDDR6', 384, 1900, 2500, 287, 135, 51, 2, 355, '8-pin + 8-pin', 800, 9.6, 9.8, 9.4, true, false, true, '2022-12-13', 4.8, 420, 20),
('AMD Radeon RX 7900 XT', 'RX 7900 XT', 2, 899.99, 'https://example.com/rx-7900-xt.jpg', 'High-end AMD graphics with 20GB GDDR6', 'RX 7900 XT', 20, 'GDDR6', 320, 1500, 2400, 287, 135, 51, 2, 315, '8-pin + 8-pin', 750, 9.3, 9.5, 9.1, true, false, true, '2022-12-13', 4.7, 380, 30),
('AMD Radeon RX 7800 XT', 'RX 7800 XT', 2, 499.99, 'https://example.com/rx-7800-xt.jpg', 'Mid-high AMD graphics with 16GB GDDR6', 'RX 7800 XT', 16, 'GDDR6', 256, 1800, 2430, 267, 120, 50, 2, 263, '8-pin + 8-pin', 700, 8.8, 9.0, 8.6, true, false, true, '2023-09-06', 4.6, 290, 55);

-- ========================================
-- STORAGE DEVICES
-- ========================================

INSERT INTO storage_devices (name, model, vendor_id, price, image_url, description, capacity, storage_type, interface, form_factor, read_speed, write_speed, random_read_iops, random_write_iops, height_mm, width_mm, depth_mm, cache_size, nand_type, endurance_tbw, performance_score, release_date, rating, review_count, stock_quantity) VALUES
-- NVMe SSDs
('Samsung 990 Pro', 'MZ-V9P2T0BW', 8, 199.99, 'https://example.com/samsung-990-pro.jpg', 'High-performance PCIe 4.0 NVMe SSD', 2000, 'SSD', 'PCIe', 'M.2', 7450, 6900, 1400000, 1550000, 2.38, 22, 80.15, '2GB', 'TLC', 1200, 9.8, '2022-10-20', 4.8, 1250, 120),
('WD Black SN850X', 'WDS2000X2G00E', 9, 189.99, 'https://example.com/wd-black-sn850x.jpg', 'Gaming-focused PCIe 4.0 NVMe SSD', 2000, 'SSD', 'PCIe', 'M.2', 7300, 6300, 1200000, 1100000, 2.38, 22, 80.15, '2GB', 'TLC', 1200, 9.6, '2022-07-15', 4.7, 980, 95),
('Crucial P5 Plus', 'CT2000P5PSSD8', 16, 179.99, 'https://example.com/crucial-p5-plus.jpg', 'Reliable PCIe 4.0 NVMe SSD', 2000, 'SSD', 'PCIe', 'M.2', 6600, 5000, 900000, 900000, 2.38, 22, 80.15, '1GB', 'TLC', 1200, 9.2, '2022-06-10', 4.6, 850, 110),

-- SATA SSDs
('Samsung 870 EVO', 'MZ-77E2T0BW', 8, 149.99, 'https://example.com/samsung-870-evo.jpg', 'Reliable SATA SSD with excellent endurance', 2000, 'SSD', 'SATA', '2.5"', 560, 530, 98000, 88000, 7, 100, 69.85, '1GB', 'TLC', 1200, 8.5, '2021-01-19', 4.7, 2100, 200),
('Crucial MX500', 'CT2000MX500SSD1', 16, 129.99, 'https://example.com/crucial-mx500.jpg', 'Great value SATA SSD', 2000, 'SSD', 'SATA', '2.5"', 560, 510, 95000, 90000, 7, 100, 69.85, '512MB', 'TLC', 700, 8.3, '2021-03-15', 4.6, 1800, 180),

-- HDDs
('Seagate Barracuda', 'ST2000DM008', 10, 49.99, 'https://example.com/seagate-barracuda.jpg', 'Reliable 2TB hard drive for storage', 2000, 'HDD', 'SATA', '3.5"', 190, 190, 80000, 80000, 26.1, 101.6, 146.99, '256MB', 'CMR', 55, 6.5, '2020-06-15', 4.4, 3200, 300),
('WD Blue', 'WD20EZBX', 9, 54.99, 'https://example.com/wd-blue.jpg', 'Dependable 2TB hard drive', 2000, 'HDD', 'SATA', '3.5"', 180, 180, 75000, 75000, 26.1, 101.6, 146.99, '256MB', 'CMR', 60, 6.7, '2020-08-20', 4.5, 2800, 280);

-- ========================================
-- POWER SUPPLIES
-- ========================================

INSERT INTO power_supplies (name, model, vendor_id, price, image_url, description, wattage, efficiency_rating, modular_type, atx_24pin, cpu_4pin, cpu_8pin, cpu_4_4pin, pcie_6pin, pcie_8pin, pcie_6_2pin, sata_connectors, molex_connectors, form_factor, height_mm, width_mm, depth_mm, fanless, rgb, overvoltage_protection, undervoltage_protection, short_circuit_protection, performance_score, efficiency_score, release_date, rating, review_count, stock_quantity) VALUES
-- High Wattage PSUs
('Corsair HX1500i', 'CP-9020210-NA', 7, 399.99, 'https://example.com/corsair-hx1500i.jpg', '1500W fully modular 80+ Platinum PSU', 1500, '80+ Platinum', 'Full', 1, 0, 0, 2, 0, 0, 6, 12, 4, 'ATX', 86, 150, 180, false, false, true, true, true, 9.8, 9.9, '2022-03-15', 4.9, 180, 25),
('EVGA SuperNOVA 1300 GT', '220-GT-1300-X1', 11, 299.99, 'https://example.com/evga-supernova-1300gt.jpg', '1300W fully modular 80+ Gold PSU', 1300, '80+ Gold', 'Full', 1, 0, 0, 2, 0, 0, 6, 10, 4, 'ATX', 86, 150, 180, false, false, true, true, true, 9.5, 9.7, '2022-01-20', 4.7, 220, 40),
('Seasonic PRIME TX-1000', 'SSR-1000TR', 20, 349.99, 'https://example.com/seasonic-prime-tx1000.jpg', '1000W fully modular 80+ Titanium PSU', 1000, '80+ Titanium', 'Full', 1, 0, 0, 2, 0, 0, 4, 8, 4, 'ATX', 86, 150, 180, false, false, true, true, true, 9.6, 9.8, '2021-11-10', 4.8, 150, 35),

-- Mid-range PSUs
('Corsair RM850x', 'CP-9020200-NA', 7, 149.99, 'https://example.com/corsair-rm850x.jpg', '850W fully modular 80+ Gold PSU', 850, '80+ Gold', 'Full', 1, 0, 0, 2, 0, 0, 4, 8, 4, 'ATX', 86, 150, 180, false, false, true, true, true, 9.2, 9.4, '2021-06-15', 4.7, 850, 120),
('EVGA SuperNOVA 750 GT', '220-GT-0750-X1', 11, 99.99, 'https://example.com/evga-supernova-750gt.jpg', '750W fully modular 80+ Gold PSU', 750, '80+ Gold', 'Full', 1, 0, 0, 2, 0, 0, 4, 6, 4, 'ATX', 86, 150, 180, false, false, true, true, true, 8.8, 9.2, '2021-03-20', 4.6, 680, 150),
('be quiet! Straight Power 11 650W', 'BN297', 13, 119.99, 'https://example.com/bequiet-straight-power-11.jpg', '650W fully modular 80+ Gold PSU', 650, '80+ Gold', 'Full', 1, 0, 0, 2, 0, 0, 4, 6, 4, 'ATX', 86, 150, 180, false, false, true, true, true, 8.9, 9.3, '2021-01-15', 4.6, 520, 100);

-- ========================================
-- CASES
-- ========================================

INSERT INTO cases (name, model, vendor_id, price, image_url, description, motherboard_form_factors, height_mm, width_mm, depth_mm, volume_liters, max_gpu_length_mm, max_gpu_width_mm, max_gpu_height_mm, max_cooler_height_mm, drive_bays_3_5, drive_bays_2_5, included_fans, max_fans, fan_sizes, radiator_support, side_panel_type, front_panel_io, dust_filters, tempered_glass, rgb, airflow_score, noise_level_score, release_date, rating, review_count, stock_quantity) VALUES
-- Full Tower Cases
('Phanteks Enthoo 719', 'PH-ES719LTG_DAG01', 20, 299.99, 'https://example.com/phanteks-enthoo-719.jpg', 'Massive full tower case with excellent airflow', ARRAY['E-ATX', 'ATX', 'Micro-ATX', 'Mini-ITX'], 518, 240, 560, 69.6, 500, 180, 180, 190, 6, 8, 3, 14, ARRAY[120, 140, 200], ARRAY['360mm top', '360mm front', '420mm top', '420mm front'], 'Tempered Glass', 'USB 3.0 x2, USB 3.1 Type-C x1, Audio', true, true, false, 9.5, 8.8, '2021-03-15', 4.8, 120, 30),
('Fractal Design Torrent', 'FD-C-TOR1A-01', 14, 199.99, 'https://example.com/fractal-torrent.jpg', 'Innovative airflow-focused case', ARRAY['E-ATX', 'ATX', 'Micro-ATX', 'Mini-ITX'], 467, 240, 474, 53.1, 467, 172, 180, 188, 2, 4, 5, 7, ARRAY[120, 140, 180], ARRAY['360mm front', '280mm top'], 'Tempered Glass', 'USB 3.0 x2, USB 3.1 Type-C x1, Audio', true, true, false, 9.8, 8.5, '2021-08-20', 4.9, 280, 45),

-- Mid Tower Cases
('NZXT H7 Flow', 'CA-H7FW-B1', 15, 129.99, 'https://example.com/nzxt-h7-flow.jpg', 'Clean mid tower with excellent airflow', ARRAY['ATX', 'Micro-ATX', 'Mini-ITX'], 460, 230, 446, 47.2, 400, 165, 180, 167, 2, 3, 3, 6, ARRAY[120, 140], ARRAY['360mm front', '280mm top'], 'Tempered Glass', 'USB 3.0 x2, USB 3.1 Type-C x1, Audio', true, true, false, 9.2, 8.9, '2021-10-15', 4.7, 420, 80),
('Corsair 4000D Airflow', 'CC-9011200-WW', 7, 94.99, 'https://example.com/corsair-4000d-airflow.jpg', 'Popular mid tower with great airflow', ARRAY['ATX', 'Micro-ATX', 'Mini-ITX'], 460, 230, 453, 48.0, 360, 160, 170, 170, 2, 2, 2, 6, ARRAY[120, 140], ARRAY['360mm front', '280mm top'], 'Tempered Glass', 'USB 3.0 x2, USB 3.1 Type-C x1, Audio', true, true, false, 9.0, 9.1, '2020-06-15', 4.6, 650, 120),
('be quiet! Pure Base 500DX', 'BGW37', 13, 109.99, 'https://example.com/bequiet-pure-base-500dx.jpg', 'Silent case with RGB accents', ARRAY['ATX', 'Micro-ATX', 'Mini-ITX'], 450, 232, 463, 48.4, 369, 165, 180, 190, 2, 2, 3, 6, ARRAY[120, 140], ARRAY['360mm front', '240mm top'], 'Tempered Glass', 'USB 3.0 x2, USB 3.1 Type-C x1, Audio', true, true, true, 8.8, 9.3, '2020-03-20', 4.7, 380, 90);

-- ========================================
-- CPU COOLERS
-- ========================================

INSERT INTO cpu_coolers (name, model, vendor_id, price, image_url, description, cooler_type, socket_support, height_mm, width_mm, depth_mm, fan_size_mm, fan_count, fan_speed_min, fan_speed_max, fan_noise_min, fan_noise_max, radiator_size_mm, pump_speed, tdp_rating, performance_score, noise_level_score, rgb, pwm_control, release_date, rating, review_count, stock_quantity) VALUES
-- Air Coolers
('Noctua NH-D15', 'NH-D15', 12, 99.99, 'https://example.com/noctua-nh-d15.jpg', 'Premium air cooler with excellent performance', 'Air', ARRAY['LGA1700', 'LGA1200', 'LGA1151', 'AM5', 'AM4'], 165, 150, 135, 140, 2, 300, 1500, 24.6, 24.6, NULL, NULL, 220, 9.5, 9.8, false, true, '2014-05-15', 4.9, 2100, 150),
('be quiet! Dark Rock Pro 4', 'BK022', 13, 89.99, 'https://example.com/bequiet-dark-rock-pro-4.jpg', 'Silent air cooler with great performance', 'Air', ARRAY['LGA1700', 'LGA1200', 'LGA1151', 'AM5', 'AM4'], 163, 136, 145, 135, 1, 300, 1500, 24.3, 24.3, NULL, NULL, 250, 9.3, 9.9, false, true, '2018-03-20', 4.8, 1800, 120),
('Cooler Master Hyper 212 EVO V2', 'RR-2V2E-18PK-R1', 19, 44.99, 'https://example.com/coolermaster-hyper-212-evo-v2.jpg', 'Popular budget air cooler', 'Air', ARRAY['LGA1700', 'LGA1200', 'LGA1151', 'AM5', 'AM4'], 159, 120, 79, 120, 1, 650, 2000, 26, 26, NULL, NULL, 150, 8.2, 8.5, false, true, '2020-06-10', 4.5, 950, 200),

-- Liquid Coolers
('Corsair H150i Elite Capellix', 'CW-9060048-WW', 7, 199.99, 'https://example.com/corsair-h150i-elite.jpg', '360mm AIO with RGB fans', 'Liquid', ARRAY['LGA1700', 'LGA1200', 'LGA1151', 'AM5', 'AM4'], 52, 120, 27, 120, 3, 400, 2400, 28, 37, 360, 2400, 300, 9.6, 8.8, true, true, '2021-01-15', 4.8, 680, 80),
('NZXT Kraken X73', 'RL-KRX73-01', 15, 179.99, 'https://example.com/nzxt-kraken-x73.jpg', '280mm AIO with excellent performance', 'Liquid', ARRAY['LGA1700', 'LGA1200', 'LGA1151', 'AM5', 'AM4'], 52, 120, 27, 120, 3, 500, 2000, 21, 36, 280, 2000, 280, 9.4, 9.0, false, true, '2020-03-15', 4.7, 520, 95),
('Arctic Liquid Freezer II 240', 'ACFRE00045A', 20, 89.99, 'https://example.com/arctic-liquid-freezer-ii-240.jpg', 'Great value 240mm AIO', 'Liquid', ARRAY['LGA1700', 'LGA1200', 'LGA1151', 'AM5', 'AM4'], 52, 120, 27, 120, 2, 200, 1800, 22.5, 22.5, 240, 1800, 250, 9.1, 9.2, false, true, '2019-08-20', 4.6, 420, 110);
