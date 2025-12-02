## Техническое задание

## Онбординг (1–2 экрана)
Любой простой текст или иллюстрация.
Кнопка «Продолжить».

<img width="250" height="600" alt="simulator_screenshot_B9A31EE6-72AF-49AF-AAE6-35E29E7FAC8F" src="https://github.com/user-attachments/assets/af2febfe-56dc-4699-9190-0a5e41a27990" />
Онбординг (Первый экран экран)

<img width="250" height="600" alt="simulator_screenshot_A38AB024-B0E0-43CC-9867-70F786772961" src="https://github.com/user-attachments/assets/21c571d7-2265-4240-8823-2649e5904858" />
Онбординг (Второй экран)

## Экран Paywall
Придумать очень простой дизайн (можно прямо в коде).
Две подписки: Месяц / Год (год – скидка).
Кнопка «Продолжить» — должна «покупать» (эмулировать покупку, реальный биллинг не нужен).

<img width="250" height="600" alt="simulator_screenshot_4D6FEEF1-0833-44D5-A4C5-2DDF952B1182" src="https://github.com/user-attachments/assets/870e86db-9c73-4d02-8735-89479adb410f" />
Подписка не выбрана
<img width="250" height="600" alt="simulator_screenshot_1B2C16CB-D673-4A77-A7D2-8AF36C3BFE0A" src="https://github.com/user-attachments/assets/ebd66622-a910-45a0-b765-46f7e1d65d82" />
Подписка выбрана

5) Главный экран
Любой контент (список, текст, картинка).
<img width="250" height="600" alt="simulator_screenshot_871AAF57-1E4A-48BE-9AC3-206706DF5BD0" src="https://github.com/user-attachments/assets/3fe3590c-8f59-4da9-aab6-45b95516c24c" />
Главный модуль приложений

## Сохранение состояния подписки
Если пользователь «купил» подписку — при следующем запуске приложения сразу открывается главный экран.
Можно использовать любой метод хранения (SharedPreferences / UserDefaults и т.п.).

-- Для сохранения состояния подписки был использован UserDefaults. 

-- При нажатии на кнопку "Сохранить" проверяется текущее состояние выбранной подписки (если выбрана). 

-- Далее происходит сохранение данной пописки в UserDefaults

-- На основе сохраненной подписки в UserDefaults в ApplicationCoordinator вызывается соответствующий Coordinator.

## Структура проекта на основе Координаторов
Каждый координатор отвечает за навигацию одного конкретного модуля. 

Для каждого модуля предусмотрен FlowDelegate для более гибкой навигации между модулями. 
## ApplicationCoordinator  отвечает за стартовый экран приложения.
Выбор стартового экрана производится с помощью паттерна проектирования State. 
-- Состояние MainState - если подписка пользователем уже оформлена.
-- Состояние OnboardingState - если подписка еще не оформлена.

## OnboardingCoordinator 
<img width="250" height="600" alt="Снимок экрана 2025-12-02 в 18 44 11" src="https://github.com/user-attachments/assets/453e1283-f895-4af9-a6c2-d607819a8db1" />

