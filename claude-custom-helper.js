/**
 * Claude Custom Settings Helper
 * Загружает и применяет кастомные настройки из localStorage
 */

(function() {
    'use strict';

    // Загрузка кастомных настроек
    function loadCustomSettings() {
        const saved = localStorage.getItem('claude_custom_settings');
        if (!saved) return null;

        try {
            return JSON.parse(saved);
        } catch (e) {
            console.error('Ошибка загрузки кастомных настроек:', e);
            return null;
        }
    }

    // Получение API URL
    function getApiUrl() {
        const settings = loadCustomSettings();

        // Приоритет: локальный процесс > кастомный URL > стандартный
        if (settings && settings.useLocalProcess && settings.localProcessUrl) {
            return settings.localProcessUrl;
        }

        if (settings && settings.useCustomUrl && settings.customUrl) {
            return settings.customUrl;
        }

        // Стандартный URL Anthropic
        return 'https://api.anthropic.com/v1/messages';
    }

    // Получение API ключа
    function getApiKey() {
        const settings = loadCustomSettings();

        // Если используется локальный процесс, ключ не нужен
        if (settings && settings.useLocalProcess && settings.localProcessUrl) {
            return 'local-process'; // Фиктивный ключ для локального процесса
        }

        if (settings && settings.useCustomToken && settings.customToken) {
            return settings.customToken;
        }

        // Проверяем стандартные места хранения
        return localStorage.getItem('claude_api_key') ||
               localStorage.getItem('claude_api_key_dark') ||
               localStorage.getItem('claude_mobile_key') ||
               '';
    }

    // Получение имени модели
    function getModelName(defaultModel = 'claude-sonnet-4-6') {
        const settings = loadCustomSettings();

        if (settings && settings.useCustomModel && settings.customModel) {
            return settings.customModel;
        }

        return defaultModel;
    }

    // Проверка, отключены ли experimental betas
    function isExperimentalBetasDisabled() {
        const settings = loadCustomSettings();
        return settings && settings.disableBetas;
    }

    // Создание заголовков для запроса
    function getApiHeaders(apiKey) {
        const headers = {
            'Content-Type': 'application/json',
            'x-api-key': apiKey,
            'anthropic-version': '2023-06-01'
        };

        // Добавляем experimental betas, если не отключены
        if (!isExperimentalBetasDisabled()) {
            // Можно добавить специфичные beta-заголовки если нужно
        }

        return headers;
    }

    // Универсальная функция для отправки запроса к Claude API
    async function sendClaudeRequest(messages, options = {}) {
        const apiKey = getApiKey();
        const apiUrl = getApiUrl();
        const model = getModelName(options.model);

        if (!apiKey) {
            throw new Error('API ключ не настроен. Откройте настройки (⚙️) или claude-custom-settings.html');
        }

        const requestBody = {
            model: model,
            max_tokens: options.maxTokens || 4096,
            messages: messages,
            stream: false  // Отключаем streaming для совместимости
        };

        // Добавляем temperature если указан
        if (options.temperature !== undefined) {
            requestBody.temperature = options.temperature;
        }

        const response = await fetch(apiUrl, {
            method: 'POST',
            headers: getApiHeaders(apiKey),
            body: JSON.stringify(requestBody)
        });

        if (!response.ok) {
            const errorText = await response.text();
            let errorMessage = `API Error: ${response.status}`;
            try {
                const error = JSON.parse(errorText);
                errorMessage = error.error?.message || errorMessage;
            } catch (e) {
                errorMessage = errorText || errorMessage;
            }
            throw new Error(errorMessage);
        }

        return await response.json();
    }

    // Показать индикатор кастомных настроек
    function showCustomSettingsIndicator() {
        const settings = loadCustomSettings();
        if (!settings) return;

        const isCustom = settings.useCustomUrl || settings.useCustomToken || settings.useCustomModel || settings.useLocalProcess;
        if (!isCustom) return;

        // Определяем текст индикатора
        let indicatorText = '⚙️ Custom Settings';
        if (settings.useLocalProcess) {
            indicatorText = '🔌 Local Process';
        }

        // Создаем индикатор
        const indicator = document.createElement('div');
        indicator.style.cssText = `
            position: fixed;
            top: 10px;
            right: 10px;
            background: ${settings.useLocalProcess ? '#4ade80' : '#ffc107'};
            color: ${settings.useLocalProcess ? '#fff' : '#000'};
            padding: 8px 12px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 500;
            z-index: 9999;
            box-shadow: 0 2px 8px rgba(0,0,0,0.2);
            cursor: pointer;
        `;
        indicator.textContent = indicatorText;
        indicator.title = settings.useLocalProcess
            ? 'Подключено к локальному процессу Claude Code. Нажмите для редактирования.'
            : 'Используются кастомные настройки. Нажмите для редактирования.';
        indicator.onclick = () => {
            window.open('claude-custom-settings.html', '_blank');
        };

        document.body.appendChild(indicator);
    }

    // Экспортируем функции в глобальную область
    window.ClaudeCustomSettings = {
        loadCustomSettings,
        getApiUrl,
        getApiKey,
        getModelName,
        isExperimentalBetasDisabled,
        getApiHeaders,
        sendClaudeRequest,
        showCustomSettingsIndicator
    };

    // Показываем индикатор при загрузке страницы
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', showCustomSettingsIndicator);
    } else {
        showCustomSettingsIndicator();
    }

    console.log('Claude Custom Settings Helper загружен');
})();
