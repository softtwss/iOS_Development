# Favorite Movies

UIKit-приложение со списком моих 20 любимых фильмов в `UITableView` с собственной ячейкой: постер, название, режиссёр и год, рейтинг из 5 звёзд (SF Symbols, с половинками).

## Скриншоты

| iPhone SE (3rd generation) | iPhone 16 Pro Max |
|---|---|
| <img src="screenshots/iphone-se.png" width="260"> | <img src="screenshots/iphone-16-pro-max.png" width="260"> |

## Как устроено

- `FavoriteItem` — структура фильма: `title`, `subtitle`, `imageName`, `rating` (0–5 с шагом 0.5).
- `FavoritesLibrary` — массив из 20 фильмов в одном месте.
- `FavoriteCell` — подкласс `UITableViewCell`: только `@IBOutlet` из storyboard и метод `configure(with:)`, который заново заполняет все поля при каждом переиспользовании ячейки.
- `ViewController` — реализует `UITableViewDataSource`: одна строка на элемент, ячейки создаются через `dequeueReusableCell(withIdentifier:for:)` с идентификатором `FavoriteCell`.

## Вёрстка

Вся вёрстка в `Main.storyboard`, кода вёрстки нет.

- `UITableView` занимает весь Safe Area.
- Прототип ячейки: класс `FavoriteCell`, identifier `FavoriteCell`.
- Внутри ячейки: `Outer Stack` (горизонтальный) с постером 60×90 слева и `Info Stack` (вертикальный) справа: название, подзаголовок и `Rating Stack` из 5 звёзд.
- Constraints только у постера (ширина и высота) и у `Outer Stack` (прикреплён к краям content view), поэтому высота строки подстраивается под содержимое, а длинные названия переносятся.

## Запуск

Открыть `FavoritesList.xcodeproj` в Xcode, выбрать симулятор iPhone и нажать Cmd+R. Дополнительная настройка не нужна.

Постеры фильмов принадлежат их правообладателям и используются только в учебных целях.
## Запись экрана

[Прокрутка всего списка (scroll-demo.mp4)](recording/scroll-demo.mp4)
