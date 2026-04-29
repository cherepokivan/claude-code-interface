#!/bin/bash

# Claude Code Interface Launcher для Linux/macOS
# Цвета
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

clear

echo -e "${CYAN}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║         Claude Code Interface - Быстрый запуск             ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo ""
echo "Выберите интерфейс для запуска:"
echo ""
echo -e "${GREEN}[1]${NC} Базовый интерфейс (claude-interface.html)"
echo "    └─ Простой и понятный, для начинающих"
echo ""
echo -e "${GREEN}[2]${NC} Продвинутый интерфейс (claude-advanced.html)"
echo "    └─ Множество функций, управление разговорами"
echo ""
echo -e "${GREEN}[3]${NC} Темная тема (claude-dark.html)"
echo "    └─ Для работы в темное время суток"
echo ""
echo -e "${GREEN}[4]${NC} Мобильная версия (claude-mobile.html)"
echo "    └─ Оптимизирован для смартфонов"
echo ""
echo -e "${YELLOW}[5]${NC} Открыть README"
echo -e "${YELLOW}[6]${NC} Открыть инструкцию по установке"
echo -e "${YELLOW}[0]${NC} Выход"
echo ""
echo "════════════════════════════════════════════════════════════"
echo ""

read -p "Ваш выбор (0-6): " choice

case $choice in
    1)
        echo ""
        echo -e "${GREEN}✓${NC} Запуск базового интерфейса..."
        if [[ "$OSTYPE" == "darwin"* ]]; then
            open "claude-interface.html"
        else
            xdg-open "claude-interface.html" 2>/dev/null || sensible-browser "claude-interface.html"
        fi
        ;;
    2)
        echo ""
        echo -e "${GREEN}✓${NC} Запуск продвинутого интерфейса..."
        if [[ "$OSTYPE" == "darwin"* ]]; then
            open "claude-advanced.html"
        else
            xdg-open "claude-advanced.html" 2>/dev/null || sensible-browser "claude-advanced.html"
        fi
        ;;
    3)
        echo ""
        echo -e "${GREEN}✓${NC} Запуск темной темы..."
        if [[ "$OSTYPE" == "darwin"* ]]; then
            open "claude-dark.html"
        else
            xdg-open "claude-dark.html" 2>/dev/null || sensible-browser "claude-dark.html"
        fi
        ;;
    4)
        echo ""
        echo -e "${GREEN}✓${NC} Запуск мобильной версии..."
        if [[ "$OSTYPE" == "darwin"* ]]; then
            open "claude-mobile.html"
        else
            xdg-open "claude-mobile.html" 2>/dev/null || sensible-browser "claude-mobile.html"
        fi
        ;;
    5)
        echo ""
        echo -e "${GREEN}✓${NC} Открытие README..."
        if [[ "$OSTYPE" == "darwin"* ]]; then
            open "README.md"
        else
            xdg-open "README.md" 2>/dev/null || sensible-browser "README.md"
        fi
        ;;
    6)
        echo ""
        echo -e "${GREEN}✓${NC} Открытие инструкции..."
        if [[ "$OSTYPE" == "darwin"* ]]; then
            open "INSTALL.md"
        else
            xdg-open "INSTALL.md" 2>/dev/null || sensible-browser "INSTALL.md"
        fi
        ;;
    0)
        echo ""
        echo "До свидания!"
        sleep 1
        exit 0
        ;;
    *)
        echo ""
        echo -e "${YELLOW}✗${NC} Неверный выбор. Попробуйте снова."
        sleep 2
        exec "$0"
        ;;
esac

echo ""
echo "════════════════════════════════════════════════════════════"
echo ""
echo -e "${CYAN}Интерфейс открыт в браузере!${NC}"
echo ""
echo "Не забудьте настроить API ключ в настройках (⚙️)"
echo ""
sleep 3
