﻿// Элементы

Элемент_Страницы = Элементы.Добавить("Страницы", Тип("ГруппаФормы"));
Элемент_Страницы.Вид = ВидГруппыФормы.Страницы;
Элемент_Страницы.РастягиватьПоГоризонтали = Истина;
Элемент_Страницы.РастягиватьПоВертикали = Ложь;

Элемент_Страница1 = Элементы.Добавить("Страница1", Тип("ГруппаФормы"), Элемент_Страницы);
Элемент_Страница1.Вид = ВидГруппыФормы.Страница;
Элемент_Страница1.Заголовок = "Страница 1";

Элемент_Надпись = Элементы.Добавить("Надпись", Тип("ДекорацияФормы"), Элемент_Страница1);
Элемент_Надпись.Вид = ВидДекорацииФормы.Надпись;
Элемент_Надпись.Заголовок = "Элемент 1";

Элемент_Страница2 = Элементы.Добавить("Страница2", Тип("ГруппаФормы"), Элемент_Страницы);
Элемент_Страница2.Вид = ВидГруппыФормы.Страница;
Элемент_Страница2.Заголовок = "Страница 2";

Элемент_Надпись1 = Элементы.Добавить("Надпись1", Тип("ДекорацияФормы"), Элемент_Страница2);
Элемент_Надпись1.Вид = ВидДекорацииФормы.Надпись;
Элемент_Надпись1.Заголовок = "Элемент 2";