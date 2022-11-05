#!/bin/bash





# read project root
read -p "Your absolute project root: " PROJECT_ROOT


# expand project root
PROJECT_ROOT_EXPANDED="${PROJECT_ROOT/#\~/$HOME}" # bash parameter expansion
MY_PROJECT_ROOT=${PROJECT_ROOT_EXPANDED:-.} 
echo ${MY_PROJECT_ROOT}
mkdir ${MY_PROJECT_ROOT}
ls ${MY_PROJECT_ROOT}


# create venv and install packages
python -m venv ${MY_PROJECT_ROOT}/venv
source ${MY_PROJECT_ROOT}/venv/bin/activate
python -m pip install --upgrade pip
python -m pip install "fastapi[all]"
python -m pip install orjson
python -m pip install psycopg2-binary 
python -m pip install asyncpg
python -m pip install sqlalchemy alembic
# python -m pip install mysqlclient
python -m pip install redis
python -m pip install celery
python -m pip install flower
python -m pip install aiofiles


# create production related files
echo -e "
.idea
.ipynb_checkpoints
.mypy_cache
.vscode
__pycache__
.pytest_cache
htmlcov
dist
site
.coverage
coverage.xml
.netlify
test.db
log.txt
Pipfile.lock
env3.*
env
docs_build
venv
docs.zip
archive.zip

# vim temporary files
*~
.*.sw?
" > ${MY_PROJECT_ROOT}/.gitignore
> ${MY_PROJECT_ROOT}/.dockerignore
> ${MY_PROJECT_ROOT}/.env
> ${MY_PROJECT_ROOT}/Dockerfile
> ${MY_PROJECT_ROOT}/docker-compose.yml


# project core files
PROJECT_MODULE_PATH=${MY_PROJECT_ROOT}/src
mkdir ${PROJECT_MODULE_PATH}
> ${PROJECT_MODULE_PATH}/__init__.py
> ${PROJECT_MODULE_PATH}/config.py
> ${PROJECT_MODULE_PATH}/database.py
> ${PROJECT_MODULE_PATH}/exceptions.py
> ${PROJECT_MODULE_PATH}/celery_config.py
> ${PROJECT_MODULE_PATH}/worker.py



# create apps
mkdir ${MY_PROJECT_ROOT}/scripts
> ${MY_PROJECT_ROOT}/scripts/createapp.sh
chmod +x ${MY_PROJECT_ROOT}/scripts/createapp.sh
echo "MY_PROJECT_ROOT=${MY_PROJECT_ROOT}" >> ${MY_PROJECT_ROOT}/scripts/createapp.sh
echo "PROJECT_MODULE_PATH=${PROJECT_MODULE_PATH}" >> ${MY_PROJECT_ROOT}/scripts/createapp.sh
echo -e '
read -p "Create app: " APP_NAME
APP_NAME=${APP_NAME:-example}


mkdir ${PROJECT_MODULE_PATH}/${APP_NAME}
> ${PROJECT_MODULE_PATH}/${APP_NAME}/__init__.py
> ${PROJECT_MODULE_PATH}/${APP_NAME}/routes.py
> ${PROJECT_MODULE_PATH}/${APP_NAME}/services.py
> ${PROJECT_MODULE_PATH}/${APP_NAME}/models.py
> ${PROJECT_MODULE_PATH}/${APP_NAME}/schemas.py
> ${PROJECT_MODULE_PATH}/${APP_NAME}/tasks.py
' >> ${MY_PROJECT_ROOT}/scripts/createapp.sh



# main.py
> ${MY_PROJECT_ROOT}/scripts/createmain.sh
chmod +x ${MY_PROJECT_ROOT}/scripts/createmain.sh
echo "MY_PROJECT_ROOT=${MY_PROJECT_ROOT}" >> ${MY_PROJECT_ROOT}/scripts/createmain.sh
echo "PROJECT_MODULE_PATH=${PROJECT_MODULE_PATH}" >> ${MY_PROJECT_ROOT}/scripts/createmain.sh
echo -e '
echo -e "
1. Project Root: ${MY_PROJECT_ROOT} (default)
2. Project Module: ${PROJECT_MODULE_PATH}
"
read -p "main.py location: " MAINPY_LOCATION
case $MAINPY_LOCATION in
    1)
        if [ -f ${MY_PROJECT_ROOT}/main.py ]; then echo "main.py already exists here"; else touch ${MY_PROJECT_ROOT}/main.py; fi
        ;;
    2)
        if [ -f ${PROJECT_MODULE_PATH}/main.py ]; then echo "main.py already exists here"; else touch ${PROJECT_MODULE_PATH}/main.py; fi
        ;;
    *)
        if [ -f ${MY_PROJECT_ROOT}/main.py ]; then echo "main.py already exists here"; else touch ${MY_PROJECT_ROOT}/main.py; fi
        ;;
esac
' >> ${MY_PROJECT_ROOT}/scripts/createmain.sh







mkdir ${MY_PROJECT_ROOT}/tests









