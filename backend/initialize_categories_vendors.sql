-- Initialize Categories and Vendors
-- Insert Categories
INSERT INTO categories (name, slug, icon, description, sort_order) VALUES
('CPU', 'cpu', 'cpu', 'Central Processing Units - The brain of your computer', 1),
('GPU', 'gpu', 'gpu', 'Graphics Processing Units - Handles graphics and gaming performance', 2),
('Motherboard', 'motherboard', 'motherboard', 'Main circuit board that connects all components', 3),
('Memory', 'memory', 'memory', 'RAM modules for system memory', 4),
('Storage', 'storage', 'storage', 'Hard drives and SSDs for data storage', 5),
('Power Supply', 'psu', 'psu', 'Power supply units to power your system', 6),
('Case', 'case', 'case', 'Computer cases and enclosures', 7),
('Cooling', 'cooling', 'cooling', 'CPU coolers and case fans', 8);

-- Insert Vendors
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
('NZXT', 'https://www.nzxt.com', 'https://example.com/nzxt-logo.png', 'USA', 'Gaming PC cases and accessories');
