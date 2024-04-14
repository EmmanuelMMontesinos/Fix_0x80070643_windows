@echo off
echo Solucionador error 0x80070643 de Windows 10
echo Este script es gracias a la solucion dada por GAMING URUGUAY en su canal de Youtube

echo Realizando verificación de sistema...
reagentc /info
reagentc /disable
diskpart
list disk

:verificar_disco
set /p disco=Indique el número del disco:
if not "%disco%"=="" (
    diskpart /s %~f0 | findstr /c:" %disco% " >nul
    if %errorlevel% equ 0 (
        goto :disk_selected
    ) else (
        echo El número de disco ingresado no es válido. Intente nuevamente.
        goto :verificar_disco
    )
) else (
    echo No se ingresó ningún número de disco. Intente nuevamente.
    goto :verificar_disco
)

:disk_selected
echo Disco seleccionado: %disco%
list part

:verificar_particion
set /p part=Indique la partición Principal:
if not "%part%"=="" (
    diskpart /s %~f0 | findstr /c:" %part% " >nul
    if %errorlevel% equ 0 (
        goto :partition_selected
    ) else (
        echo El número de partición ingresado no es válido. Intente nuevamente.
        goto :verificar_particion
    )
) else (
    echo No se ingresó ningún número de partición. Intente nuevamente.
    goto :verificar_particion
)

:partition_selected
echo Partición seleccionada: %part%
shrink desired=250 minimum=250
list partition

:verificar_recuperacion
set /p recuperacion=Indique la partición de Recuperación:
if not "%recuperacion%"=="" (
    diskpart /s %~f0 | findstr /c:" %recuperacion% " >nul
    if %errorlevel% equ 0 (
        goto :recovery_partition_selected
    ) else (
        echo El número de partición de recuperación ingresado no es válido. Intente nuevamente.
        goto :verificar_recuperacion
    )
) else (
    echo No se ingresó ningún número de partición de recuperación. Intente nuevamente.
    goto :verificar_recuperacion
)

:recovery_partition_selected
echo Partición de Recuperación seleccionada: %recuperacion%
delete partition override
list part
list disk

:select_disk_type
set /p tipo=1-Mecánico 2-M.2:
if "%tipo%"=="1" (
    create partition primary id=27
) else if "%tipo%"=="2" (
    create partition primary id=de94bba4-06d1-4d40-a16a-bfd50179d6ac
    gpt attributes =0x8000000000000001
) else (
    echo Opción no disponible. Intente nuevamente.
    goto :select_disk_type
)

format quick fs=ntfs label="Windows RE tools"
list part
list vol
exit

reagentc /enable
reagentc /info

echo Equipo Reparado
pause
