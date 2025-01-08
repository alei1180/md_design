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

Сценарий: Создавать вертикальные группы
	Когда в поле с именем '__Редактор' я ввожу текст 
"""
#Группа 1 #Группа 2
Элемент группы 1 + Элемент группы 2
"""	
	И я нажимаю на кнопку "Сформировать"

	Тогда в группе "Группа 1" содержатся элементы
		| 'Элемент группы 1' |

	Тогда в группе "Группа 2" содержатся элементы
		| 'Элемент группы 2' |

Сценарий: Форматировать вертикальные группы
	Когда в поле с именем '__Редактор' я ввожу текст 
"""
#Группа 1 #Группа 2
Элемент группы 1 + Элемент группы 2
"""	

	И я нажимаю на кнопку с именем '__Форматировать'

	Тогда значение поля с именем '__Редактор' содержит текст
"""
#Группа 1          #Группа 2
Элемент группы 1   +   Элемент группы 2
"""