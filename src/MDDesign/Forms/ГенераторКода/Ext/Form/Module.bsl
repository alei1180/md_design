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
Функция Получить(Данные) Экспорт
	МассивТекст = Новый Массив;
	
	ТекстОписаниеРеквизитов = ПолучитьОписаниеРеквизитов(Данные.Реквизиты);
	Если НЕ ПустаяСтрока(ТекстОписаниеРеквизитов) Тогда
		МассивТекст.Добавить(ТекстОписаниеРеквизитов);
	КонецЕсли;

	ТекстОписаниеЭлемент = ПолучитьОписаниеЭлементов(Данные.Элементы);
	Если НЕ ПустаяСтрока(ТекстОписаниеЭлемент) Тогда
		МассивТекст.Добавить(ТекстОписаниеЭлемент);
	КонецЕсли;
	
	Возврат СтрСоединить(МассивТекст, Символы.ПС + Символы.ПС);
КонецФункции

#КонецОбласти 

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Функция СлужебныеФункции()
	Возврат ВладелецФормы.СлужебныеФункции();
КонецФункции

&НаКлиенте
Функция ПолучитьОписаниеРеквизитов(МассивРеквизиты)
	Если МассивРеквизиты.Количество() = 0 Тогда
		Возврат "";;
	КонецЕсли;
	
	Результат = Новый Массив;
	
	Результат.Добавить(
		"// Реквизиты
		|
		|ДобавляемыеРеквизиты = Новый Массив;
		|");
	
	Для Каждого Реквизит Из МассивРеквизиты Цикл
		Результат.Добавить(ПолучитьСтрокуРеквизит(Реквизит));
	КонецЦикла;
	
	Результат.Добавить(
		"
		|ИзменитьРеквизиты(ДобавляемыеРеквизиты);");
	
	Возврат СтрСоединить(Результат, Символы.ПС);
КонецФункции

&НаКлиенте
Функция ПолучитьСтрокуРеквизит(СтрокаРеквизит)
	Шаблон = 
		"ДобавляемыеРеквизиты.Добавить(Новый РеквизитФормы(""%1"", %2));";

	СтрокаОписаниеТипов = ПолучитьСтрокуОписаниеТипов(СтрокаРеквизит);
	
	МассивПараметры = Новый Массив;  
	МассивПараметры.Добавить(СтрокаОписаниеТипов);
	Если СтрокаРеквизит.ИмяВладельца <> Неопределено Тогда
		МассивПараметры.Добавить(СтрШаблон("""%1""", СтрокаРеквизит.ИмяВладельца));
	КонецЕсли;
	СтрокаПараметры = СтрСоединить(МассивПараметры, ", ");
	
	Результат = СтрШаблон(Шаблон, СтрокаРеквизит.Имя, СтрокаПараметры);
	Возврат Результат;
КонецФункции

&НаКлиенте
Функция ПолучитьСтрокуОписаниеТипов(СтрокаРеквизит)
	Шаблон = 
		"Новый ОписаниеТипов(%1)";
	
	СоотвОписаниеТипов = СтрокаРеквизит.ОписаниеТипов;
		
	КвалификаторыЧисла = СлужебныеФункции().ПолучитьПредставлениеТипаЧисла(СоотвОписаниеТипов, "Новый КвалификаторыЧисла", Ложь);
	КвалификаторыСтроки = СлужебныеФункции().ПолучитьПредставлениеТипаСтроки(СоотвОписаниеТипов, "Новый КвалификаторыСтроки", Ложь);
	КвалификаторыДаты = СлужебныеФункции().ПолучитьПредставлениеТипаДаты(СоотвОписаниеТипов, "Новый КвалификаторыДаты", Ложь);  
	
	МассивПараметры = Новый Массив;  
	МассивПараметры.Добавить("""" + СтрСоединить(СоотвОписаниеТипов.Типы,",") + """");   
	
	Если КвалификаторыЧисла <> Неопределено Тогда
		МассивПараметры.Вставить(1, КвалификаторыЧисла); 
	КонецЕсли;
	
	Если КвалификаторыСтроки <> Неопределено Тогда
		МассивПараметры.Вставить(2, КвалификаторыСтроки); 
	КонецЕсли;
	
	Если КвалификаторыДаты <> Неопределено Тогда
		МассивПараметры.Вставить(3, КвалификаторыДаты); 
	КонецЕсли;

	СтрокаПараметры = СтрСоединить(МассивПараметры, ", ");
	
	
	Возврат СтрШаблон(Шаблон, СтрокаПараметры);
КонецФункции

&НаКлиенте
Функция ПолучитьОписаниеЭлементов(МассивЭлементы)
	Если МассивЭлементы.Количество() = 0 Тогда
		Возврат "";;
	КонецЕсли;
	
	Результат = Новый Массив;
	
	Результат.Добавить(
		"// Элементы");
	
	Для Каждого ЭлементФормы Из МассивЭлементы Цикл
		Результат.Добавить(ПолучитьСтрокуЭлемент(ЭлементФормы));
	КонецЦикла;
	
	Возврат СтрСоединить(Результат, Символы.ПС + Символы.ПС);
КонецФункции

&НаКлиенте
Функция ПолучитьСтрокуЭлемент(СтрокаЭлемент)
	Шаблон = 
		"Элемент_%1 = Элементы.Добавить(""%1"", %2);";

	ШаблонСвойства = 
		"Элемент_%1.%2 = %3;";
		
	МассивПараметры = Новый Массив;  
	МассивПараметры.Добавить(СтрШаблон("Тип(""%1"")", СтрокаЭлемент.Тип));
	Если СтрокаЭлемент.ИмяРодителя <> Неопределено Тогда
		МассивПараметры.Добавить(СтрШаблон("Элемент_%1", СтрокаЭлемент.ИмяРодителя));
	КонецЕсли;
	СтрокаПараметры = СтрСоединить(МассивПараметры, ", ");
	
	
	МассивРезультат = Новый Массив;
	МассивРезультат.Добавить(СтрШаблон(Шаблон, СтрокаЭлемент.Имя, СтрокаПараметры));
	
	Для Каждого КлючЗначение Из СтрокаЭлемент.НаборСвойств Цикл
		ИмяСвойства = КлючЗначение.Ключ;  	
		
		ЗначениеСвойства = ПолучитьЗначениеСвойства(КлючЗначение.Значение);  
		
		РезультатСвойство = СтрШаблон(ШаблонСвойства, СтрокаЭлемент.Имя, ИмяСвойства, ЗначениеСвойства);
		МассивРезультат.Добавить(РезультатСвойство);
	КонецЦикла;
	
	Возврат СтрСоединить(МассивРезультат, Символы.ПС);
КонецФункции

&НаКлиенте
Функция ПолучитьЗначениеСвойства(ЗначениеСвойства)
	Если ЗначениеСвойства.Тип = "Строка" Тогда
		Возврат """" + Строка(ЗначениеСвойства.Значение) + """";
	КонецЕсли;

	Если ЗначениеСвойства.Тип = "Булево" Тогда
		Возврат Формат(ЗначениеСвойства.Значение, "БЛ=Ложь; БИ=Истина");
	КонецЕсли;

	Если ЗначениеСвойства.Тип = "Число" Тогда
		Возврат Строка(ЗначениеСвойства.Значение);
	КонецЕсли;
	
	Возврат ЗначениеСвойства.Тип + "." + ЗначениеСвойства.Значение;
КонецФункции 

#КонецОбласти