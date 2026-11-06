//
//  ViewController.swift
//  FavoritesList
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet private weak var tableView: UITableView!

    
    private let cellIdentifier = "FavoriteCell"

    private let items = FavoritesLibrary.kdramas

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                       for: indexPath) as? FavoriteCell else {
            fatalError("Не удалось создать FavoriteCell: проверь Class и Identifier у прототипа ячейки")
        }
        cell.configure(with: items[indexPath.row])
        return cell
    }
}
