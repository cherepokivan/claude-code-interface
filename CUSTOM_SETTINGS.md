# Использование кастомных настроек

## Быстрый старт

1. Откройте `claude-custom-settings.html`
2. Включите нужные опции (чекбоксы)
3. Заполните поля
4. Нажмите "Сохранить настройки"
5. Откройте любой интерфейс - настройки применятся автоматически

---

## Что можно настроить?

### 🔑 Custom API Token
Используйте свой токен вместо стандартного Anthropic API ключа.

**Пример:**
```
sk-ant-api03-xxxxxxxxxxxxx
```

**Когда использовать:**
- У вас есть токен от OmniRoute
- Используете прокси с собственной аутентификацией
- Работаете через корпоративный gateway

---

### 🌐 Custom Base URL
Измените endpoint API на свой.

**Примеры:**
```
http://localhost:20128/v1
https://api.omniroute.ai
https://your-proxy.com/api/v1
```

**Когда использовать:**
- Локальный gateway (например, OmniRoute на localhost)
- Прокси-сервер
- Корпоративный API endpoint
- Альтернативные провайдеры с Anthropic-совместимым API

---

### 🤖 Custom Model Name
Укажите специфичное имя модели для вашего gateway.

**Примеры:**
```
kr/claude-sonnet-4.5
custom-model-name
gpt-4-compatible
```

**Когда использовать:**
- Gateway требует специфичное имя модели
- Используете кастомную модель
- Провайдер использует другие названия

---

### 🧪 Disable Experimental Betas
Отключите экспериментальные функции Claude.

**Когда использовать:**
- Gateway не поддерживает beta-функции
- Нужна максимальная совместимость
- Возникают ошибки с beta-заголовками

---

## Эквивалент в .bat файле

Настройки в интерфейсе эквивалентны следующему .bat файлу:

```batch
@echo off
setlocal

REM Кастомный токен
set "ANTHROPIC_AUTH_TOKEN=sk-33cc6a3db50d1ef7-2a4327-c0bc7138"

REM Кастомный endpoint
set "ANTHROPIC_BASE_URL=http://localhost:20128/v1"

REM Кастомная модель
set "ANTHROPIC_MODEL=kr/claude-sonnet-4.5"

REM Отключить experimental betas
set "CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS=1"

echo Starting Claude Code...
claude

endlocal
```

---

## Как это работает?

1. **Сохранение:** Настройки сохраняются в `localStorage` браузера
2. **Загрузка:** При открытии интерфейса автоматически загружаются
3. **Применение:** Используются вместо стандартных значений
4. **Индикатор:** Желтый значок ⚙️ показывает, что используются кастомные настройки

---

## Примеры использования

### Пример 1: OmniRoute локально

```
✓ Использовать кастомный токен
  Token: your-omniroute-token-here

✓ Использовать кастомный endpoint
  URL: http://localhost:20128/v1

✓ Использовать кастомное имя модели
  Model: kr/claude-sonnet-4.5

✓ Отключить experimental betas
```

### Пример 2: Корпоративный прокси

```
✓ Использовать кастомный токен
  Token: company-api-key-12345

✓ Использовать кастомный endpoint
  URL: https://api.company.com/claude/v1

□ Использовать кастомное имя модели
  (используется стандартное)

□ Отключить experimental betas
```

### Пример 3: Альтернативный провайдер

```
✓ Использовать кастомный токен
  Token: provider-key-xyz

✓ Использовать кастомный endpoint
  URL: https://api.provider.com/v1/messages

✓ Использовать кастомное имя модели
  Model: claude-compatible-model

✓ Отключить experimental betas
```

---

## Проверка настроек

После сохранения:

1. Откройте любой интерфейс (claude-interface.html, claude-dark.html и т.д.)
2. Вы увидите желтый значок ⚙️ в правом верхнем углу
3. Нажмите на него, чтобы открыть настройки
4. Попробуйте отправить сообщение

---

## Отключение кастомных настроек

### Временно:
Снимите галочки с нужных опций и сохраните

### Полностью:
Нажмите кнопку "Сбросить" в claude-custom-settings.html

---

## Безопасность

⚠️ **Важно:**
- Настройки хранятся в localStorage браузера
- Токены хранятся в открытом виде
- Не используйте на общедоступных компьютерах
- Очищайте localStorage после использования на чужих устройствах

---

## Совместимость

Кастомные настройки работают во всех интерфейсах:
- ✅ claude-interface.html (базовый)
- ✅ claude-advanced.html (продвинутый)
- ✅ claude-dark.html (темная тема)
- ✅ claude-mobile.html (мобильный)

---

## Troubleshooting

### Настройки не применяются
1. Проверьте, что нажали "Сохранить настройки"
2. Обновите страницу интерфейса (F5)
3. Проверьте консоль браузера (F12) на ошибки

### Ошибка "API Error"
1. Проверьте правильность URL (должен заканчиваться на /v1 или /v1/messages)
2. Проверьте, что токен правильный
3. Убедитесь, что gateway запущен (для localhost)

### Индикатор не появляется
1. Убедитесь, что включили хотя бы одну опцию
2. Обновите страницу
3. Проверьте, что настройки сохранены

---

## Дополнительная информация

Для программной работы с настройками используйте:

```javascript
// Загрузить настройки
const settings = window.ClaudeCustomSettings.loadCustomSettings();

// Получить API URL
const url = window.ClaudeCustomSettings.getApiUrl();

// Получить API ключ
const key = window.ClaudeCustomSettings.getApiKey();

// Получить имя модели
const model = window.ClaudeCustomSettings.getModelName();

// Отправить запрос
const response = await window.ClaudeCustomSettings.sendClaudeRequest(
    messages,
    { maxTokens: 4096, temperature: 1 }
);
```

---

**Готово! Теперь вы можете использовать любые кастомные endpoints с Claude интерфейсами! 🚀**
