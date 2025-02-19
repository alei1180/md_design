﻿#language: ru

@tree

Функционал: Добавление групп

Как Аналитик я хочу
Добавлять группы на форму
чтобы видеть макет формы

Контекст:
	Дано Я открыл новый сеанс TestClient или подключил уже существующий
	И я закрываю все окна клиентского приложения
	И я открываю внешнюю обработку или отчет "$КаталогПроекта$\dst\MDDesign.epf" (Расширение)

Сценарий: Просматривать группы
	* Дано в редакторе введено описание групп
		И в поле с именем '__Редактор' я ввожу текст 
			|'#Заголовок группы 1   #Заголовок группы 2'|
			|'Элемент группы 1      +   Элемент группы 2'|
	* Когда я перехожу в режим редактирования групп
		И я нажимаю на кнопку с именем '__РедакторГрупп'
	* Когда я выбираю в списке групп
		И в таблице '__ТаблицаГруппы' я перехожу к строке:
			| "Заголовок"          |
			| "Заголовок группы 2" |
	* Тогда поле редактора обновляется
		Тогда элемент формы с именем '__Редактор' стал равен
		"""
			Элемент группы 2
		"""

Сценарий: Редактировать группы
	* Дано в редакторе введено описание групп
		И в поле с именем '__Редактор' я ввожу текст 
			|'#Заголовок группы 1   #Заголовок группы 2'|
			|'Элемент группы 1      +   Элемент группы 2'|
	* Когда я перехожу в режим редактирования групп
		И я нажимаю на кнопку с именем '__РедакторГрупп'
	* Когда меняю содержимое группы
		И в поле с именем '__Редактор' я ввожу текст 
			|'Элемент группы 3'|	
	* Когда формирую форму
		И я нажимаю на кнопку "Сформировать"

	* Тогда отображается обновленная группа
		Тогда в группе "Заголовок группы 1" содержатся элементы
			| 'Элемент группы 3' |
	* Тогда другая группа выводится в прежнем виде
		Тогда в группе "Заголовок группы 2" содержатся элементы
			| 'Элемент группы 2' |

Сценарий: Добавлять группы
	* Дано в редакторе введено описание групп
		И в поле с именем '__Редактор' я ввожу текст 
			|'#Заголовок группы 1   #Заголовок группы 2'|
			|'Элемент группы 1      +   Элемент группы 2'|
	* Когда я перехожу в режим редактирования групп
		И я нажимаю на кнопку с именем '__РедакторГрупп'
	* Когда я добавляю новую группу
		И в таблице '__ТаблицаГруппы' я нажимаю на кнопку 'Добавить'
	* Когда меняю содержимое группы
		И в поле с именем '__Редактор' я ввожу текст 
			|'Элемент группы 3'|	
	* Когда формирую форму
		И я нажимаю на кнопку "В форму"
	* Тогда поле редактора обновляется
		Тогда элемент формы с именем '__Редактор' стал равен
 		"""
#Заголовок группы 1 #Заголовок группы 2 #
Элемент группы 1    + Элемент группы 2  + Элемент группы 3
		
 		"""

Сценарий: Перемещать группы
	* Дано в редакторе введено описание групп
		И в поле с именем '__Редактор' я ввожу текст 
			|'#Заголовок группы 1   #Заголовок группы 2'|
			|'Элемент группы 1      +   Элемент группы 2'|
	* Когда я перехожу в режим редактирования групп
		И я нажимаю на кнопку с именем '__РедакторГрупп'
	* Когда я перемещнаю первую группу
		И в таблице '__ТаблицаГруппы' я нажимаю на кнопку 'Переместить вниз'
	* Когда формирую форму
		И я нажимаю на кнопку "В форму"
	* Тогда поле редактора обновляется
		Тогда элемент формы с именем '__Редактор' стал равен
 		"""
#Заголовок группы 2 #Заголовок группы 1
Элемент группы 2    + Элемент группы 1	
	
		"""

Сценарий: Удалять группы    
	* Дано в редакторе введено описание групп
		И в поле с именем '__Редактор' я ввожу текст 
			|'#Заголовок группы 1   #Заголовок группы 2'|
			|'Элемент группы 1      +   Элемент группы 2'|
	* Когда я перехожу в режим редактирования групп
		И я нажимаю на кнопку с именем '__РедакторГрупп'
	* Когда я удаляю первую группу
		И я выбираю пункт контекстного меню с именем '__ТаблицаГруппыКонтекстноеМенюУдалить' на элементе формы с именем '__ТаблицаГруппы'
	* Когда формирую форму
		И я нажимаю на кнопку "В форму"
	* Тогда поле редактора обновляется
		Тогда элемент формы с именем '__Редактор' стал равен
 		"""
#Заголовок группы 2
Элемент группы 2
		
		"""

Сценарий: Создавать группы
	* Дано в редакторе введено описание групп
		И в поле с именем '__Редактор' я ввожу текст " "
	* Когда я перехожу в режим редактирования групп
		И я нажимаю на кнопку с именем '__РедакторГрупп'
	* Когда меняю содержимое группы
		И в поле с именем '__Редактор' я ввожу текст 
			|'Элемент группы 1'|	
	* Когда формирую форму
		И я нажимаю на кнопку "В форму"
	* Тогда поле редактора обновляется
		Тогда элемент формы с именем '__Редактор' стал равен
 		"""
#
Элемент группы 1
		
 		"""