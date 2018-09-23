@echo off
set IMAGE_NAME=

for /f %%i in ('docker images -q pa-cdev') do set IMAGE_NAME=%%i

if "%IMAGE_NAME%" == "" (
    if exist docker-compose.yml (
        docker-compose build pa-cdev
    ) else (
        echo docker-compose.yml file is missing!!
        echo [PT] O ficheiro docker-compose.yml nao foi encontrado!!
        echo.
        exit /B 1
    )
)

if exist docker-compose.yml (
    echo.
    echo.
    echo Copy this script to the folder you wish to map
    echo [PT] Copie este script para a pasta que pretende mapear
    echo.
)

echo.
echo Sudo password: admin
echo.

set CONTAINER_NAME=
for /f %%i in ('docker ps -q --filter name=pa-cdev') do set CONTAINER_NAME=%%i
if "%CONTAINER_NAME%" == "" (
    docker run -it --name pa-cdev -v "%cd%":/home/pa --rm pa-cdev
) else (
    docker exec -it pa-cdev /bin/bash
)
