﻿#language: ru

@tree

Функционал: Добавление таблицы и дерева

Как Аналитик я хочу
Добавлять таблицу
чтобы видеть макет формы

Контекст:
	Дано Запускаю обработку

// Сценарий: Создавать таблицу по сокращенному описанию
// 	Когда в поле с именем '__Редактор' я ввожу текст 
// """	
// Колонка 1 | Колонка 2
// --- | ---
// Значение 1 | Значение 2
// """	
// 	И я нажимаю на кнопку "Сформировать"

// 	Если в таблице "Таблица" есть колонка "Колонка 1" Тогда
// 	Иначе
// 		И я вызываю исключение с текстом сообщения "Нет колонки"
	
// 	Тогда сверяю сформированный код с файлом "Создавать таблицу"

// Сценарий: Создавать таблицу по полному описанию
// 	Когда в поле с именем '__Редактор' я ввожу текст 
// """	
// |Колонка 1 | Колонка 2|
// |--- | --- |
// |Значение 1 | Значение 2|
// """		
// 	И я нажимаю на кнопку "Сформировать"

// 	Если в таблице "Таблица" есть колонка "Колонка 1" Тогда
// 	Иначе
// 		И я вызываю исключение с текстом сообщения "Нет колонки"

// Сценарий: Создавать таблицу с одной колонкой #54
// 	Когда в поле с именем '__Редактор' я ввожу текст 
// """	
// | Список     |
// | ---------- |
// | Значение 1 |
// | Значение 2 |
// """		
// 	И я нажимаю на кнопку "Сформировать"

// 	Если в таблице "Таблица" есть колонка "Список" Тогда
// 	Иначе
// 		И я вызываю исключение с текстом сообщения "Нет колонки"

//  	Тогда сверяю сформированный код с файлом "Создавать таблицу с одной колонкой"

// Сценарий: Форматировать таблицу
// 	Когда в поле с именем '__Редактор' я ввожу текст 
// """	
// |Колонка 1|Колонка 2|
// |---|---|
// |Значение 1|Значение 2|
// """		
// 	И я нажимаю на кнопку с именем '__Форматировать'

// 	Тогда значение поля с именем '__Редактор' содержит текст
// """
//  | Колонка 1  | Колонка 2  |
//  | ---------- | ---------- |
//  | Значение 1 | Значение 2 |
// """

// Сценарий: Создавать таблицу многоуровневыми строками
// 	Когда в поле с именем '__Редактор' я ввожу текст 
// """	
// | Колонка 1                      || Колонка 2  |
// | Подколонка 1.1 | Подколонка 1.2 |            |
// | -------------- | -------------- | ---------- |
// | Значение 1                     || Значение 3 |
// | Значение 1.1   | Значение 1.2   |            |
// | Значение 2                     || Значение 4 |
// | Значение 2.1   | Значение 2.2   |            |
// """		
// 	И я нажимаю на кнопку "Сформировать"	
// 	Тогда таблица 'Таблица' стала равной:
// 	| "Колонка 1"  | "Подколонка 1.2" | "Подколонка 1.1" | "Колонка 2"  |
// 	| "Значение 1" | "Значение 1.2"   | "Значение 1.1"   | "Значение 3" |
// 	| "Значение 2" | "Значение 2.2"   | "Значение 2.1"   | "Значение 4" |

// 	Тогда сверяю сформированный код с файлом "Создавать таблицу многоуровневыми строками"
	
// Сценарий: Форматировать таблицу с многоуровневыми строками
// 	Когда в поле с именем '__Редактор' я ввожу текст 
// """	
// Колонка1||Колонка2
// Подколонка1.1|Подколонка1.2|
// ---|---
// Значение1||Значение3
// Значение1.1|Значение1.2|
// Значение2||Значение4
// Значение2.1|Значение2.2|
// """		
// 	И я нажимаю на кнопку с именем '__Форматировать'
// 	Тогда значение поля с именем '__Редактор' содержит текст
// """

// | Колонка1                     || Колонка2  |
// | Подколонка1.1 | Подколонка1.2 |           |
// | ------------- | ------------- | --------- |
// | Значение1                    || Значение3 |
// | Значение1.1   | Значение1.2   |           |
// | Значение2                    || Значение4 |
// | Значение2.1   | Значение2.2   |           |
// """
	
Сценарий: Создавать таблицу с группой колонок
	Когда в поле с именем '__Редактор' я ввожу текст 
"""	
| -Группа 1-                      ||
| Подколонка 1.1 | Подколонка 1.2  |
| -------------- | --------------  |
| Значение 1.1   | Значение 1.2    |
| Значение 2.1   | Значение 2.2    |
"""		
	И я нажимаю на кнопку "Сформировать"	
	Тогда таблица 'Таблица' стала равной:
	| "Подколонка 1.1" | "Подколонка 1.2" |
	| "Значение 1.1"   | "Значение 1.2"   |
	| "Значение 2.1"   | "Значение 2.2"   |
	
	Тогда сверяю сформированный код с файлом "Создавать таблицу с группой колонок"
	
Сценарий: Форматировать таблицу с группой колонок
	Когда в поле с именем '__Редактор' я ввожу текст 
"""	
|-Группа 1-||
|Подколонка 1.1|Подколонка 1.2|
|---|---|
|Значение 1.1|Значение 1.2|
|Значение 2.1|Значение 2.2|
"""		
	И я нажимаю на кнопку с именем '__Форматировать'
	Тогда значение поля с именем '__Редактор' содержит текст
"""

| -Группа 1-                     ||
| Подколонка 1.1 | Подколонка 1.2 |
| -------------- | -------------- |
| Значение 1.1   | Значение 1.2   |
| Значение 2.1   | Значение 2.2   |
"""
	
Сценарий: Создавать две таблицы #23
	Когда в поле с именем '__Редактор' я ввожу текст 
"""	
| Колонка 1  | Колонка 2  |
| ---------- | ---------- |
| Значение 1 | Значение 2 |

| Колонка 3  | Колонка 4  |
| ---------- | ---------- |
| Значение 3 | Значение 4 |
"""		
	И я нажимаю на кнопку "Сформировать"	
	
	Тогда таблица 'Таблица' стала равной:
		| "Колонка 1"  | "Колонка 2"  |
		| "Значение 1" | "Значение 2" |
	
	И таблица 'Таблица1' стала равной:
		| "Колонка 3"  | "Колонка 4"  |
		| "Значение 3" | "Значение 4" |

	
// Сценарий: Редактировать таблицу #12
//  	Когда в поле с именем '__Редактор' я ввожу текст " "
	 
// 	Когда я нажимаю на кнопку с именем '__РедакторТаблицы'
	
// 	И открылось окно "Редактирование колонок таблицы"
// 	И в таблице 'ТаблицаКолонки' я нажимаю на кнопку "Добавить колонку"
// 	И в таблице 'ТаблицаКолонки' в поле "Заголовок" я ввожу текст "Колонка 1"
// 	И в таблице 'ТаблицаКолонки' я завершаю редактирование строки
// 	И в таблице 'ТаблицаКолонки' я нажимаю на кнопку "Добавить колонку"
// 	И в таблице 'ТаблицаКолонки' в поле "Заголовок" я ввожу текст "Колонка 2"
// 	И в таблице 'ТаблицаКолонки' я завершаю редактирование строки
// 	И я нажимаю на кнопку с именем 'ОК'

// 	Тогда значение поля с именем '__Редактор' содержит текст
// """
// | Колонка 1 | Колонка 2 |
// | --------- | --------- |
// """
	
// Сценарий: Для ячеек пустой таблицы тип колонок должнен быть строкой
// 	Когда в поле с именем '__Редактор' я ввожу текст 
// """	
// | Колонка 1 |
// | --------- |
// """		
// 	И я нажимаю на кнопку "Сформировать"

// 	И я выбираю пункт контекстного меню с именем 'ТаблицаКонтекстноеМенюДобавить' на элементе формы с именем 'Таблица'
// 	И в таблице 'Таблица' в поле с именем 'ТаблицаКолонка1' я ввожу текст "123"
// 	И в таблице 'Таблица' я завершаю редактирование строки

// Сценарий: Создавать таблицу с колонкой без заголовка
// 	Когда в поле с именем '__Редактор' я ввожу текст 
// """	
// |           |
// | --------- |
// """		
	
// 	Тогда сверяю сформированный код с файлом "Создавать таблицу с колонкой без заголовка"

Сценарий: Создавать таблицу со снятым флажком
	*Когда ввожу текст в редакторе
		Когда в поле с именем '__Редактор' я ввожу текст 
		"""	
		|Колонка 1|
		| ---|
		|[]Значение 1|
		"""	
	*Когда форматирую текст
		Когда я нажимаю на кнопку с именем '__Форматировать'
		Тогда значение поля с именем '__Редактор' содержит текст
		"""	
		| Колонка 1      |
		| -------------- |
		| [ ] Значение 1 |
		"""	
	*Когда генерирую код
		Тогда сверяю сформированный код с файлом "Создавать таблицу с флажком"


Сценарий: Создавать таблицу с установленным флажком
	*Когда ввожу текст в редакторе
		Когда в поле с именем '__Редактор' я ввожу текст 
		"""	
		|Колонка 1|
		| ---|
		|[х]Значение 1|
		"""	
	*Когда форматирую текст
		Когда я нажимаю на кнопку с именем '__Форматировать'
		Тогда значение поля с именем '__Редактор' содержит текст
		"""	
		| Колонка 1      |
		| -------------- |
		| [X] Значение 1 |
		"""			


// Сценарий: Создавать таблицу с двумя пустыми колнками
// 	*Когда ввожу текст в редакторе
// 		Когда в поле с именем '__Редактор' я ввожу текст 
// 		"""	
// 		|     |     |
// 		| --- | --- |
// 		"""	

// 	*Когда генерирую код
// 		Тогда сверяю сформированный код с файлом "Создавать таблицу с двумя пустыми колнками"
