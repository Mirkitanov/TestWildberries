# Дешевые авиаперелеты (тестовое приложение)

Тестовое задание от Wildberries (в сотрудничестве с Нетологией)

### Задача

Нужно создать мобильное приложение “Пора в путешествие” с двумя экранами.

## *Первый экран*
Первый экран представляет из себя список актуальных дешевых авиаперелетов.

Каждая ячейка списка должна содержать:

* Город отправления.
* Город прибытия.
* Дата отправления.
* Дата возвращения.
* Цена в рублях.

Иконка “Лайк” (имеет два состояния и означает лайкнул ли пользователь данный авиаперелет).

## *Второй экран*
Второй экран - это детализация перелета с кнопкой “Лайк”.
Второй экран открывается при выборе одной из ячеек первого экрана. Должна быть возможность вернуться к первому экрану назад.

Второй экран содержит данные по выбранному перелету (город отправления, город прибытия, дата отправления, дата возвращения, цена в рублях) и кнопку “Лайк”.

Кнопка лайк имеет два состояния:

* Перелет нравится.
* Перелет не нравится.


### Примечания

Дизайн произвольный, на усмотрение разработчика.
Список авиаперелетов запрашивается один раз при старте приложения.
Пока происходит загрузка списка должен быть отображен индикатор загрузки.
Если пользователь лайкнул перелет и вернулся в список перелетов, то в списке у “лайкнутого” перелета должна “гореть” иконка “Лайк”.
Если пользователь “лайкнул” перелет, вышел на первый экран и еще раз зашел на второй экран, то кнопка “Лайк” должна быть в состоянии “Перелет нравится” и наоборот.
Апи для списка авиаперелетов: ![https://travel.wildberries.ru/statistics/v1/cheap.](https://travel.wildberries.ru/statistics/v1/cheap)

________________________________________________________________________

## Моё техническое описание (основные моменты)

* Загрузка данных Апи происходит при загрузке приложения в AppDelegate. С помощью инструмента работы с сетевыми данными URLSession.shared.dataTask,  JSONDecoder().decode и соответсвующей Модели данных типа Codable.

* Для Навигации используются Координаторы в связке с TabBarController-ом.

* Основной рабочий экран (по заданию Первый) выпонен главным при помощи CollectionView (с его Delegate и DataSource) и CollectionViewCell (для отображения содержимого ячеек и вывода всех необходимых данных по элементно). Также здесь используется такой элемент как Header (верхняя часть – заголовок) типа UICollectionReusableView. Посколько данные в таблице (коллекции) разбиты дополнительно на секции, то каждая секция может иметь свой собственный Хэдэр (хотя в данном примере только одна секция, но при необходимости их можно сделать и больше); в него могут быть помещены не только тколько текстовые заголовки, но и другие элементы из ассортимента UI (элементов пользовательского интерфейса).

* Преобразование и вывод в нужном виде Даты и Времени осуществляется с помощью DateFormatter() и ISO8601DateFormatter(), с учетом их необходимых настроек.

* Также в приложение добавлен экран Информации (для последующей доработки), который в будущем може быть для отображения Дополнительной информации и Настроек. Внури себя данный экран содержит возможность вызова Алерт-сообщений.

* Расположение эленментов на экранах управляется с помощью нативных инструментов – констреинтов. При необходимости могут быть использованы и сторонние библиотеки, такие как SnapKit и другие. 

* Приложение не использует Storyboard, весь UI (пользовательский интерфейс) написан в коде, для удобства рефакторинга и ревью.









