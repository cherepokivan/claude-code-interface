# 🔧 Исправление проблемы "Failed to fetch"

## Что было исправлено

### Проблема
При использовании кастомных настроек (OmniRoute, прокси) все интерфейсы показывали ошибку **"Failed to fetch"**, потому что не использовали настройки из `claude-custom-settings.html`.

### Решение
Все интерфейсы теперь подключают `claude-custom-helper.js`, который автоматически:
- ✅ Загружает кастомный API URL
- ✅ Загружает кастомный токен
- ✅ Использует кастомную модель (например, `kr/claude-sonnet-4.5`)
- ✅ Применяет настройки experimental betas

---

## Как использовать

### Шаг 1: Настройте параметры

1. Откройте **claude-custom-settings.html**
2. Включите нужные опции (поставьте галочки):
   - ✓ Использовать кастомный токен
   - ✓ Использовать кастомный endpoint
   - ✓ Использовать кастомное имя модели
   - ✓ Отключить experimental betas (если нужно)

3. Заполните поля:
   ```
   Token: ваш-токен-omniroute
   URL:   http://localhost:20128/v1
   Model: kr/claude-sonnet-4.5
   ```

4. Нажмите **"Сохранить настройки"**

### Шаг 2: Используйте любой интерфейс

1. Откройте любой интерфейс:
   - `claude-interface.html`
   - `claude-advanced.html`
   - `claude-dark.html`
   - `claude-mobile.html`

2. Вы увидите желтый значок **⚙️** в правом верхнем углу (это значит, что кастомные настройки активны)

3. Отправьте сообщение - теперь будет использоваться ваш кастомный endpoint и модель!

---

## Проверка настроек

### Откройте консоль браузера (F12)

При загрузке страницы вы должны увидеть:
```
Claude Custom Settings Helper загружен
```

При отправке сообщения проверьте:
- URL запроса должен быть ваш кастомный (например, `http://localhost:20128/v1`)
- В теле запроса должна быть ваша модель (например, `kr/claude-sonnet-4.5`)

---

## Что изменилось в файлах

### Обновленные файлы:
1. **claude-interface.html** - добавлен `<script src="claude-custom-helper.js"></script>`
2. **claude-advanced.html** - добавлен `<script src="claude-custom-helper.js"></script>`
3. **claude-dark.html** - добавлен `<script src="claude-custom-helper.js"></script>`
4. **claude-mobile.html** - добавлен `<script src="claude-custom-helper.js"></script>`

### Как это работает:

**Раньше:**
```javascript
// Использовался только стандартный API
const response = await fetch('https://api.anthropic.com/v1/messages', {
    headers: { 'x-api-key': apiKey },
    body: JSON.stringify({
        model: 'claude-sonnet-4-6',  // Всегда стандартная модель
        ...
    })
});
```

**Теперь:**
```javascript
// Используются кастомные настройки
const data = await window.ClaudeCustomSettings.sendClaudeRequest(
    conversationHistory,
    { maxTokens: 4096 }
);
// Автоматически использует:
// - Кастомный URL (если настроен)
// - Кастомный токен (если настроен)
// - Кастомную модель (если настроена)
```

---

## Визуальный индикатор

Когда кастомные настройки активны, вы увидите:

```
┌─────────────────────────────────────┐
│  🤖 Claude Code        ⚙️ Custom    │  ← Желтый индикатор
│                         Settings    │
└─────────────────────────────────────┘
```

Клик по индикатору откроет `claude-custom-settings.html` для редактирования.

---

## Troubleshooting

### Проблема: Индикатор не появляется
**Решение:** Убедитесь, что включили хотя бы одну опцию в настройках и сохранили.

### Проблема: Все еще "Failed to fetch"
**Решение:**
1. Проверьте, что OmniRoute запущен (для localhost)
2. Проверьте URL - должен заканчиваться на `/v1` или `/v1/messages`
3. Проверьте токен
4. Откройте консоль (F12) и посмотрите детали ошибки

### Проблема: Используется не та модель
**Решение:**
1. Откройте `claude-custom-settings.html`
2. Убедитесь, что галочка "Использовать кастомное имя модели" включена
3. Проверьте правильность имени модели
4. Сохраните настройки
5. Обновите страницу интерфейса (F5)

### Проблема: Настройки не применяются
**Решение:**
1. Очистите кэш браузера (Ctrl+Shift+Del)
2. Обновите страницу (F5)
3. Проверьте консоль на ошибки
4. Убедитесь, что файл `claude-custom-helper.js` находится в той же папке

---

## Пример для OmniRoute

### Настройки:
```
✓ Использовать кастомный токен
  Token: ваш-токен-здесь

✓ Использовать кастомный endpoint
  URL: http://localhost:20128/v1

✓ Использовать кастомное имя модели
  Model: kr/claude-sonnet-4.5

✓ Отключить experimental betas
```

### Результат:
Все интерфейсы будут отправлять запросы на `http://localhost:20128/v1` с моделью `kr/claude-sonnet-4.5` и вашим токеном.

---

## Дополнительная информация

### Где хранятся настройки?
В `localStorage` браузера под ключом `claude_custom_settings`.

### Как сбросить настройки?
1. Откройте `claude-custom-settings.html`
2. Нажмите кнопку "Сбросить"

Или через консоль:
```javascript
localStorage.removeItem('claude_custom_settings');
```

### Как проверить текущие настройки?
Откройте консоль (F12) и выполните:
```javascript
console.log(window.ClaudeCustomSettings.loadCustomSettings());
console.log('API URL:', window.ClaudeCustomSettings.getApiUrl());
console.log('API Key:', window.ClaudeCustomSettings.getApiKey());
console.log('Model:', window.ClaudeCustomSettings.getModelName());
```

---

## ✅ Готово!

Теперь все интерфейсы корректно работают с кастомными настройками!

**Дата исправления:** 2026-04-29 19:19  
**Версия:** 1.1.1
