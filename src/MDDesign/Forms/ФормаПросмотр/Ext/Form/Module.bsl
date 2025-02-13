﻿#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура Построить(ОписаниеГруппы, ОписанияРеквизитов) Экспорт
	ПостроитьНаСервере(ОписаниеГруппы, ОписанияРеквизитов);
	
	
	ЗаголовокФормы = ОписаниеГруппы.НаборСвойств.Заголовок;
	Если ПустаяСтрока(ЗаголовокФормы) Тогда
		ЗаголовокФормы = "Накидка. Прототип формы";
	КонецЕсли;
	
	Заголовок = ЗаголовокФормы;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура __КомандаЗаглушка(Команда)
	Сообщение = Новый СообщениеПользователю;
	Сообщение.Текст = "Заглушка";
	Сообщение.Сообщить();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПостроитьНаСервере(ОписаниеГруппы, ОписанияРеквизитов) Экспорт
	ОбработкаОбъект = РеквизитФормыВЗначение("Объект");
	ОбработкаОбъект.ПостроитьНаСервере(
		ЭтотОбъект, 
		Элементы.__ГруппаПросмотр, 
		ОписаниеГруппы, 
		ОписанияРеквизитов);
КонецПроцедуры

#КонецОбласти