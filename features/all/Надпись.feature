﻿#language: ru

@tree

Функционал: Добавление надписи

Как Аналитик я хочу
Добавлять надпись на форму
чтобы видеть макет формы

Контекст:
	Дано Запускаю обработку

Сценарий: Создавать надпись
	Когда в поле с именем '__Редактор' я ввожу текст 
"""
Надпись
"""	
	И я нажимаю на кнопку "Сформировать"

	Тогда элемент формы 'Надпись' стал равен 'Надпись'

	Тогда сверяю сформированный код с файлом "Создавать надпись"	