﻿// Реквизиты

ДобавляемыеРеквизиты = Новый Массив;

ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы("Таблица", Новый ОписаниеТипов("ТаблицаЗначений")));
ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы("Колонка1", Новый ОписаниеТипов("Строка"), "Таблица"));
ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы("Колонка1Флажок", Новый ОписаниеТипов("Булево"), "Таблица"));

ИзменитьРеквизиты(ДобавляемыеРеквизиты);

// Элементы

Элемент_Таблица = Элементы.Добавить("Таблица", Тип("ТаблицаФормы"));
Элемент_Таблица.ПутьКДанным = "Таблица";
Элемент_Таблица.ПоложениеКоманднойПанели = ПоложениеКоманднойПанелиЭлементаФормы.Нет;

Элемент_ТаблицаКолонка1Вместе = Элементы.Добавить("ТаблицаКолонка1Вместе", Тип("ГруппаФормы"), Элемент_Таблица);
Элемент_ТаблицаКолонка1Вместе.Вид = ВидГруппыФормы.ГруппаКолонок;
Элемент_ТаблицаКолонка1Вместе.Группировка = ГруппировкаКолонок.ВЯчейке;
Элемент_ТаблицаКолонка1Вместе.Заголовок = "Колонка 1";
Элемент_ТаблицаКолонка1Вместе.ОтображатьВШапке = Истина;

Элемент_ТаблицаКолонка1Флажок = Элементы.Добавить("ТаблицаКолонка1Флажок", Тип("ПолеФормы"), Элемент_ТаблицаКолонка1Вместе);
Элемент_ТаблицаКолонка1Флажок.Вид = ВидПоляФормы.ПолеФлажка;
Элемент_ТаблицаКолонка1Флажок.ПутьКДанным = "Таблица.Колонка1Флажок";
Элемент_ТаблицаКолонка1Флажок.ОтображатьВШапке = Ложь;
Элемент_ТаблицаКолонка1Флажок.Заголовок = "Колонка 1";

Элемент_ТаблицаКолонка1 = Элементы.Добавить("ТаблицаКолонка1", Тип("ПолеФормы"), Элемент_ТаблицаКолонка1Вместе);
Элемент_ТаблицаКолонка1.Вид = ВидПоляФормы.ПолеВвода;
Элемент_ТаблицаКолонка1.ПутьКДанным = "Таблица.Колонка1";
Элемент_ТаблицаКолонка1.ОтображатьВШапке = Ложь;
Элемент_ТаблицаКолонка1.Заголовок = "Колонка 1";