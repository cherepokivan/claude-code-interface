# Примеры использования Claude Code Interface

## 📚 Содержание
- [Базовые примеры](#базовые-примеры)
- [Программирование](#программирование)
- [Отладка кода](#отладка-кода)
- [Обучение](#обучение)
- [Анализ и рефакторинг](#анализ-и-рефакторинг)
- [Работа с данными](#работа-с-данными)

---

## 🎯 Базовые примеры

### Пример 1: Простой вопрос
```
Вы: Что такое рекурсия?

Claude: Рекурсия — это техника программирования, при которой функция 
вызывает саму себя для решения задачи...
```

### Пример 2: Объяснение концепции
```
Вы: Объясни разницу между let, const и var в JavaScript

Claude: Вот основные различия:

**var:**
- Функциональная область видимости
- Поднимается (hoisting)
- Можно переопределить

**let:**
- Блочная область видимости
- Не поднимается
- Можно изменить, но не переопределить

**const:**
- Блочная область видимости
- Нельзя изменить или переопределить
- Для константных значений
```

---

## 💻 Программирование

### Пример 3: Создание функции
```
Вы: Напиши функцию на Python для проверки, является ли число простым

Claude: Вот функция для проверки простых чисел:

```python
def is_prime(n):
    """
    Проверяет, является ли число простым
    
    Args:
        n: Целое число для проверки
        
    Returns:
        bool: True если число простое, False иначе
    """
    if n < 2:
        return False
    
    if n == 2:
        return True
    
    if n % 2 == 0:
        return False
    
    # Проверяем делители до sqrt(n)
    for i in range(3, int(n**0.5) + 1, 2):
        if n % i == 0:
            return False
    
    return True

# Примеры использования
print(is_prime(17))  # True
print(is_prime(20))  # False
```
```

### Пример 4: Веб-сервер
```
Вы: Создай простой HTTP сервер на Node.js с маршрутами

Claude: Вот простой сервер с Express:

```javascript
const express = require('express');
const app = express();
const PORT = 3000;

// Middleware для парсинга JSON
app.use(express.json());

// Главная страница
app.get('/', (req, res) => {
    res.json({ message: 'Добро пожаловать!' });
});

// Получить пользователя
app.get('/api/users/:id', (req, res) => {
    const { id } = req.params;
    res.json({ id, name: 'Пользователь ' + id });
});

// Создать пользователя
app.post('/api/users', (req, res) => {
    const { name, email } = req.body;
    res.status(201).json({ 
        id: Date.now(), 
        name, 
        email 
    });
});

app.listen(PORT, () => {
    console.log(`Сервер запущен на http://localhost:${PORT}`);
});
```

Установка зависимостей:
```bash
npm init -y
npm install express
node server.js
```
```

### Пример 5: React компонент
```
Вы: Создай React компонент для списка задач с возможностью добавления и удаления

Claude: Вот компонент TodoList:

```jsx
import React, { useState } from 'react';

function TodoList() {
    const [todos, setTodos] = useState([]);
    const [input, setInput] = useState('');

    const addTodo = () => {
        if (input.trim()) {
            setTodos([...todos, {
                id: Date.now(),
                text: input,
                completed: false
            }]);
            setInput('');
        }
    };

    const deleteTodo = (id) => {
        setTodos(todos.filter(todo => todo.id !== id));
    };

    const toggleTodo = (id) => {
        setTodos(todos.map(todo =>
            todo.id === id 
                ? { ...todo, completed: !todo.completed }
                : todo
        ));
    };

    return (
        <div className="todo-list">
            <h1>Мои задачи</h1>
            
            <div className="input-group">
                <input
                    type="text"
                    value={input}
                    onChange={(e) => setInput(e.target.value)}
                    onKeyPress={(e) => e.key === 'Enter' && addTodo()}
                    placeholder="Добавить задачу..."
                />
                <button onClick={addTodo}>Добавить</button>
            </div>

            <ul>
                {todos.map(todo => (
                    <li key={todo.id}>
                        <input
                            type="checkbox"
                            checked={todo.completed}
                            onChange={() => toggleTodo(todo.id)}
                        />
                        <span style={{
                            textDecoration: todo.completed ? 'line-through' : 'none'
                        }}>
                            {todo.text}
                        </span>
                        <button onClick={() => deleteTodo(todo.id)}>
                            Удалить
                        </button>
                    </li>
                ))}
            </ul>
        </div>
    );
}

export default TodoList;
```
```

---

## 🐛 Отладка кода

### Пример 6: Поиск ошибки
```
Вы: Почему этот код не работает?

```python
def calculate_average(numbers):
    total = 0
    for num in numbers:
        total += num
    return total / len(numbers)

result = calculate_average([])
print(result)
```

Claude: Проблема в том, что при пустом списке происходит деление на ноль.
Вот исправленная версия:

```python
def calculate_average(numbers):
    if not numbers:  # Проверка на пустой список
        return 0
    
    total = 0
    for num in numbers:
        total += num
    return total / len(numbers)

# Или более компактно:
def calculate_average(numbers):
    return sum(numbers) / len(numbers) if numbers else 0

result = calculate_average([])
print(result)  # 0
```
```

### Пример 7: Оптимизация кода
```
Вы: Как оптимизировать этот код?

```javascript
function findDuplicates(arr) {
    const duplicates = [];
    for (let i = 0; i < arr.length; i++) {
        for (let j = i + 1; j < arr.length; j++) {
            if (arr[i] === arr[j] && !duplicates.includes(arr[i])) {
                duplicates.push(arr[i]);
            }
        }
    }
    return duplicates;
}
```

Claude: Текущая сложность O(n³). Вот оптимизированная версия O(n):

```javascript
function findDuplicates(arr) {
    const seen = new Set();
    const duplicates = new Set();
    
    for (const item of arr) {
        if (seen.has(item)) {
            duplicates.add(item);
        } else {
            seen.add(item);
        }
    }
    
    return Array.from(duplicates);
}

// Пример использования
console.log(findDuplicates([1, 2, 3, 2, 4, 3])); // [2, 3]
```

Улучшения:
- Сложность снижена с O(n³) до O(n)
- Используется Set для быстрого поиска
- Код стал более читаемым
```
```

---

## 📖 Обучение

### Пример 8: Объяснение алгоритма
```
Вы: Объясни алгоритм быстрой сортировки с примером

Claude: Быстрая сортировка (QuickSort) работает по принципу "разделяй и властвуй":

**Алгоритм:**
1. Выбираем опорный элемент (pivot)
2. Разделяем массив на две части:
   - Элементы меньше pivot
   - Элементы больше pivot
3. Рекурсивно сортируем обе части

**Реализация:**

```python
def quicksort(arr):
    # Базовый случай
    if len(arr) <= 1:
        return arr
    
    # Выбираем pivot (средний элемент)
    pivot = arr[len(arr) // 2]
    
    # Разделяем на три части
    left = [x for x in arr if x < pivot]
    middle = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    
    # Рекурсивно сортируем и объединяем
    return quicksort(left) + middle + quicksort(right)

# Пример
arr = [3, 6, 8, 10, 1, 2, 1]
print(quicksort(arr))  # [1, 1, 2, 3, 6, 8, 10]
```

**Сложность:**
- Лучший случай: O(n log n)
- Средний случай: O(n log n)
- Худший случай: O(n²)
```
```

### Пример 9: Паттерны проектирования
```
Вы: Покажи пример паттерна Singleton на JavaScript

Claude: Вот несколько способов реализации Singleton:

**1. Классический подход:**

```javascript
class Singleton {
    constructor() {
        if (Singleton.instance) {
            return Singleton.instance;
        }
        
        this.data = [];
        Singleton.instance = this;
    }
    
    addData(item) {
        this.data.push(item);
    }
    
    getData() {
        return this.data;
    }
}

// Использование
const instance1 = new Singleton();
const instance2 = new Singleton();

instance1.addData('test');
console.log(instance2.getData()); // ['test']
console.log(instance1 === instance2); // true
```

**2. Модульный подход (ES6):**

```javascript
// singleton.js
class DatabaseConnection {
    constructor() {
        this.connected = false;
    }
    
    connect() {
        this.connected = true;
        console.log('Connected to database');
    }
    
    disconnect() {
        this.connected = false;
        console.log('Disconnected');
    }
}

export default new DatabaseConnection();
```

**3. Функциональный подход:**

```javascript
const Singleton = (function() {
    let instance;
    
    function createInstance() {
        return {
            data: [],
            addData(item) {
                this.data.push(item);
            },
            getData() {
                return this.data;
            }
        };
    }
    
    return {
        getInstance() {
            if (!instance) {
                instance = createInstance();
            }
            return instance;
        }
    };
})();

// Использование
const obj1 = Singleton.getInstance();
const obj2 = Singleton.getInstance();
console.log(obj1 === obj2); // true
```
```
```

---

## 🔄 Анализ и рефакторинг

### Пример 10: Рефакторинг кода
```
Вы: Улучши этот код:

```javascript
function processUser(user) {
    if (user) {
        if (user.age) {
            if (user.age >= 18) {
                if (user.email) {
                    if (user.email.includes('@')) {
                        return true;
                    }
                }
            }
        }
    }
    return false;
}
```

Claude: Вот улучшенная версия с ранним возвратом и валидацией:

```javascript
function isValidAdultUser(user) {
    // Ранний возврат для невалидных случаев
    if (!user) return false;
    if (!user.age || user.age < 18) return false;
    if (!user.email || !user.email.includes('@')) return false;
    
    return true;
}

// Или еще более читаемо:
function isValidAdultUser(user) {
    const hasValidAge = user?.age >= 18;
    const hasValidEmail = user?.email?.includes('@');
    
    return hasValidAge && hasValidEmail;
}

// С подробной валидацией:
function validateUser(user) {
    const errors = [];
    
    if (!user) {
        return { valid: false, errors: ['User is required'] };
    }
    
    if (!user.age || user.age < 18) {
        errors.push('User must be 18 or older');
    }
    
    if (!user.email) {
        errors.push('Email is required');
    } else if (!user.email.includes('@')) {
        errors.push('Invalid email format');
    }
    
    return {
        valid: errors.length === 0,
        errors
    };
}
```

Улучшения:
- Убрана вложенность (pyramid of doom)
- Добавлены понятные имена
- Использован optional chaining (?.)
- Добавлена детальная валидация
```
```

---

## 📊 Работа с данными

### Пример 11: Обработка JSON
```
Вы: Как обработать и отфильтровать данные из API?

Claude: Вот пример работы с данными:

```javascript
// Получение данных
async function fetchUsers() {
    try {
        const response = await fetch('https://api.example.com/users');
        const users = await response.json();
        
        // Фильтрация активных пользователей старше 18
        const activeAdults = users
            .filter(user => user.active)
            .filter(user => user.age >= 18)
            .map(user => ({
                id: user.id,
                name: user.name,
                email: user.email
            }));
        
        return activeAdults;
    } catch (error) {
        console.error('Ошибка загрузки:', error);
        return [];
    }
}

// Группировка по возрасту
function groupByAge(users) {
    return users.reduce((groups, user) => {
        const ageGroup = Math.floor(user.age / 10) * 10;
        if (!groups[ageGroup]) {
            groups[ageGroup] = [];
        }
        groups[ageGroup].push(user);
        return groups;
    }, {});
}

// Использование
fetchUsers().then(users => {
    const grouped = groupByAge(users);
    console.log(grouped);
    // { 20: [...], 30: [...], 40: [...] }
});
```
```
```

---

## 💡 Советы по использованию

1. **Будьте конкретны**: Чем точнее вопрос, тем лучше ответ
2. **Предоставляйте контекст**: Укажите язык программирования и версию
3. **Показывайте код**: При отладке всегда показывайте проблемный код
4. **Задавайте уточняющие вопросы**: Не стесняйтесь переспрашивать
5. **Используйте форматирование**: Код в блоках ``` читается лучше

---

**Готово! Используйте эти примеры как отправную точку для работы с Claude! 🚀**
