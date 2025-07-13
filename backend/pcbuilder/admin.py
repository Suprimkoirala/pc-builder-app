from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as DefaultUserAdmin
from .models import (
    User,
    Category,
    Vendor,
    Component,
    Build,
    BuildComponent,
    CompatibilityRule,
)

@admin.register(User)
class UserAdmin(DefaultUserAdmin):
    fieldsets = DefaultUserAdmin.fieldsets + (
        (None, {'fields': ('bio', 'avatar', 'is_pro_builder')}),
    )
    list_display = ('username', 'email', 'is_staff', 'is_pro_builder')

@admin.register(Category)
class CategoryAdmin(admin.ModelAdmin):
    list_display = ('name', 'slug', 'icon')
    prepopulated_fields = {'slug': ('name',)}

@admin.register(Vendor)
class VendorAdmin(admin.ModelAdmin):
    list_display = ('name', 'website')

@admin.register(Component)
class ComponentAdmin(admin.ModelAdmin):
    list_display = ('name', 'category', 'vendor', 'price', 'stock')
    list_filter = ('category', 'vendor')
    search_fields = ('name',)

@admin.register(Build)
class BuildAdmin(admin.ModelAdmin):
    list_display = ('name', 'user', 'total_price', 'created', 'is_public')
    list_filter = ('is_public', 'created')
    search_fields = ('name', 'user__username')

@admin.register(BuildComponent)
class BuildComponentAdmin(admin.ModelAdmin):
    list_display = ('build', 'component', 'quantity')
    list_filter = ('build',)
    search_fields = ('component__name',)

@admin.register(CompatibilityRule)
class CompatibilityRuleAdmin(admin.ModelAdmin):
    list_display = ('source', 'target', 'condition')
