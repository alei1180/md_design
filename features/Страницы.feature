﻿#language: ru

@tree

Функционал: Добавление страниц

Как Аналитик я хочу
Добавлять страницы на форму
чтобы видеть макет формы

Контекст:
	Дано Я открыл новый сеанс TestClient или подключил уже существующий
	И я закрываю все окна клиентского приложения
	И я открываю внешнюю обработку или отчет "$КаталогПроекта$\dst\MDDesign.epf" (Расширение)

Сценарий: Создавать страницы
	Когда в поле с именем '__Редактор' я ввожу текст 
		| '/Страница 1' |
		| '	Элемент 1'  |
		| '/Страница 2' |
		| '	Элемент 2'  |

	И я нажимаю на кнопку "Сформировать"

	Тогда в группе "Страница 1" содержатся элементы
		| 'Элемент 1' |

	Тогда в группе "Страница 2" содержатся элементы
		| 'Элемент 2' |

Сценарий: Форматировать страницы
	Когда в поле с именем '__Редактор' я ввожу текст 
		|'/Страница 1'|
		|'	Элемент 1'|
		|'/Страница 2'|
		|'	Элемент 2'|

	И я нажимаю на кнопку с именем '__Форматировать'

	Тогда элемент формы с именем '__Редактор' стал равен
		| ''            |
		| '/Страница 1' |
		| ''            |
		| '	Элемент 1'  |
		| ''            |
		| '/Страница 2' |
		| ''            |
		| '	Элемент 2'  |

Сценарий: Создавать элемент после окончания страниц #9
	Когда в поле с именем '__Редактор' я ввожу текст 
		| '/Страница 1'           |
		| '	Элемент 1'            |
		| '/Страница 2'           |
		| '	Элемент 2'            |
		| 'Элемент после страниц' |

	И я нажимаю на кнопку "Сформировать"

	Тогда в группе "Страница 1" не содержатся элементы"
		| 'Элемент после страниц' |

	И в группе "Страница 2" не содержатся элементы"
		| 'Элемент после страниц' |
