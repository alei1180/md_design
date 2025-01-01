﻿#language: ru

@tree

Функционал: <описание фичи>

Как <Роль> я хочу
<описание функционала> 
чтобы <бизнес-эффект>   

Контекст:
	Дано Я открыл новый сеанс TestClient или подключил уже существующий
	И я закрываю все окна клиентского приложения
	И я открываю внешнюю обработку или отчет "D:\git\md_design\dst\MDDesign.epf" (Расширение)

Сценарий: Создавать таблицу по сокращенному описанию
	Когда в поле с именем 'Редактор' я ввожу текст 
		|'Колонка 1 | Колонка 2'                |
		|'--- | ---'|
		|'Значение 1 | Значение 2'|
	И я нажимаю на кнопку "Сформировать"

	Если в таблице "Таблица" есть колонка "Колонка 1" Тогда
	Иначе
		И я вызываю исключение с текстом сообщения "Нет колонки"

Сценарий: Создавать таблицу по сокращенному описанию
	Когда в поле с именем 'Редактор' я ввожу текст 
		|'|Колонка 1 | Колонка 2|'                |
		|'|--- | ---|'|
		|'|Значение 1 | Значение 2|'|
	И я нажимаю на кнопку "Сформировать"

	Если в таблице "Таблица" есть колонка "Колонка 1" Тогда
	Иначе
		И я вызываю исключение с текстом сообщения "Нет колонки"
// Сценарий: Форматировать вертикальные группы
// 	Когда в поле с именем 'Редактор' я ввожу текст 
// 		|'#Группа 1 #Группа 2'                |
// 		|'Элемент группы 1 + Элемент группы 2'|
// 	И я нажимаю на кнопку с именем 'Форматировать'

// 	Тогда значение поля с именем 'Редактор' содержит текст
// """
// #Группа 1          #Группа 2
// Элемент группы 1   +   Элемент группы 2
// """