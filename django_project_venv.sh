#!/bin/bash
/c/Python310/python.exe -m venv venv
source venv/Scripts/activate
pip install django psycopg2 gunicorn
pip freeze > requirements.txt