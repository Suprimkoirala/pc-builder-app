from django.contrib.auth.models import AbstractUser, BaseUserManager, PermissionsMixin
from django.db import models
from django.core.validators import MinValueValidator, RegexValidator
from django.urls import reverse
import json

class CustomUserManager(BaseUserManager):
    def create_user(self, email, password=None, **extra_fields):
        if not email:
            raise ValueError("The Email field must be set")
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, password=None, **extra_fields):
        extra_fields.setdefault("is_staff", True)
        extra_fields.setdefault("is_superuser", True)

        return self.create_user(email, password, **extra_fields)

class User(AbstractUser, PermissionsMixin):
    email = models.EmailField(unique=True)
    username = models.CharField(max_length=150, blank=True)
    bio = models.TextField(blank=True)
    avatar = models.ImageField(upload_to="avatars/", null=True, blank=True)
    is_pro_builder = models.BooleanField(default=False)
    is_staff = models.BooleanField(default=False)

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    objects = CustomUserManager()

    def __str__(self):
        return self.email

class Category(models.Model):
    """Component categories (CPU, GPU, etc.)"""
    name = models.CharField(max_length=50, unique=True)
    slug = models.SlugField(unique=True)
    icon = models.CharField(max_length=50, blank=True)  # Font Awesome class

    def __str__(self):
        return self.name

class Vendor(models.Model):
    """Hardware manufacturers and retailers"""
    name = models.CharField(max_length=100, unique=True)
    website = models.URLField()
    logo = models.URLField(blank=True)

    def __str__(self):
        return self.name

class Component(models.Model):
    """Individual hardware components"""
    name = models.CharField(max_length=200)
    description = models.TextField()
    price = models.DecimalField(
        max_digits=10, 
        decimal_places=2, 
        validators=[MinValueValidator(0)]
    )
    category = models.ForeignKey(Category, on_delete=models.CASCADE)
    vendor = models.ForeignKey(Vendor, on_delete=models.CASCADE)
    image = models.URLField()
    specs = models.JSONField(default=dict)  # e.g. {"clock_speed": "3.5GHz"}
    stock = models.IntegerField(default=100)  # Inventory tracking

    def get_absolute_url(self):
        return reverse('component-detail', args=[str(self.id)])

    def __str__(self):
        return f"{self.name} ({self.category})"

class Build(models.Model):
    """User-created PC configurations"""
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=100)
    description = models.TextField(blank=True)
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)
    is_public = models.BooleanField(default=True)
    total_price = models.DecimalField(
        max_digits=12, 
        decimal_places=2, 
        editable=False
    )

    def save(self, *args, **kwargs):
        self.total_price = sum(bc.component.price * bc.quantity for bc in self.components.all())
        super().save(*args, **kwargs)

    def __str__(self):
        return f"{self.user.username}'s {self.name}"

class BuildComponent(models.Model):
    """Through table for build-component relationships"""
    build = models.ForeignKey(Build, on_delete=models.CASCADE, related_name='components')
    component = models.ForeignKey(Component, on_delete=models.CASCADE)
    quantity = models.IntegerField(default=1, validators=[MinValueValidator(1)])
    notes = models.CharField(max_length=200, blank=True)

    class Meta:
        unique_together = [['build', 'component']]

    def __str__(self):
        return f"{self.component.name} x{self.quantity} in {self.build.name}"

class CompatibilityRule(models.Model):
    """Component compatibility constraints"""
    source = models.ForeignKey(
        Category, 
        on_delete=models.CASCADE, 
        related_name='source_rules'
    )
    target = models.ForeignKey(
        Category, 
        on_delete=models.CASCADE, 
        related_name='target_rules'
    )
    condition = models.JSONField(
        help_text='Example: {"attribute": "socket", "operator": "equals"}'
    )

    def __str__(self):
        return f"{self.source} ↔ {self.target}: {json.dumps(self.condition)}"