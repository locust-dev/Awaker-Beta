# ⚜️ Finch Lists

Данный сабмодуль направлен на упрощение работы с Collection и TableView списками.
Он содержит решения по инжекту данных в ячейку, FlowLayout и всевозможные расширения/Протоколы.

## 🛠 Установка

Встраивается в проект приложения как submodule

[Как добавить submodule в проект](https://www.notion.so/finchmoscow/submodule-98e7f8b8ed0542949d4c793590ffcc25)

## ⚡️ Список расширений

### Protocols

#### Configurator

[Configurable](https://git.finch.fm/frameworks/finchlists/blob/master/FinchLists/Lists/Common/Configurable.swift)
[CellConfigurator](https://git.finch.fm/frameworks/finchlists/blob/master/FinchLists/Lists/Common/CellConfigurator.swift)
[CollectionCellConfigurator](https://git.finch.fm/frameworks/finchlists/blob/master/FinchLists/Lists/UICollectionView/CollectionCellConfigurator.swift)
[TableCellConfigurator](https://git.finch.fm/frameworks/finchlists/blob/master/FinchLists/Lists/UITableVIew/TableCellConfigurator.swift)

Данный подход используется для инжекта данных в ячейку с помощью viewModel и конфигуратора в ней.
Рекомендуется к использованию ⚠️

#### Delegatable 

[Delegatable](https://git.finch.fm/frameworks/finchlists/blob/master/FinchLists/Lists/Common/Delegatable.swift) - Протокол для ячейки, благодаря которому можно заинжектить делегата.
Не рекомендуется использовать см. Configurator

#### Setupable

[Setupable](https://git.finch.fm/frameworks/finchlists/blob/master/FinchLists/Lists/Common/Setupable.swift) - Иногда нужно сделать что-то быстро и не очень аккуратно, для этого есть данный протокол.
Данный протокол должна имплементировать ячейка, а метод setup вызываться из вне.

### Flow Layout 

#### SJCenterFlowLayout.

[Source](https://github.com/yudiz-solutions/SJCenterFlowLayout)
[SJCenterFlowLayout.](https://git.finch.fm/frameworks/finchlists/blob/master/FinchLists/Lists/UICollectionView/FlowLayouts/SJCenterFlowLayout.swift) - Данный флоу может использоваться для ячеек с пагинацией как по центру, так и нет. Имеет возможность в изменении scale для "не выбранных" ячеек.