# PC Builder - SQL Migration Guide

This document explains the migration from Django ORM to raw SQL queries for the PC Builder application.

## Overview

The application has been converted from using Django ORM to raw SQL queries for better performance, flexibility, and control over database operations. The new system includes:

- **Comprehensive Database Schema**: Extended tables with additional attributes for future scalability
- **Raw SQL Views**: All database operations now use optimized SQL queries
- **Sample Data**: Pre-populated database with various PC components
- **Compatibility Rules**: Advanced component compatibility checking
- **Performance Optimizations**: Indexes, triggers, and stored procedures

## Database Schema

### Core Tables

1. **users** - Extended user management with additional fields
2. **categories** - Component categories (CPU, GPU, etc.)
3. **vendors** - Hardware manufacturers and retailers
4. **components** - Individual hardware components with comprehensive specs
5. **builds** - User-created PC configurations
6. **build_components** - Junction table for build-component relationships
7. **compatibility_rules** - Component compatibility constraints
8. **user_favorites** - User favorite components
9. **component_reviews** - User reviews and ratings
10. **price_history** - Component price tracking

### Additional Features

- **JSONB Fields**: Flexible specifications storage
- **Performance Metrics**: Built-in performance scoring
- **Compatibility Attributes**: Socket types, form factors, power ratings
- **Automatic Triggers**: Price calculations and timestamp updates
- **Comprehensive Indexing**: Optimized for common queries

## Setup Instructions

### 1. Database Setup

```bash
# Create and apply the database schema
psql -U your_username -d your_database -f database_schema.sql

# Initialize categories and vendors
psql -U your_username -d your_database -f initialize_categories_vendors.sql

# Populate with sample components
psql -U your_username -d your_database -f initialize_components.sql
```

### 2. Django Configuration

Update your `settings.py` to use PostgreSQL:

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'pc_builder_db',
        'USER': 'your_username',
        'PASSWORD': 'your_password',
        'HOST': 'localhost',
        'PORT': '5432',
    }
}
```

### 3. Install Dependencies

```bash
pip install psycopg2-binary
```

## API Endpoints

The new SQL-based API provides the following endpoints:

### Authentication
- `POST /api/v1/register/` - User registration
- `POST /api/v1/login/` - User login
- `POST /api/v1/logout/` - User logout
- `GET /api/v1/me/` - Get current user info
- `POST /api/v1/token/` - Get JWT tokens

### Components
- `GET /api/v1/categories/` - Get all categories
- `GET /api/v1/vendors/` - Get all vendors
- `GET /api/v1/components/` - Get all components (with filtering)
- `GET /api/v1/components/{id}/` - Get specific component
- `GET /api/v1/categories/{slug}/components/` - Get components by category
- `GET /api/v1/search/` - Search components

### Builds
- `POST /api/v1/builds/` - Create new build
- `GET /api/v1/users/{id}/builds/` - Get user builds
- `GET /api/v1/builds/{id}/` - Get build details

### Compatibility
- `GET /api/v1/compatibility-rules/` - Get compatibility rules

## Query Examples

### Get Components with Filtering

```python
# Get all components
GET /api/v1/components/

# Filter by category
GET /api/v1/components/?category_id=1

# Filter by price range
GET /api/v1/components/?min_price=100&max_price=500

# Filter by vendor
GET /api/v1/components/?vendor_id=2
```

### Search Components

```python
# Search by name/model/description
GET /api/v1/search/?q=RTX 4090

# Search with category filter
GET /api/v1/search/?q=gaming&category=gpu

# Search with price range
GET /api/v1/search/?q=processor&min_price=200&max_price=800
```

### Create Build

```python
POST /api/v1/builds/
{
    "user_id": 1,
    "name": "Gaming Beast",
    "description": "High-end gaming PC",
    "is_public": true,
    "build_type": "gaming",
    "components": [
        {"component_id": 1, "quantity": 1, "notes": "CPU"},
        {"component_id": 4, "quantity": 1, "notes": "GPU"},
        {"component_id": 7, "quantity": 1, "notes": "Motherboard"}
    ]
}
```

## Database Features

### Automatic Price Calculation

The database automatically calculates build total prices using triggers:

```sql
-- Trigger automatically updates build total when components are added/removed
CREATE TRIGGER trigger_update_build_total_price
    AFTER INSERT OR UPDATE OR DELETE ON build_components
    FOR EACH ROW EXECUTE FUNCTION update_build_total_price();
```

### Compatibility Checking

Advanced compatibility rules stored as JSON:

```sql
-- Example compatibility rule
INSERT INTO compatibility_rules (source_category_id, target_category_id, rule_type, condition) VALUES
(1, 3, 'socket_match', '{"attribute": "socket_type", "operator": "equals"}');
```

### Performance Optimizations

- **GIN Indexes**: For JSONB fields (specifications, dimensions)
- **Composite Indexes**: For common query patterns
- **Partial Indexes**: For active components only

## Sample Data

The database comes pre-populated with:

- **8 Categories**: CPU, GPU, Motherboard, Memory, Storage, Power Supply, Case, Cooling
- **15 Vendors**: Intel, AMD, NVIDIA, ASUS, MSI, Gigabyte, Corsair, Samsung, etc.
- **40+ Components**: Including latest generation CPUs, GPUs, and accessories
- **Compatibility Rules**: Socket matching, form factor compatibility, power requirements

## Migration Benefits

### Performance
- **Faster Queries**: Optimized SQL with proper indexing
- **Reduced ORM Overhead**: Direct database access
- **Better Query Planning**: Full control over SQL execution

### Flexibility
- **Complex Queries**: Advanced filtering and searching
- **JSON Support**: Flexible specifications storage
- **Custom Functions**: Database-level business logic

### Scalability
- **Future-Proof Schema**: Additional attributes for expansion
- **Performance Monitoring**: Built-in metrics and tracking
- **Compatibility Engine**: Advanced component matching

## Frontend Integration

The frontend doesn't need changes as the API endpoints remain the same. The new SQL-based backend provides:

- **Same Response Format**: Compatible with existing frontend
- **Enhanced Data**: Additional fields for better UX
- **Better Performance**: Faster loading times
- **Advanced Features**: Search, filtering, compatibility checking

## Troubleshooting

### Common Issues

1. **Database Connection**: Ensure PostgreSQL is running and credentials are correct
2. **Schema Errors**: Run schema files in order (schema → categories/vendors → components)
3. **Permission Issues**: Ensure database user has proper permissions

### Performance Tuning

1. **Index Optimization**: Monitor query performance and add indexes as needed
2. **Query Optimization**: Use EXPLAIN ANALYZE to identify slow queries
3. **Connection Pooling**: Consider using connection pooling for high traffic

## Future Enhancements

The new SQL-based system provides a foundation for:

- **Real-time Pricing**: Integration with price tracking APIs
- **Advanced Analytics**: User behavior and component popularity
- **AI Recommendations**: Machine learning-based component suggestions
- **Inventory Management**: Stock tracking and availability
- **Price Alerts**: Notifications for price drops
- **Build Sharing**: Social features for sharing builds
- **Performance Benchmarks**: Real-world performance data

## Support

For issues or questions about the SQL migration:

1. Check the database logs for error messages
2. Verify all SQL files have been executed successfully
3. Test API endpoints to ensure proper functionality
4. Review the compatibility rules for component matching

The new system provides a robust, scalable foundation for the PC Builder application with enhanced performance and flexibility.
