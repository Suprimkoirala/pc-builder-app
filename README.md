# 🖥️ PC Builder App

A full-stack web application that lets users browse PC components, create builds, and manage configurations. Built using Django (MySQL + DRF + JWT) for the backend and React + TypeScript for the frontend.

---

## 🚀 Features

- 🔐 JWT Authentication with Login/Signup
- 🔧 Browse and manage PC components (CPU, GPU, etc.)
- 🛠️ Create and save custom PC builds
- 📦 RESTful API powered by Django REST Framework
- 🎨 Frontend UI with TailwindCSS and React Context for auth
- 🧪 MySQL as the production-grade database

---

## 📁 Project Structure

DBMS/
│
├── backend/ # Django backend
│ ├── config/ # Django project settings
│ ├── pcbuilder/ # App for components/builds
│ ├── manage.py
│ └── ...
│
├── frontend/ # React + Vite + TypeScript
│ ├── src/
│ ├── public/
│ └── ...
---

## ⚙️ Backend Setup (Django + MySQL)

### ✅ Prerequisites
- Python 3.10+
- MySQL Server (v8.0+ required)
- pip
- Virtualenv

### 🔨 Step-by-Step

```bash
# Go to backend directory
cd backend

# Set up virtual environment
python -m venv venv
venv\Scripts\activate  # On Windows

# Install dependencies
pip install -r requirements.txt


🔧 Update settings.py
Set your database:

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'dbms_project',
        'USER': 'your_mysql_user',
        'PASSWORD': 'your_mysql_password',
        'HOST': 'localhost',
        'PORT': '3306',
    }
}

🔄 Migrate & Load Sample Data

python manage.py makemigrations
python manage.py migrate
python manage.py loaddata test_data.json

👤 Create Superuser

python manage.py createsuperuser


🏃 Run the Server

python manage.py runserver
Visit: http://localhost:8000/admin



🖼️ Frontend Setup (React + Vite + TypeScript)

✅ Prerequisites
Node.js 18+
npm

🔨 Steps
# Go to frontend folder
cd frontend

# Install dependencies
npm install

# Start dev server
npm run dev
Visit: http://localhost:5173


```

![CodeRabbit Pull Request Reviews](https://img.shields.io/coderabbit/prs/github/atultiwari000/pc-builder-app?utm_source=oss&utm_medium=github&utm_campaign=atultiwari000%2Fpc-builder-app&labelColor=171717&color=FF570A&link=https%3A%2F%2Fcoderabbit.ai&label=CodeRabbit+Reviews)


