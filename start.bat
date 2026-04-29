@echo off
chcp 65001 >nul
title Claude Code Interface Launcher
color 0B

echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║         Claude Code Interface - Быстрый запуск             ║
echo ╚════════════════════════════════════════════════════════════╝
echo.
echo Выберите интерфейс для запуска:
echo.
echo [1] Базовый интерфейс (claude-interface.html)
echo     └─ Простой и понятный, для начинающих
echo.
echo [2] Продвинутый интерфейс (claude-advanced.html)
echo     └─ Множество функций, управление разговорами
echo.
echo [3] Темная тема (claude-dark.html)
echo     └─ Для работы в темное время суток
echo.
echo [4] Мобильная версия (claude-mobile.html)
echo     └─ Оптимизирован для смартфонов
echo.
echo [5] Открыть README
echo [6] Открыть инструкцию по установке
echo [0] Выход
echo.
echo ════════════════════════════════════════════════════════════
echo.

set /p choice="Ваш выбор (0-6): "

if "%choice%"=="1" (
    echo.
    echo ✓ Запуск базового интерфейса...
    start "" "claude-interface.html"
    goto end
)

if "%choice%"=="2" (
    echo.
    echo ✓ Запуск продвинутого интерфейса...
    start "" "claude-advanced.html"
    goto end
)

if "%choice%"=="3" (
    echo.
    echo ✓ Запуск темной темы...
    start "" "claude-dark.html"
    goto end
)

if "%choice%"=="4" (
    echo.
    echo ✓ Запуск мобильной версии...
    start "" "claude-mobile.html"
    goto end
)

if "%choice%"=="5" (
    echo.
    echo ✓ Открытие README...
    start "" "README.md"
    goto end
)

if "%choice%"=="6" (
    echo.
    echo ✓ Открытие инструкции...
    start "" "INSTALL.md"
    goto end
)

if "%choice%"=="0" (
    echo.
    echo До свидания!
    timeout /t 1 >nul
    exit
)

echo.
echo ✗ Неверный выбор. Попробуйте снова.
timeout /t 2 >nul
cls
goto :eof

:end
echo.
echo ════════════════════════════════════════════════════════════
echo.
echo Интерфейс открыт в браузере!
echo.
echo Не забудьте настроить API ключ в настройках (⚙️)
echo.
timeout /t 3 >nul
exit
