#!/bin/bash

# Tutorial
# https://testdriven.io/blog/deploying-django-to-heroku-with-docker/#multi-stage-docker-build
# export env file containing configuration parameters such as database connection string

# venv
C:/Python310/python.exe -m ensurepip && C:/Python310/python.exe -m pip install --upgrade pip
C:/Python310/python.exe -m venv venv
source venv/Scripts/activate

# install packages
pip install django psycopg2-binary gunicorn whitenoise django-import-export django-jazzmin
pip freeze > requirements.txt

# setup project
django-admin startproject core .

# edit core/settings.py
echo "import os" >> core/settings.py

# echo -e "
# INSTALLED_APPS = ['jazzmin'] + INSTALLED_APPS
# " >> core/settings.py



echo -e "
INSTALLED_APPS = INSTALLED_APPS + ['import_export']
" >> core/settings.py

echo -e "DATABASES['postgres'] = {
    'ENGINE': 'django.db.backends.postgresql',
    'NAME': os.getenv('SETTINGS_POSTGRES_NAME', ''),
    'USER': os.getenv('SETTINGS_POSTGRES_USER', ''),
    'PASSWORD': os.getenv('SETTINGS_POSTGRES_PASSWORD', ''),
    'HOST': os.getenv('SETTINGS_POSTGRES_HOST', ''),
    'PORT': os.getenv('SETTINGS_POSTGRES_PORT', ''),
}
" >> core/settings.py

echo "IMPORT_EXPORT_USE_TRANSACTIONS = True" >> core/settings.py

echo "STATIC_ROOT = BASE_DIR / 'staticfiles'" >> core/settings.py
echo "STATIC_URL = '/static/'" >> core/settings.py

echo -e "
ALLOWED_HOSTS = ALLOWED_HOSTS + [
  'localhost',
  '127.0.0.1',
]
" >> core/settings.py

echo -e "
MIDDLEWARE = MIDDLEWARE + [
    'whitenoise.middleware.WhiteNoiseMiddleware'
]
" >> core/settings.py

echo -e "
STATICFILES_STORAGE = 'whitenoise.storage.CompressedManifestStaticFilesStorage'
" >> core/settings.py


sed -i 's/DEBUG = True/DEBUG = False/' core/settings.py # for production




# create default database
python manage.py makemigrations
python manage.py migrate


# create superuser
DJANGO_SUPERUSER_USERNAME=${DJANGO_SUPERUSER_USERNAME:-admin}
DJANGO_SUPERUSER_EMAIL=${DJANGO_SUPERUSER_EMAIL:-admin@admin.com}
DJANGO_SUPERUSER_PASSWORD=${DJANGO_SUPERUSER_PASSWORD:-admin}
DJANGO_SUPERUSER_PASSWORD=${DJANGO_SUPERUSER_PASSWORD} python manage.py createsuperuser --username ${DJANGO_SUPERUSER_USERNAME} --email ${DJANGO_SUPERUSER_EMAIL} --noinput


# collect static files into static_root folder
python manage.py collectstatic


# create app
python manage.py startapp example
echo -e "
INSTALLED_APPS = INSTALLED_APPS + ['example']
" >> core/settings.py


# run project
python manage.py makemigrations
python manage.py migrate
python manage.py runserver



# Dockerfile
# FROM python:3.10-alpine AS build-python
# RUN apk update && apk add --virtual build-essential gcc python3-dev musl-dev postgresql-dev
# RUN python -m venv /opt/venv
# ENV PATH="/opt/venv/bin:$PATH"
# COPY ./requirements.txt .
# RUN pip install -r requirements.txt

# FROM python:3.10-alpine
# ENV PYTHONDONTWRITEBYTECODE 1
# ENV PYTHONUNBUFFERED 1
# ENV DEBUG 0
# ENV PATH="/opt/venv/bin:$PATH"
# COPY --from=build-python /opt/venv /opt/venv
# RUN apk update && apk add --virtual build-deps gcc python3-dev musl-dev postgresql-dev
# RUN pip install psycopg2-binary
# WORKDIR /app
# COPY . .
# RUN python manage.py collectstatic --noinput
# RUN adduser -D myuser
# USER myuser
# CMD gunicorn hello_django.wsgi:application --bind 0.0.0.0:$PORT