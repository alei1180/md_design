﻿// MIT License

// Copyright (c) 2025 Zherebtsov Nikita <nikita@crimsongold.ru>

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

// https://github.com/crimsongoldteam/md_design

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.ДополнительныеОтчетыИОбработки

// Возвращает сведения о внешней обработке.
//
// Возвращаемое значение:
//   см. ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке
//
Функция СведенияОВнешнейОбработке() Экспорт
	
	Версия = "0.10.10";
	Идентификатор = "Накидка";
	БезопасныйРежим = Истина;
	Представление = НСтр("ru = 'Накидка'; en = 'MD_Design'");
	ПоказыватьОповещение = Ложь;
	
	Если ЭтоБСП() Тогда
		Модуль = Вычислить("ДополнительныеОтчетыИОбработки");
		МодульКлиентСервер = Вычислить("ДополнительныеОтчетыИОбработкиКлиентСервер");
		
		ПараметрыРегистрации = Модуль.СведенияОВнешнейОбработке();
		
		ПараметрыРегистрации.Вид = МодульКлиентСервер.ВидОбработкиДополнительнаяОбработка();
		ПараметрыРегистрации.Версия = Версия;
		ПараметрыРегистрации.БезопасныйРежим = БезопасныйРежим;
		
		НоваяКоманда = ПараметрыРегистрации.Команды.Добавить();
		НоваяКоманда.Представление = Представление;
		НоваяКоманда.Идентификатор = Идентификатор;
		НоваяКоманда.Использование = МодульКлиентСервер.ТипКомандыОткрытиеФормы();
		НоваяКоманда.ПоказыватьОповещение = ПоказыватьОповещение;
	ИначеЕсли ЭтоSSL() Тогда
		Модуль = Вычислить("AdditionalReportsAndDataProcessors");
		МодульКлиентСервер = Вычислить("AdditionalReportsAndDataProcessorsClientServer");
		
		ПараметрыРегистрации = Модуль.ExternalDataProcessorInfo();
		
		ПараметрыРегистрации.Kind = МодульКлиентСервер.DataProcessorKindAdditionalDataProcessor();
		ПараметрыРегистрации.Version = Версия;
		ПараметрыРегистрации.SafeMode = БезопасныйРежим;
		ПараметрыРегистрации.Вставить("Версия", Версия);
		
		НоваяКоманда = ПараметрыРегистрации.Commands.Добавить();
		НоваяКоманда.Presentation = Представление;
		НоваяКоманда.ID = Идентификатор;
		НоваяКоманда.Use = МодульКлиентСервер.CommandTypeOpenForm();
		НоваяКоманда.ShouldShowUserNotification = ПоказыватьОповещение;
	Иначе
		ПараметрыРегистрации = Новый Структура;
		
		ПараметрыРегистрации.Вставить("Вид", "НашID");
		ПараметрыРегистрации.Вставить("Версия", Версия);
		ПараметрыРегистрации.Вставить("БезопасныйРежим", БезопасныйРежим);
	КонецЕсли;
	
	Возврат ПараметрыРегистрации;
	
КонецФункции

// Конец СтандартныеПодсистемы.ДополнительныеОтчетыИОбработки

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Процедура ПостроитьНаСервере(Форма, ГруппаРодитель, ДанныеГенератора) Экспорт
	ИзменитьРеквизитыФормы(Форма, ДанныеГенератора.Реквизиты);
	
	ГруппаКонтейнер = ПересоздатьГруппуКонтейнер(ГруппаРодитель, Форма);

	ДобавитьЭлементыФормы(Форма, ДанныеГенератора.Элементы, ГруппаКонтейнер); 
	ЗаполнитьДанныеФормы(Форма, ДанныеГенератора.Данные);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ЭтоБСП()
	
	Возврат Метаданные.ОбщиеМодули.Найти("ДополнительныеОтчетыИОбработки") <> Неопределено;
	
КонецФункции

Функция ЭтоSSL()
	
	Возврат Метаданные.ОбщиеМодули.Найти("AdditionalReportsAndDataProcessors") <> Неопределено;
	
КонецФункции

Функция ПересоздатьГруппуКонтейнер(ГруппаРодитель, Знач Форма)
	ГруппаКонтейнер = Форма.Элементы.Найти("ГруппаКонтейнер");
	Если ГруппаКонтейнер <> Неопределено Тогда
		Форма.Элементы.Удалить(ГруппаКонтейнер);
	КонецЕсли;
	
	ГруппаКонтейнер = Форма.Элементы.Добавить("ГруппаКонтейнер", Тип("ГруппаФормы"), ГруппаРодитель);
	ГруппаКонтейнер.Вид = ВидГруппыФормы.ОбычнаяГруппа;
	ГруппаКонтейнер.Отображение = ОтображениеОбычнойГруппы.Нет;
	ГруппаКонтейнер.ОтображатьЗаголовок = Ложь; 
	ГруппаКонтейнер.РастягиватьПоГоризонтали = Истина;
	ГруппаКонтейнер.РастягиватьПоВертикали = Истина;
	ГруппаКонтейнер.Группировка = ГруппировкаПодчиненныхЭлементовФормы.Вертикальная;
	Возврат ГруппаКонтейнер;
КонецФункции

Процедура ЗаполнитьДанныеФормы(Форма, Данные)
	Для Каждого КлючЗначение Из Данные Цикл
		ИмяРеквизита = КлючЗначение.Ключ;
		ДанныеРеквизита = КлючЗначение.Значение;

		Если ДанныеРеквизита.Тип = "Таблица" Тогда
			Таблица = Форма[ИмяРеквизита];
			Таблица.Очистить();
			ДобавитьДеревоСтроки(Таблица, ДанныеРеквизита.Строки, Ложь);
			Продолжить;
		КонецЕсли;
		
		Если ДанныеРеквизита.Тип = "Дерево" Тогда
			ЭлементыДерева = Форма[ИмяРеквизита].ПолучитьЭлементы();
			ЭлементыДерева.Очистить();
			ДобавитьДеревоСтроки(ЭлементыДерева, ДанныеРеквизита.Строки, Истина);
			Продолжить;
		КонецЕсли;      
		
		Форма[ИмяРеквизита] = ДанныеРеквизита.Значение;
	КонецЦикла;	
КонецПроцедуры

Процедура ИзменитьРеквизитыФормы(Форма, ОписанияРеквизитов)
	МассивРеквизитов = Новый Массив;
	НовыйМассивСуществующих = Новый Массив;
	Для Каждого СтрокаРеквизит Из ОписанияРеквизитов Цикл  
		ОписаниеТипа = ПолучитьОписаниеТипов(СтрокаРеквизит.ОписаниеТипов);
		
		ДобавляемыйРеквизит = Новый РеквизитФормы(СтрокаРеквизит.Имя, ОписаниеТипа, СтрокаРеквизит.ИмяВладельца);
		МассивРеквизитов.Добавить(ДобавляемыйРеквизит);
		Если НЕ СтрокаРеквизит.Автоудаление Тогда
			НовыйМассивСуществующих.Добавить(СтрокаРеквизит.Имя);
		КонецЕсли;
 	КонецЦикла;
	
	МассивУдаляемых = Форма.__ТаблицаСуществующихРеквизитов.Выгрузить().ВыгрузитьКолонку("ИмяРеквизита");
	
	Форма.ИзменитьРеквизиты(МассивРеквизитов, МассивУдаляемых);  
	
	Форма.__ТаблицаСуществующихРеквизитов.Очистить();
	Для Каждого ИмяРеквизита Из НовыйМассивСуществующих Цикл
		Строка = Форма.__ТаблицаСуществующихРеквизитов.Добавить();
		Строка.ИмяРеквизита = ИмяРеквизита;
	КонецЦикла;
КонецПроцедуры

Функция ПолучитьОписаниеТипов(СоотвОписаниеТипов)
	
	КвалификаторыЧисла = Неопределено;
	КвалификаторыСтроки = Неопределено;
	КвалификаторыДаты = Неопределено;  
	
	Если СоотвОписаниеТипов.Типы.Найти("Число") <> Неопределено Тогда 
		ДлинаЧисла = ?(СоотвОписаниеТипов.ДлинаЧисла = Неопределено, 0, СоотвОписаниеТипов.ДлинаЧисла);  
		ТочностьЧисла = ?(СоотвОписаниеТипов.ТочностьЧисла = Неопределено, 0, СоотвОписаниеТипов.ТочностьЧисла);

		КвалификаторыЧисла = Новый КвалификаторыЧисла(ДлинаЧисла, ТочностьЧисла);
	КонецЕсли;	
	
	Если СоотвОписаниеТипов.Типы.Найти("Строка") <> Неопределено 
		И СоотвОписаниеТипов.ДлинаСтроки <> Неопределено Тогда    
		ДлинаСтроки = ?(СоотвОписаниеТипов.ДлинаСтроки = Неопределено, 0, СоотвОписаниеТипов.ДлинаСтроки);  
		КвалификаторыСтроки = Новый КвалификаторыСтроки(ДлинаСтроки);
	КонецЕсли;	
	
	Если СоотвОписаниеТипов.Типы.Найти("Дата") <> Неопределено Тогда
		ТекЧастиДаты = ?(СоотвОписаниеТипов.ЧастиДаты = Неопределено, ЧастиДаты.ДатаВремя, ПолучитьЗначениеСвойства(Новый Структура("Тип,Значение","ЧастиДаты", СоотвОписаниеТипов.ЧастиДаты)));  

		КвалификаторыДаты = Новый КвалификаторыДаты(ТекЧастиДаты);
	КонецЕсли;	
	
	Возврат Новый ОписаниеТипов(
		СтрСоединить(СоотвОписаниеТипов.Типы,","), 
		КвалификаторыЧисла, 
		КвалификаторыСтроки, 
		КвалификаторыДаты);
КонецФункции

Процедура ДобавитьЭлементыФормы(Форма, Элементы, Группа)
	Для Каждого Элемент Из Элементы Цикл
		ДобавитьЭлементФормы(Форма, Элемент, Группа);
	КонецЦикла;
КонецПроцедуры 

Процедура ДобавитьЭлементФормы(Форма, ОписаниеЭлемента, Группа)
	Родитель = Группа;
	Если ОписаниеЭлемента.ИмяРодителя <> Неопределено Тогда
		Родитель = Форма.Элементы[ОписаниеЭлемента.ИмяРодителя];
	КонецЕсли;
	НовыйЭлемент = Форма.Элементы.Добавить(ОписаниеЭлемента.Имя, Тип(ОписаниеЭлемента.Тип), Родитель);
	
	Для Каждого КлючЗначение Из ОписаниеЭлемента.НаборСвойств Цикл
		ИмяСвойства = КлючЗначение.Ключ;  	
		ЗначениеСвойства = ПолучитьЗначениеСвойства(КлючЗначение.Значение);  
		
		НовыйЭлемент[ИмяСвойства] = ЗначениеСвойства;
	КонецЦикла;
	
КонецПроцедуры    

Функция ПолучитьЗначениеСвойства(ЗначениеСвойства)
	Если ЗначениеСвойства.Тип = "Число" 
		ИЛИ ЗначениеСвойства.Тип = "Строка"
		ИЛИ ЗначениеСвойства.Тип = "Булево" Тогда
		Возврат ЗначениеСвойства.Значение;
	КонецЕсли;
	
	Возврат Вычислить(ЗначениеСвойства.Тип + "." + ЗначениеСвойства.Значение);
КонецФункции 

Процедура ДобавитьДеревоСтроки(ЭлементыДерева, Строки, ЭтоДерево)
	Для Каждого Строка Из Строки Цикл 
		СтрокаДерева = ЭлементыДерева.Добавить();
		
		Для Каждого КлючЗначение Из Строка.Значения Цикл
			СтрокаДерева[КлючЗначение.Ключ] = КлючЗначение.Значение;
		КонецЦикла;

		Если ЭтоДерево Тогда
			ДобавитьДеревоСтроки(СтрокаДерева.ПолучитьЭлементы(), Строка.Строки, Истина);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти 

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли
