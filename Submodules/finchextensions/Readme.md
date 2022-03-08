# ⚜️ Finch Extensions

Расширения для решения общих задач при разработке под iOS

## 🛠 Установка

Встраивается в проект приложения как submodule

[Как добавить submodule в проект](https://www.notion.so/finchmoscow/submodule-98e7f8b8ed0542949d4c793590ffcc25)

## 📝 Рекомендации
Вложенность должна быть следующая:
Название библиотеки -> Название типа -> НазваниеТипа+ДобавленныйФункционал

Пример: UIKit -> UIView -> UIView+DropShadow.swift

Конвенция название коммитов:
[НазваниеТипа] что было сделано

Пример: [UIView] Add dropShadow method

Если работали над самим проектом в целом:
[Framework] Add Readme file

⚠️ Добавил расширение - добавь описание в readme

## ⚡️ Список расширений

#### CoreGraphics

##### CGFloat
* [[Radians]](https://git.finch.fm/frameworks/finchextensions/blob/master/FinchExtensions/Extensions/CoreGraphics/CGFloat/CGFloat+Radians.swift) Возвращает текущее значение в радианах

#### Swift

##### Collection
* [[SafeSubscript]](https://git.finch.fm/frameworks/finchextensions/blob/master/FinchExtensions/Extensions/Swift/Collection/Collection+SafeSubscript.swift) Безопасно возвращает элемент по указанному индексу

##### Dictionary
* [[StringFromHTTPParameters]](https://git.finch.fm/frameworks/finchextensions/blob/master/FinchExtensions/Extensions/Swift/Dictionary/Dictionary+StringFromHTTPParameters.swift) Конвертирует HTTP параметры в строку
* [[ToString]](https://git.finch.fm/frameworks/finchextensions/blob/master/FinchExtensions/Extensions/Swift/Dictionary/Dictionary+ToString.swift) Конвертирует Dictionary в json подобную строку

#####  String
* [[IsNumeric]](https://git.finch.fm/frameworks/finchextensions/blob/master/FinchExtensions/Extensions/Swift/String/String+IsNumeric.swift) Проверяет является ли текущая строка числом
* [[Localized]](https://git.finch.fm/frameworks/finchextensions/blob/master/FinchExtensions/Extensions/Swift/String/String+Localized.swift) Возврашает локализованную строку
* [[RemoveWhiteSpaces]](https://git.finch.fm/frameworks/finchextensions/blob/master/FinchExtensions/Extensions/Swift/String/String+RemoveWhiteSpaces.swift) Удаляет пробелы в начале и конце строки
* [[Sizes]](https://git.finch.fm/frameworks/finchextensions/blob/master/FinchExtensions/Extensions/Swift/String/String+Sizes.swift) Позволяет вычислять высоту и ширину строки
* [[Substring]](https://git.finch.fm/frameworks/finchextensions/blob/master/FinchExtensions/Extensions/Swift/String/String+Substring.swift) Возвращает строку начиная с переданного индекса. Вырезает переданный диапазон и возвращает строку.

#### UIKit

##### UIApplication
* [[AppVersion]](https://git.finch.fm/frameworks/finchextensions/blob/master/FinchExtensions/Extensions/UIKit/UIApplication/UIApplication+AppVersion.swift) Возвращает версию/build приложения

##### UIColor
* [[Hex]](https://git.finch.fm/frameworks/finchextensions/blob/master/FinchExtensions/Extensions/UIKit/UIColor/UIColor+Hex.swift) Инициализирует UIColor из hex строки
