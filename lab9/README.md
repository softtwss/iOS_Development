# Lab 9 — My Favorite K-Dramas

## Description

This iOS application displays a collection of my 20 favorite Korean dramas using Swift, UIKit, and UITableView.

Each drama has a poster, title, genre, and personal rating out of five stars. The application uses a custom UITableViewCell and SF Symbols to display ratings, including half stars.

## Screenshots

| iPhone SE (3rd generation) | iPhone 16 Pro Max |
|---|---|
| <img src="screenshot/iPhone 16 Pro Max.png" width="260"> | <img src="screenshot/iPhone 16 Pro Max.png.png" width="260"> |

## Project Structure

- **FavoriteItem** — stores the title, subtitle, image name, and rating.
- **FavoritesLibrary** — contains the list of 20 favorite Korean dramas.
- **FavoriteCell** — a custom UITableViewCell that displays drama information.
- **ViewController** — manages the UITableView and its data source.

## Interface

The user interface is designed in Main.storyboard using Auto Layout.

The custom cells display drama posters, titles, genres, and star ratings. Stack Views are used to organize the content.

## How to Run

Open `FavoritesList.xcodeproj` in Xcode, select an iPhone simulator, and press `Cmd + R`.

## Screen Recording

[Watch the scrolling demonstration](recording/Simulator Screen Recording - iPhone 16 Pro Max - 2026-11-06.mov)

## Note

All drama posters are used for educational purposes only.
