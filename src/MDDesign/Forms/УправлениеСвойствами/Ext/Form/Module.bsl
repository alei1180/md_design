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

#Область ОбработчикиСобытийФормы

&НаКлиенте
Функция ПолучитьВсеСвойства() Экспорт
	Возврат ПолучитьСвойстваНаСервере();
КонецФункции

&НаКлиенте
Процедура ЗаполнитьНеизвестныеСвойства(ДанныеГрупп, ВсеСвойства) Экспорт

	Если ДанныеГрупп.Свойство("НаборСвойств") Тогда
		ЕстьСвойствоПоТипу = ВсеСвойства.Свойство(ДанныеГрупп.Тип);
		Если ЕстьСвойствоПоТипу Тогда
			ВсеСвойстваПоТипу = ВсеСвойства[ДанныеГрупп.Тип];
		КонецЕсли;
		
		Для Каждого КлючЗначение Из ДанныеГрупп.НаборСвойств Цикл 
			ИмяСвойства = КлючЗначение.Ключ;
			ЗначениеСвойства = КлючЗначение.Значение;
			Если НЕ ЕстьСвойствоПоТипу Тогда
				Продолжить;
			КонецЕсли;
			
			Если НЕ ВсеСвойстваПоТипу.Свойство(ИмяСвойства) Тогда
				Продолжить;
			КонецЕсли;
			
			ОписаниеСвойства = ВсеСвойстваПоТипу[ИмяСвойства];
			
			Если НЕ ЭтоКорректноеЗначение(ЗначениеСвойства, ОписаниеСвойства) Тогда
				Продолжить;
			КонецЕсли;
			
			ДанныеГрупп.ТипыСвойств.Вставить(ИмяСвойства, ОписаниеСвойства.ТипЗначения);
		КонецЦикла;	
	КонецЕсли;
	
	МассивИерархий = СтрРазделить("Элементы,Колонки,Ячейки,Строки", ",");
	
	Для Каждого Иерархия Из МассивИерархий Цикл
		Если НЕ ДанныеГрупп.Свойство(Иерархия) Тогда
			Продолжить;
		КонецЕсли;
		
		Для Каждого ОписаниеЭлемента Из ДанныеГрупп[Иерархия] Цикл
			ЗаполнитьНеизвестныеСвойства(ОписаниеЭлемента, ВсеСвойства);
		КонецЦикла;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти 

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Функция ЭтоКорректноеЗначение(Значение, ОписаниеСвойства)
	Если ОписаниеСвойства.ТипЗначения = "Строка" Тогда
		Возврат Истина;
	КонецЕсли;

	Если ОписаниеСвойства.ТипЗначения = "Цвет" Тогда
		Возврат Истина;
	КонецЕсли;
	
	Если ОписаниеСвойства.ТипЗначения = "Число" Тогда
		
		Возврат ЭтоЧисло(Значение);
	КонецЕсли;
	
	Если ОписаниеСвойства.ТипЗначения = "Булево" Тогда
		
		Возврат ЭтоБулево(Значение);
	КонецЕсли;
	
	Возврат ОписаниеСвойства.Значения.Найти(НРег(Значение)) <> Неопределено;
КонецФункции

&НаКлиенте
Функция ЭтоЧисло(Знач Значение) 
	Если Значение = "0" Тогда
		Возврат Истина;
	КонецЕсли;
	
	ОписаниеЧисла = Новый ОписаниеТипов("Число");
	
	Возврат ОписаниеЧисла.ПривестиЗначение(Значение) <> 0;
КонецФункции 

&НаКлиенте
Функция ЭтоБулево(Знач Значение)
	ДопустимыеЗначения = СтрРазделить("да,нет,0,1,истина,ложь", ",");
	
	Возврат ДопустимыеЗначения.Найти(НРег(Значение)) <> Неопределено;
КонецФункции

&НаКлиенте
Функция ПолучитьЭлементПоУИД(ОписаниеЭлементов, УИД) Экспорт
	Если ОписаниеЭлементов.УИД = УИД Тогда
		Возврат ОписаниеЭлементов;
	КонецЕсли;
	
	Если ОписаниеЭлементов.Свойство("Элементы") Тогда
		Для Каждого ОписаниеЭлемента Из ОписаниеЭлементов.Элементы Цикл
			ТекЭлемент = ПолучитьЭлементПоУИД(ОписаниеЭлемента, УИД);
			Если ТекЭлемент <> Неопределено Тогда
				Возврат ТекЭлемент;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Если ОписаниеЭлементов.Свойство("Колонки") Тогда
		Для Каждого ОписаниеЭлемента Из ОписаниеЭлементов.Колонки Цикл
			ТекЭлемент = ПолучитьЭлементПоУИД(ОписаниеЭлемента, УИД);
			Если ТекЭлемент <> Неопределено Тогда
				Возврат ТекЭлемент;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Возврат Неопределено;
КонецФункции

&НаСервере
Функция ПолучитьСвойстваНаСервере()  
	МаксимальноеКоличествоЗначений = 6;
	
	Результат = Новый Структура;
	
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	ТабличныйДокумент = ОбработкаОбъект.ПолучитьМакет("Свойства");

	Построитель = Новый ПостроительЗапроса;
	Построитель.ИсточникДанных = Новый ОписаниеИсточникаДанных(ТабличныйДокумент.Область());  	
	
	ТаблицаЗначений = Построитель.Результат.Выгрузить();	
	
	Для Каждого СтрокаТаблицы Из ТаблицаЗначений Цикл
		Если Результат.Свойство(СтрокаТаблицы.ТипЭлемента) Тогда
			СвойстваПоТипуЭлемента = Результат[СтрокаТаблицы.ТипЭлемента];
		Иначе
			СвойстваПоТипуЭлемента = Новый Структура;
			Результат.Вставить(СтрокаТаблицы.ТипЭлемента, СвойстваПоТипуЭлемента);
		КонецЕсли;
		
		ОписаниеСвойства = Новый Структура("Представление,ТипЗначения,Значения", "", "", Новый Массив);
		
		ЗаполнитьЗначенияСвойств(ОписаниеСвойства, СтрокаТаблицы, "Представление,ТипЗначения");
		
		Для Сч = 1 По МаксимальноеКоличествоЗначений Цикл
			ТекущееЗначение = СтрокаТаблицы["Значение" + Строка(Сч)];
			Если ПустаяСтрока(ТекущееЗначение) Тогда
				Прервать;
			КонецЕсли;
			ОписаниеСвойства.Значения.Добавить(НРег(ТекущееЗначение));
		КонецЦикла;
		
		СвойстваПоТипуЭлемента.Вставить(СтрокаТаблицы.Имя, ОписаниеСвойства); 
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

#КонецОбласти

