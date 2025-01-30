﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.ДополнительныеОтчетыИОбработки

// Возвращает сведения о внешней обработке.
//
// Возвращаемое значение:
//   см. ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке
//
Функция СведенияОВнешнейОбработке() Экспорт
	
	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке();
	
	ПараметрыРегистрации.Вид = ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительнаяОбработка();
	ПараметрыРегистрации.Версия = "0.6.1";
	ПараметрыРегистрации.БезопасныйРежим = Истина;
	
	НоваяКоманда = ПараметрыРегистрации.Команды.Добавить();
	НоваяКоманда.Представление = НСтр("ru = 'md_design'");
	НоваяКоманда.Идентификатор = "md_design";
	НоваяКоманда.Использование = ДополнительныеОтчетыИОбработкиКлиентСервер.ТипКомандыОткрытиеФормы();
	НоваяКоманда.ПоказыватьОповещение = Ложь;
	
	Возврат ПараметрыРегистрации;
	
КонецФункции

// Конец СтандартныеПодсистемы.ДополнительныеОтчетыИОбработки

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

&НаСервере
Процедура ПостроитьНаСервере(Форма, ГруппаРодитель, Знач ОписаниеГруппы, Знач ОписанияРеквизитов) Экспорт
	ИзменитьРеквизитыФормыНаСервере(Форма, ОписанияРеквизитов);
	
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

	ПараметрыВыполнения = Новый Структура("ОписанияРеквизитов,Форма", ОписанияРеквизитов, Форма);
	
	ПостроитьЭлементыНаСервере(ПараметрыВыполнения, ОписаниеГруппы, ГруппаКонтейнер);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ИзменитьРеквизитыФормыНаСервере(Форма, ОписанияРеквизитов)
	МассивРеквизитов = Новый Массив;
	НовыйМассивСуществующих = Новый Массив;
	Для Каждого СтрокаРеквизит Из ОписанияРеквизитов Цикл
		Если ПустаяСтрока(СтрокаРеквизит.ИмяРеквизита) Тогда
			Продолжить;
		КонецЕсли;
		
		ИмяРеквизита = СтрокаРеквизит.ИмяРеквизита;
		Если СтрокаРеквизит.Номер > 1 Тогда
			СтрокаНомер = Формат(СтрокаРеквизит.Номер - 1, "ЧГ=0");
			ИмяРеквизита = ИмяРеквизита + СтрокаНомер;
		КонецЕсли;
		
		Если СтрокаРеквизит.ТипРеквизита = "ПолеВвода" Тогда
			ДобавляемыйРеквизит = Новый РеквизитФормы(ИмяРеквизита, Новый ОписаниеТипов("Строка",,Новый КвалификаторыСтроки(0)));
			МассивРеквизитов.Добавить(ДобавляемыйРеквизит);
			НовыйМассивСуществующих.Добавить(ИмяРеквизита);
		КонецЕсли;

		Если СтрокаРеквизит.ТипРеквизита = "Флажок" Тогда
			ДобавляемыйРеквизит = Новый РеквизитФормы(ИмяРеквизита, Новый ОписаниеТипов("Булево"));
			МассивРеквизитов.Добавить(ДобавляемыйРеквизит);
			НовыйМассивСуществующих.Добавить(ИмяРеквизита);
		КонецЕсли;
		
		Если СтрокаРеквизит.ТипРеквизита = "Таблица" Тогда
			ДобавляемыйРеквизит = Новый РеквизитФормы(ИмяРеквизита, Новый ОписаниеТипов("ТаблицаЗначений"));
			МассивРеквизитов.Добавить(ДобавляемыйРеквизит);
			НовыйМассивСуществующих.Добавить(ИмяРеквизита);
		КонецЕсли;

		Если СтрокаРеквизит.ТипРеквизита = "Дерево" Тогда
			ДобавляемыйРеквизит = Новый РеквизитФормы(ИмяРеквизита, Новый ОписаниеТипов("ДеревоЗначений"));
			МассивРеквизитов.Добавить(ДобавляемыйРеквизит);
			НовыйМассивСуществующих.Добавить(ИмяРеквизита);
		КонецЕсли;
		
		Если СтрокаРеквизит.ТипРеквизита = "Колонка" Тогда 
			СтрокаВладелец = ПолучитьСтрокуТаблицыРеквизитовНаСервере(ОписанияРеквизитов, СтрокаРеквизит.УИДВладельца);
			
			ДобавляемыйРеквизит = Новый РеквизитФормы(
				ИмяРеквизита, 
				Новый ОписаниеТипов("Строка",,Новый КвалификаторыСтроки(0)),
				СтрокаВладелец.ИмяРеквизита);
			МассивРеквизитов.Добавить(ДобавляемыйРеквизит);
		КонецЕсли;

		Если СтрокаРеквизит.ТипРеквизита = "КолонкаФлажок" Тогда 
			СтрокаВладелец = ПолучитьСтрокуТаблицыРеквизитовНаСервере(ОписанияРеквизитов, СтрокаРеквизит.УИДВладельца);
			
			ДобавляемыйРеквизит = Новый РеквизитФормы(
				ИмяРеквизита, 
				Новый ОписаниеТипов("Булево"),
				СтрокаВладелец.ИмяРеквизита);

			МассивРеквизитов.Добавить(ДобавляемыйРеквизит);
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

&НаСервере
Процедура ПостроитьЭлементыНаСервере(ПараметрыВыполнения, Данные, Группа)      
	
	Подчиненные = Данные.Элементы;
	
	Для Каждого ЭлементДанных Из Подчиненные Цикл
		ПостроитьЭлементНаСервере(ПараметрыВыполнения, ЭлементДанных, Группа);
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура ПостроитьЭлементНаСервере(ПараметрыВыполнения, ЭлементДанных, Группа)
	Выполнена = Ложь;
	
	ДобавитьГоризонтальнуюГруппу(ПараметрыВыполнения, ЭлементДанных, Группа, Выполнена);
	Если Выполнена Тогда
		Возврат;
	КонецЕсли; 

	ДобавитьОднострочнуюГруппу(ПараметрыВыполнения, ЭлементДанных, Группа, Выполнена);
	Если Выполнена Тогда
		Возврат;
	КонецЕсли; 

	ДобавитьВертикальнуюГруппу(ПараметрыВыполнения, ЭлементДанных, Группа, Выполнена);
	Если Выполнена Тогда
		Возврат;
	КонецЕсли;

	ДобавитьЭлементПолеВвода(ПараметрыВыполнения, ЭлементДанных, Группа, Выполнена);
	Если Выполнена Тогда
		Возврат;
	КонецЕсли;

	ДобавитьЭлементФлажок(ПараметрыВыполнения, ЭлементДанных, Группа, Выполнена);
	Если Выполнена Тогда
		Возврат;
	КонецЕсли;

	ДобавитьЭлементНадпись(ПараметрыВыполнения, ЭлементДанных, Группа, Выполнена);
	Если Выполнена Тогда
		Возврат;
	КонецЕсли;

	ДобавитьТаблицуДерево(ПараметрыВыполнения, ЭлементДанных, Группа, Выполнена);
	Если Выполнена Тогда
		Возврат;
	КонецЕсли;
	
	ДобавитьСтраницы(ПараметрыВыполнения, ЭлементДанных, Группа, Выполнена);
	Если Выполнена Тогда
		Возврат;
	КонецЕсли;

	ДобавитьКоманднуюПанель(ПараметрыВыполнения, ЭлементДанных, Группа, Выполнена);
	Если Выполнена Тогда
		Возврат;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ДобавитьГоризонтальнуюГруппу(ПараметрыВыполнения, ЭлементДанных, Группа, Выполнена)  	
	Если ЭлементДанных.Тип <> "ГоризонтальнаяГруппа" Тогда 
		Возврат;
	КонецЕсли;
	
	Форма = ПараметрыВыполнения.Форма;
	
	СтрокаРеквизитов = ПолучитьСтрокуТаблицыРеквизитовНаСервере(
		ПараметрыВыполнения.ОписанияРеквизитов, 
		ЭлементДанных.УИД);
	
	ИмяЭлемента = СтрокаРеквизитов.ИмяЭлемента;
	
	НоваяГруппа = Форма.Элементы.Добавить(ИмяЭлемента, Тип("ГруппаФормы"), Группа);
	НоваяГруппа.Вид = ВидГруппыФормы.ОбычнаяГруппа;
	НоваяГруппа.Отображение = ОтображениеОбычнойГруппы.Нет;
	НоваяГруппа.ОтображатьЗаголовок = Ложь; 
	НоваяГруппа.Группировка = ГруппировкаПодчиненныхЭлементовФормы.ГоризонтальнаяВсегда;
	НоваяГруппа.РастягиватьПоГоризонтали = Истина;
	НоваяГруппа.РастягиватьПоВертикали = Ложь;
	
	ПостроитьЭлементыНаСервере(ПараметрыВыполнения, ЭлементДанных, НоваяГруппа);
	
	Выполнена = Истина;
КонецПроцедуры

&НаСервере
Процедура ДобавитьОднострочнуюГруппу(ПараметрыВыполнения, ЭлементДанных, Группа, Выполнена)  	
	Если ЭлементДанных.Тип <> "ОднострочнаяГруппа" Тогда 
		Возврат;
	КонецЕсли;

	Форма = ПараметрыВыполнения.Форма;
	
	СтрокаРеквизитов = ПолучитьСтрокуТаблицыРеквизитовНаСервере(
		ПараметрыВыполнения.ОписанияРеквизитов,
		ЭлементДанных.УИД);
	
	ИмяЭлемента = СтрокаРеквизитов.ИмяЭлемента;
	
	НоваяГруппа = Форма.Элементы.Добавить(ИмяЭлемента, Тип("ГруппаФормы"), Группа);
	НоваяГруппа.Вид = ВидГруппыФормы.ОбычнаяГруппа;
	НоваяГруппа.Отображение = ОтображениеОбычнойГруппы.Нет;
	НоваяГруппа.ОтображатьЗаголовок = Ложь; 
	НоваяГруппа.Группировка = ГруппировкаПодчиненныхЭлементовФормы.ГоризонтальнаяВсегда;
	НоваяГруппа.РастягиватьПоГоризонтали = Истина;
	НоваяГруппа.РастягиватьПоВертикали = Ложь;
	НоваяГруппа.СквозноеВыравнивание = СквозноеВыравнивание.НеИспользовать; 
	
	ПостроитьЭлементыНаСервере(ПараметрыВыполнения, ЭлементДанных, НоваяГруппа);
	
	Выполнена = Истина;
КонецПроцедуры

&НаСервере
Процедура ДобавитьВертикальнуюГруппу(ПараметрыВыполнения, ЭлементДанных, Группа, Выполнена)  	
	Если ЭлементДанных.Тип <> "ВертикальнаяГруппа" Тогда 
		Возврат;
	КонецЕсли;

	Форма = ПараметрыВыполнения.Форма;
	
	СтрокаРеквизитов = ПолучитьСтрокуТаблицыРеквизитовНаСервере(
		ПараметрыВыполнения.ОписанияРеквизитов,
		ЭлементДанных.УИД);
	
	ИмяЭлемента = СтрокаРеквизитов.ИмяЭлемента;
	
	НоваяГруппа = Форма.Элементы.Добавить(ИмяЭлемента, Тип("ГруппаФормы"), Группа);
	НоваяГруппа.Вид = ВидГруппыФормы.ОбычнаяГруппа;
	НоваяГруппа.Отображение = ОтображениеОбычнойГруппы.Нет;
	
	НоваяГруппа.ОтображатьЗаголовок = ЭлементДанных.НаборСвойств.ОтображатьЗаголовок; 
	НоваяГруппа.Заголовок = ЭлементДанных.НаборСвойств.Заголовок;
	
	НоваяГруппа.Группировка = ГруппировкаПодчиненныхЭлементовФормы.Вертикальная;
	НоваяГруппа.РастягиватьПоГоризонтали = Истина;
	НоваяГруппа.РастягиватьПоВертикали = Ложь;
	
	ПостроитьЭлементыНаСервере(ПараметрыВыполнения, ЭлементДанных, НоваяГруппа);   
	
	Выполнена = Истина;
КонецПроцедуры

&НаСервере
Процедура ДобавитьЭлементНадпись(ПараметрыВыполнения, ЭлементДанных, Группа, Выполнена)  	
	Если ЭлементДанных.Тип <> "Надпись" Тогда 
		Возврат;
	КонецЕсли;

	Форма = ПараметрыВыполнения.Форма;
	
	СтрокаРеквизитов = ПолучитьСтрокуТаблицыРеквизитовНаСервере(
		ПараметрыВыполнения.ОписанияРеквизитов,
		ЭлементДанных.УИД);
	ИмяЭлемента = СтрокаРеквизитов.ИмяЭлемента;

	НовыйЭлемент = Форма.Элементы.Добавить(ИмяЭлемента, Тип("ДекорацияФормы"), Группа);
	НовыйЭлемент.Вид = ВидДекорацииФормы.Надпись;

	УстановитьСвойствоЭлементаНаСервере(НовыйЭлемент, ЭлементДанных);

	Выполнена = Истина;
КонецПроцедуры

&НаСервере
Процедура ДобавитьЭлементПолеВвода(ПараметрыВыполнения, ЭлементДанных, Группа, Выполнена)     
	Если ЭлементДанных.Тип <> "ПолеВвода" Тогда 
		Возврат;
	КонецЕсли;
	
	Форма = ПараметрыВыполнения.Форма;

	СтрокаРеквизитов = ПолучитьСтрокуТаблицыРеквизитовНаСервере(
		ПараметрыВыполнения.ОписанияРеквизитов,
		ЭлементДанных.УИД);
	ИмяЭлемента = СтрокаРеквизитов.ИмяЭлемента;
	ИмяРеквизита =  СтрокаРеквизитов.ИмяРеквизита;
	
	НовыйЭлемент = Форма.Элементы.Добавить(ИмяЭлемента, Тип("ПолеФормы"), Группа);
	НовыйЭлемент.Вид = ВидПоляФормы.ПолеВвода;
	НовыйЭлемент.ПутьКДанным = ИмяРеквизита;         
	НовыйЭлемент.АвтоМаксимальнаяШирина = Ложь;
	
	УстановитьСвойствоЭлементаНаСервере(НовыйЭлемент, ЭлементДанных);

	Форма[ИмяРеквизита] = ЭлементДанных.Значение;    
	
	Выполнена = Истина;
КонецПроцедуры

&НаСервере
Процедура ДобавитьЭлементФлажок(ПараметрыВыполнения, ЭлементДанных, Группа, Выполнена)  
	Если ЭлементДанных.Тип <> "Флажок" Тогда 
		Возврат;
	КонецЕсли;
	
	Форма = ПараметрыВыполнения.Форма;
	
	СтрокаРеквизитов = ПолучитьСтрокуТаблицыРеквизитовНаСервере(
		ПараметрыВыполнения.ОписанияРеквизитов,
		ЭлементДанных.УИД);
	ИмяЭлемента = СтрокаРеквизитов.ИмяЭлемента;
	ИмяРеквизита =  СтрокаРеквизитов.ИмяРеквизита;
	
	НовыйЭлемент = Форма.Элементы.Добавить(ИмяЭлемента, Тип("ПолеФормы"), Группа);
	НовыйЭлемент.Вид = ВидПоляФормы.ПолеФлажка;
	НовыйЭлемент.ПутьКДанным = ИмяРеквизита;

	УстановитьСвойствоЭлементаНаСервере(НовыйЭлемент, ЭлементДанных);
	
	Форма[ИмяРеквизита] = ЭлементДанных.Значение;  

	Выполнена = Истина;
КонецПроцедуры

&НаСервере
Процедура ДобавитьТаблицуДерево(ПараметрыВыполнения, ЭлементДанных, Группа, Выполнена)  
	Если ЭлементДанных.Тип <> "Дерево" 
		И ЭлементДанных.Тип <> "Таблица" Тогда 
		Возврат;
	КонецЕсли;
	
	Форма = ПараметрыВыполнения.Форма;
	
	ОписанияРеквизитов = ПараметрыВыполнения.ОписанияРеквизитов;
	
	СтрокаРеквизитовТаблица = ПолучитьСтрокуТаблицыРеквизитовНаСервере(ОписанияРеквизитов, ЭлементДанных.УИД);
	ИмяЭлементаТаблица = СтрокаРеквизитовТаблица.ИмяЭлемента;
	ИмяРеквизитаТаблица = СтрокаРеквизитовТаблица.ИмяРеквизита;
	
	НоваяТаблица = Форма.Элементы.Добавить(ИмяЭлементаТаблица, Тип("ТаблицаФормы"), Группа);
	НоваяТаблица.ПутьКДанным = ИмяРеквизитаТаблица;
	НоваяТаблица.ПоложениеКоманднойПанели = ПоложениеКоманднойПанелиЭлементаФормы.Нет;
	
	Колонки = ЭлементДанных.Колонки;
	Строки = ЭлементДанных.Строки;
	
	Для Каждого Колонка Из Колонки Цикл
		ДобавитьКолонкуТаблицыРекурсивно(ПараметрыВыполнения, НоваяТаблица, "Таблица", ИмяРеквизитаТаблица, Колонка);
	КонецЦикла;          
	
	Если ЭлементДанных.Тип = "Дерево"  Тогда
		ЭлементыДерева = Форма[ИмяЭлементаТаблица].ПолучитьЭлементы();
		ЭлементыДерева.Очистить(); 
		
		ДобавитьДеревоСтроки(ПараметрыВыполнения, Строки, Колонки, ЭлементыДерева, Истина);
	Иначе
		Форма[ИмяЭлементаТаблица].Очистить();
		ДобавитьДеревоСтроки(ПараметрыВыполнения, Строки, Колонки, Форма[ИмяЭлементаТаблица], Ложь);
	КонецЕсли;
	
	Выполнена = Истина;
КонецПроцедуры

&НаСервере
Функция ДобавитьГруппуКолонокТаблицы(ПараметрыВыполнения, ЭлементРодитель, ИмяЭлемента, ГруппировкаКолонок, Заголовок = Неопределено)
	Форма = ПараметрыВыполнения.Форма;
	
	НоваяГруппа = Форма.Элементы.Добавить(ИмяЭлемента, Тип("ГруппаФормы"), ЭлементРодитель);
	НоваяГруппа.Вид = ВидГруппыФормы.ГруппаКолонок;
	НоваяГруппа.Группировка = ГруппировкаКолонок;  
	Если Заголовок <> Неопределено Тогда
		НоваяГруппа.Заголовок = Заголовок;
	КонецЕсли;
	НоваяГруппа.ОтображатьВШапке = Заголовок <> Неопределено;
	
	Возврат НоваяГруппа;
КонецФункции

&НаСервере
Процедура ДобавитьКолонкуТаблицыРекурсивно(ПараметрыВыполнения, ЭлементРодитель, ТипРодителя, ИмяРеквизитаТаблица, Колонка)
	ОписанияРеквизитов = ПараметрыВыполнения.ОписанияРеквизитов;
	
	СтрокаРеквизитов = ПолучитьСтрокуТаблицыРеквизитовНаСервере(ОписанияРеквизитов, Колонка.УИД);
	
	ТекРодитель = ЭлементРодитель;
	ТекТипРодителя = ТипРодителя;
	
	Колонки = Колонка.Колонки;
	КоличествоКолонок = Колонка.Колонки.Количество();
	
	ЕстьПодчиненные = КоличествоКолонок > 0;
	ЕстьГруппаПодчиненных = КоличествоКолонок > 1;
	
	ТребуетсяДобавитьГруппуКолонок = 
		Колонка.Тип = "ГруппаКолонокТаблицы";
		
	ТребуетсяДобавитьВертикальнуюГруппу = 
		НЕ ТребуетсяДобавитьГруппуКолонок 
		И ЕстьПодчиненные 
		И (ТипРодителя = "ГоризонтальнаяГруппа" 
			ИЛИ ТипРодителя = "Таблица");
			
	ТребуетсяДобавитьГоризонтальнуюГруппу =
		ТребуетсяДобавитьГруппуКолонок ИЛИ
		ЕстьГруппаПодчиненных;
			
	ТребуетсяДобавитьКолонкуТаблицы =
		НЕ ТребуетсяДобавитьГруппуКолонок;
		
	ЗаголовокГруппы = Неопределено;
	Если ТребуетсяДобавитьГруппуКолонок Тогда
		ЗаголовокГруппы = Колонка.НаборСвойств.Заголовок;
	КонецЕсли;
	
	Если ТребуетсяДобавитьВертикальнуюГруппу Тогда
		
		ИмяГруппы = ИмяРеквизитаТаблица + СтрокаРеквизитов.ИмяЭлемента + "Вертикальная";
		
		ТекРодитель = ДобавитьГруппуКолонокТаблицы(ПараметрыВыполнения, ТекРодитель, ИмяГруппы, ГруппировкаКолонок.Вертикальная);
		ТекТипРодителя = "ВертикальнаяГруппа";
	КонецЕсли;
	
	Если ТребуетсяДобавитьКолонкуТаблицы Тогда
		ДобавитьКолонкуТаблицы(ПараметрыВыполнения, ОписанияРеквизитов, ТекРодитель, ИмяРеквизитаТаблица, Колонка);
	КонецЕсли;
	
	Если ТребуетсяДобавитьГоризонтальнуюГруппу Тогда
		ИмяГруппы = ИмяРеквизитаТаблица + СтрокаРеквизитов.ИмяЭлемента + "Горизонтальная";
		
		ТекРодитель = ДобавитьГруппуКолонокТаблицы(
			ПараметрыВыполнения,
			ТекРодитель, 
			ИмяГруппы, 
			ГруппировкаКолонок.Горизонтальная,
			ЗаголовокГруппы);
		ТекТипРодителя = "ГоризонтальнаяГруппа";
	КонецЕсли;

	Для Каждого Колонка Из Колонки Цикл
		ДобавитьКолонкуТаблицыРекурсивно(ПараметрыВыполнения, ТекРодитель, ТекТипРодителя, ИмяРеквизитаТаблица, Колонка);
	КонецЦикла;          
КонецПроцедуры

&НаСервере
Процедура ДобавитьКолонкуТаблицы(ПараметрыВыполнения, ОписанияРеквизитов,Знач ЭлементРодитель, ИмяРеквизитаТаблица, Колонка)
	Форма = ПараметрыВыполнения.Форма;
	
	ТекРодитель = ЭлементРодитель;
	
	ЕстьГруппа = Колонка.ЕстьФлажок И Колонка.ЕстьЗначение;                

	Если ЕстьГруппа Тогда
		СтрокаРеквизитов = ПолучитьСтрокуТаблицыРеквизитовНаСервере(ОписанияРеквизитов, Колонка.УИД);
		ИмяЭлемента = ИмяРеквизитаТаблица + СтрокаРеквизитов.ИмяЭлемента + "Вместе";
		
		ТекРодитель = ДобавитьГруппуКолонокТаблицы(
		    ПараметрыВыполнения,
			ТекРодитель, 
			ИмяЭлемента, 
			ГруппировкаКолонок.ВЯчейке, 
			Колонка.НаборСвойств.Заголовок);
	КонецЕсли;
	
	Если Колонка.ЕстьФлажок Тогда
		СтрокаРеквизитов = ПолучитьСтрокуТаблицыРеквизитовНаСервере(ОписанияРеквизитов, Колонка.УИДФлажок);
		ИмяЭлемента = ИмяРеквизитаТаблица + СтрокаРеквизитов.ИмяЭлемента;
		ИмяРеквизита = ИмяРеквизитаТаблица + "." + СтрокаРеквизитов.ИмяРеквизита;
		
		НовыйКолонка = Форма.Элементы.Добавить(ИмяЭлемента, Тип("ПолеФормы"), ТекРодитель);
		НовыйКолонка.Вид = ВидПоляФормы.ПолеФлажка;
		НовыйКолонка.ПутьКДанным = ИмяРеквизита;
		НовыйКолонка.ОтображатьВШапке = НЕ ЕстьГруппа;
		НовыйКолонка.Заголовок = Колонка.НаборСвойств.Заголовок;
		НовыйКолонка.ГоризонтальноеПоложение = ГоризонтальноеПоложениеЭлемента[Колонка.НаборСвойств.ГоризонтальноеПоложение];
	КонецЕсли;
	
	Если Колонка.ЕстьЗначение Тогда
		СтрокаРеквизитов = ПолучитьСтрокуТаблицыРеквизитовНаСервере(ОписанияРеквизитов, Колонка.УИД);
		ИмяЭлемента = ИмяРеквизитаТаблица + СтрокаРеквизитов.ИмяЭлемента;
		ИмяРеквизита = ИмяРеквизитаТаблица + "." + СтрокаРеквизитов.ИмяРеквизита;
		
		НовыйКолонка = Форма.Элементы.Добавить(ИмяЭлемента, Тип("ПолеФормы"), ТекРодитель);
		НовыйКолонка.Вид = ВидПоляФормы.ПолеВвода;
		НовыйКолонка.ПутьКДанным = ИмяРеквизита;
		НовыйКолонка.Заголовок = Колонка.НаборСвойств.Заголовок;
		НовыйКолонка.ОтображатьВШапке = НЕ ЕстьГруппа;
		НовыйКолонка.ГоризонтальноеПоложение = ГоризонтальноеПоложениеЭлемента[Колонка.НаборСвойств.ГоризонтальноеПоложение];
	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ДобавитьДеревоСтроки(ПараметрыВыполнения, Строки, Колонки, ЭлементыДерева, ЭтоДерево)
	Для Каждого Строка Из Строки Цикл 
		СтрокаТаблицы = ЭлементыДерева.Добавить();
		
		Сч = 0;       
		Для Каждого Ячейка Из Строка.Ячейки Цикл  
		
			Если НЕ ПустаяСтрока(Ячейка.Значение) Тогда
				СтрокаРеквизитов = ПолучитьСтрокуТаблицыРеквизитовНаСервере(
					ПараметрыВыполнения.ОписанияРеквизитов, Ячейка.УИДКолонки);
				СтрокаТаблицы[СтрокаРеквизитов.ИмяРеквизита] = Ячейка.Значение; 
			КонецЕсли;
			
			Если Ячейка.ЕстьФлажок Тогда
				СтрокаРеквизитовФлажок = ПолучитьСтрокуТаблицыРеквизитовНаСервере(
					ПараметрыВыполнения.ОписанияРеквизитов,
					Ячейка.УИДКолонкиФлажок);
				СтрокаТаблицы[СтрокаРеквизитовФлажок.ИмяРеквизита] = Булево(Ячейка.ЗначениеФлажка);
			КонецЕсли;
			
			Сч = Сч + 1;
		КонецЦикла;
		
		Если ЭтоДерево Тогда
			ДобавитьДеревоСтроки(ПараметрыВыполнения, Строка.Строки, Колонки, СтрокаТаблицы.ПолучитьЭлементы(), Истина);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьСтраницы(ПараметрыВыполнения, ЭлементДанных, Группа, Выполнена)  	
	Если ЭлементДанных.Тип <> "Страницы" Тогда 
		Возврат;
	КонецЕсли;
	
	Форма = ПараметрыВыполнения.Форма;
	
	СтрокаРеквизитовСтраницы = ПолучитьСтрокуТаблицыРеквизитовНаСервере(
		ПараметрыВыполнения.ОписанияРеквизитов,
		ЭлементДанных.УИД);
	ИмяЭлементаСтраницы = СтрокаРеквизитовСтраницы.ИмяЭлемента;
	
	ЭлементСтраницы = Форма.Элементы.Добавить(ИмяЭлементаСтраницы, Тип("ГруппаФормы"), Группа);
	ЭлементСтраницы.Вид = ВидГруппыФормы.Страницы;
	ЭлементСтраницы.РастягиватьПоГоризонтали = Истина;
	ЭлементСтраницы.РастягиватьПоВертикали = Ложь;
	
	Страницы = ЭлементДанных.Элементы;
	
	Для Каждого Страница Из Страницы Цикл
		СтрокаРеквизитов = ПолучитьСтрокуТаблицыРеквизитовНаСервере(
		ПараметрыВыполнения.ОписанияРеквизитов,
		Страница.УИД);
		ИмяЭлемента = СтрокаРеквизитов.ИмяЭлемента;
		
		ЭлементСтраница = Форма.Элементы.Добавить(ИмяЭлемента, Тип("ГруппаФормы"), ЭлементСтраницы);
		ЭлементСтраница.Вид = ВидГруппыФормы.Страница;
		ЭлементСтраница.Заголовок = Страница.НаборСвойств.Заголовок;
		
		ПостроитьЭлементыНаСервере(ПараметрыВыполнения, Страница, ЭлементСтраница);
	КонецЦикла;
	
	Выполнена = Истина;
КонецПроцедуры

&НаСервере
Процедура ДобавитьКоманднуюПанель(ПараметрыВыполнения, ЭлементДанных, Группа, Выполнена)  
	Если ЭлементДанных.Тип <> "КоманднаяПанель" Тогда 
		Возврат;
	КонецЕсли;

	Форма = ПараметрыВыполнения.Форма;
	
	СтрокаРеквизитовКоманднаяПанель = ПолучитьСтрокуТаблицыРеквизитовНаСервере(
		ПараметрыВыполнения.ОписанияРеквизитов, 
		ЭлементДанных.УИД);
	ИмяЭлементаКоманднаяПанель = СтрокаРеквизитовКоманднаяПанель.ИмяЭлемента;
	
	НоваяКоманднаяПанель = Форма.Элементы.Добавить(
		ИмяЭлементаКоманднаяПанель, 
		Тип("ГруппаФормы"), 
		Группа);
	НоваяКоманднаяПанель.Вид = ВидГруппыФормы.КоманднаяПанель;
	
	НоваяКоманднаяПанель.ГоризонтальноеПоложение = 
		ГоризонтальноеПоложениеЭлемента[ЭлементДанных.НаборСвойств.ГоризонтальноеПоложение];
	
	ДобавитьКнопки(ПараметрыВыполнения, ЭлементДанных, НоваяКоманднаяПанель, ИмяЭлементаКоманднаяПанель);
	
	Выполнена = Истина;
КонецПроцедуры

&НаСервере
Процедура ДобавитьКнопки(ПараметрыВыполнения, ЭлементДанных, ЭлементФормыРодитель, ИмяЭлементаКоманднаяПанель)  
	Для Каждого Кнопка Из ЭлементДанных.Элементы Цикл   
		Если Кнопка.Тип = "ГруппаКнопок" Тогда
			ДобавитьГруппуКнопок(
				ПараметрыВыполнения,
				Кнопка, 
				ЭлементФормыРодитель, 
				ИмяЭлементаКоманднаяПанель);
			Продолжить;
		КонецЕсли;
		
		Если Кнопка.Тип = "Меню" Тогда
			ДобавитьМеню(
				ПараметрыВыполнения,
				Кнопка, 
				ЭлементФормыРодитель, 
				ИмяЭлементаКоманднаяПанель);
			Продолжить;
		КонецЕсли;
		ДобавитьКнопку(
			ПараметрыВыполнения,
			Кнопка, 
			ЭлементФормыРодитель, 
			ИмяЭлементаКоманднаяПанель);
	КонецЦикла;
КонецПроцедуры

&НаСервере
Процедура ДобавитьГруппуКнопок(ПараметрыВыполнения, Кнопка, ЭлементФормыРодитель, ИмяЭлементаКоманднаяПанель)  
	СтрокаРеквизитов = ПолучитьСтрокуТаблицыРеквизитовНаСервере(ПараметрыВыполнения.ОписанияРеквизитов, Кнопка.УИД);
	ИмяЭлемента = СтрокаРеквизитов.ИмяЭлемента;

	Форма = ПараметрыВыполнения.Форма;
	
	ЭлементКнопка = Форма.Элементы.Добавить(
		ИмяЭлементаКоманднаяПанель + ИмяЭлемента, 
		Тип("ГруппаФормы"), 
		ЭлементФормыРодитель);
	ЭлементКнопка.Вид = ВидГруппыФормы.ГруппаКнопок;
	
	УстановитьСвойствоЭлементаНаСервере(ЭлементКнопка, Кнопка);
	
	ДобавитьКнопки(ПараметрыВыполнения, Кнопка, ЭлементКнопка, ИмяЭлементаКоманднаяПанель);
КонецПроцедуры

&НаСервере
Процедура ДобавитьМеню(ПараметрыВыполнения, Кнопка, ЭлементФормыРодитель, ИмяЭлементаКоманднаяПанель)  
	СтрокаРеквизитов = ПолучитьСтрокуТаблицыРеквизитовНаСервере(ПараметрыВыполнения.ОписанияРеквизитов, Кнопка.УИД);
	ИмяЭлемента = СтрокаРеквизитов.ИмяЭлемента;
	Форма = ПараметрыВыполнения.Форма;
	
	ЭлементКнопка = Форма.Элементы.Добавить(
		ИмяЭлементаКоманднаяПанель + ИмяЭлемента, 
		Тип("ГруппаФормы"), 
		ЭлементФормыРодитель);
	ЭлементКнопка.Вид = ВидГруппыФормы.Подменю;
	ЭлементКнопка.Заголовок = Кнопка.НаборСвойств.Заголовок;         
	
	УстановитьСвойствоЭлементаНаСервере(ЭлементКнопка, Кнопка);
	
	Если ПустаяСтрока(Кнопка.НаборСвойств.Заголовок) Тогда
		ЭлементКнопка.Отображение = ОтображениеКнопки.Картинка;
	Иначе
		ЭлементКнопка.Отображение = ОтображениеКнопки.КартинкаИТекст;
	КонецЕсли;
	
	Если Кнопка.Картинка <> Неопределено Тогда
		ЭлементКнопка.Картинка = БиблиотекаКартинок[Кнопка.Картинка];
	КонецЕсли;
	
	ДобавитьКнопки(ПараметрыВыполнения, Кнопка, ЭлементКнопка, ИмяЭлементаКоманднаяПанель);
КонецПроцедуры

&НаСервере
Процедура ДобавитьКнопку(ПараметрыВыполнения, Кнопка, ЭлементФормыРодитель, ИмяЭлементаКоманднаяПанель)  
	СтрокаРеквизитов = ПолучитьСтрокуТаблицыРеквизитовНаСервере(ПараметрыВыполнения.ОписанияРеквизитов, Кнопка.УИД);
	ИмяЭлемента = СтрокаРеквизитов.ИмяЭлемента;
	Форма = ПараметрыВыполнения.Форма;
	
	ЭлементКнопка = Форма.Элементы.Добавить(
		ИмяЭлементаКоманднаяПанель + ИмяЭлемента, 
		Тип("КнопкаФормы"), 
		ЭлементФормыРодитель);
	ЭлементКнопка.ИмяКоманды = "__КомандаЗаглушка";
	ЭлементКнопка.Заголовок = Кнопка.НаборСвойств.Заголовок;         
	
	УстановитьСвойствоЭлементаНаСервере(ЭлементКнопка, Кнопка);
	
	Если ПустаяСтрока(Кнопка.НаборСвойств.Заголовок) Тогда
		ЭлементКнопка.Отображение = ОтображениеКнопки.Картинка;
	Иначе
		ЭлементКнопка.Отображение = ОтображениеКнопки.КартинкаИТекст;
	КонецЕсли;
	
	Если Кнопка.Картинка <> Неопределено Тогда
		ЭлементКнопка.Картинка = БиблиотекаКартинок[Кнопка.Картинка];
	КонецЕсли;   	
КонецПроцедуры

&НаСервере
Функция ПолучитьИмяРеквизита(ПараметрыВыполнения, Тип)
	СвободныйНомер = ПараметрыВыполнения.СвободныеНомераРеквизитов[Тип];
	ИмяРеквизита = СтрШаблон("%1Реквизит%2", Тип, СвободныйНомер);
	ПараметрыВыполнения.СвободныеНомераРеквизитов[Тип] = СвободныйНомер + 1;
	Возврат ИмяРеквизита;
КонецФункции 

&НаСервере
Процедура УстановитьСвойствоЭлементаНаСервере(ЭлементФормы, ЭлементДанных)
	Свойства = ЭлементДанных.НаборСвойств;
	Тип = ЭлементДанных.Тип;
	
	Если Свойства.Свойство("Заголовок") Тогда
		ЭлементФормы.Заголовок = Свойства.Заголовок;
	КонецЕсли;

	Если Свойства.Свойство("ГоризонтальноеПоложение") Тогда
		Если Тип = "Надпись" 
			ИЛИ Тип = "Флажок" Тогда
			ЭлементФормы.ГоризонтальноеПоложениеВГруппе = ГоризонтальноеПоложениеЭлемента[Свойства.ГоризонтальноеПоложение];
		Иначе
			ЭлементФормы.ГоризонтальноеПоложение = ГоризонтальноеПоложениеЭлемента[Свойства.ГоризонтальноеПоложение];
		КонецЕсли;
	КонецЕсли;   

	Если Свойства.Свойство("ПоложениеЗаголовка") Тогда
		ЭлементФормы.ПоложениеЗаголовка = ПоложениеЗаголовкаЭлементаФормы[Свойства.ПоложениеЗаголовка];
	КонецЕсли;        

	Если Свойства.Свойство("ЦветФона") Тогда
		ЭлементФормы.ЦветФона = WebЦвета[Свойства.ЦветФона];
	КонецЕсли;        

	Если Свойства.Свойство("ЦветТекста") Тогда        
		Если Тип = "Флажок" Тогда
			ЭлементФормы.ЦветТекстаЗаголовка = WebЦвета[Свойства.ЦветТекста];
		Иначе
			ЭлементФормы.ЦветТекста = WebЦвета[Свойства.ЦветТекста];
		КонецЕсли;
	КонецЕсли;	  
	
	Если Свойства.Свойство("ВидФлажка") Тогда        
		ЭлементФормы.ВидФлажка = ВидФлажка[Свойства.ВидФлажка];
	КонецЕсли;	  
	
	Если Свойства.Свойство("КнопкаПоУмолчанию") Тогда        
		ЭлементФормы.КнопкаПоУмолчанию = Булево(Свойства.КнопкаПоУмолчанию);
	КонецЕсли;	 	
 	
	Если Свойства.Свойство("ПоложениеКартинки") И Тип <> "Меню" Тогда        
		ЭлементФормы.ПоложениеКартинки = ПоложениеКартинкиКнопкиФормы[Свойства.ПоложениеКартинки];
	КонецЕсли;	 

	УстановитьСвойствоЭлементаМодификаторПоляВводаНаСервере(Свойства, ЭлементФормы);

	Если Свойства.Свойство("МногострочныйРежим") Тогда        
		ЭлементФормы.МногострочныйРежим = Булево(Свойства.МногострочныйРежим);
	КонецЕсли;	 	

	Если Свойства.Свойство("Высота") Тогда        
		ЭлементФормы.Высота = Свойства.Высота; 
		ЭлементФормы.РастягиватьПоВертикали = Ложь;
	КонецЕсли;	 	
КонецПроцедуры

&НаСервере
Процедура УстановитьСвойствоЭлементаМодификаторПоляВводаНаСервере(Свойства, ЭлементФормы)
	
	Если Свойства.Свойство("КнопкаВыпадающегоСписка") Тогда        
		ЭлементФормы.КнопкаВыпадающегоСписка = Булево(Свойства.КнопкаВыпадающегоСписка);
	КонецЕсли;	 	
	
	Если Свойства.Свойство("КнопкаВыбора") Тогда        
		ЭлементФормы.КнопкаВыбора = Булево(Свойства.КнопкаВыбора);
	КонецЕсли;	 	
	
	Если Свойства.Свойство("КнопкаОчистки") Тогда        
		ЭлементФормы.КнопкаОчистки = Булево(Свойства.КнопкаОчистки);
	КонецЕсли;	 	
	
	Если Свойства.Свойство("КнопкаРегулирования") Тогда        
		ЭлементФормы.КнопкаРегулирования = Булево(Свойства.КнопкаРегулирования);
	КонецЕсли;	 	
	
	Если Свойства.Свойство("КнопкаОткрытия") Тогда        
		ЭлементФормы.КнопкаОткрытия = Булево(Свойства.КнопкаОткрытия);
	КонецЕсли;

КонецПроцедуры

&НаСервере
Функция ПолучитьСтрокуТаблицыРеквизитовНаСервере(ОписанияРеквизитов, УИД)
	Результат = Новый Структура("ИмяРеквизита,ИмяЭлемента");

	ТекущееОписание = Неопределено;
	Для Каждого Описание Из ОписанияРеквизитов Цикл
		Если Описание.УИД <> УИД Тогда
			Продолжить;
		КонецЕсли;
		
		ТекущееОписание = Описание;
		Прервать;
	КонецЦикла;
	Результат.ИмяРеквизита = ТекущееОписание.ИмяРеквизита;
	Результат.ИмяЭлемента = ТекущееОписание.ИмяЭлемента;
	
	Если ТекущееОписание.Номер > 1 Тогда
		СтрокаНомер = Формат(ТекущееОписание.Номер - 1, "ЧГ=0");
		Результат.ИмяРеквизита = Результат.ИмяРеквизита + СтрокаНомер;
		Результат.ИмяЭлемента = Результат.ИмяЭлемента + СтрокаНомер;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти 

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли
