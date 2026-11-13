import UIKit
class ViewController: UIViewController, UITableViewDataSource {
    @IBOutlet private weak var tableView: UITableView!

    private let cellIdentifier = "FavoriteCell"
    private let detailSegueIdentifier = "showDetail"
    private let items = FavoritesLibrary.movies

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        guard segue.identifier == detailSegueIdentifier,
              let detailViewController = segue.destination as? DetailViewController,
              let selectedIndexPath = tableView.indexPathForSelectedRow else {
            return
        }

        detailViewController.item = items[selectedIndexPath.row]
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FavoriteCell else {
            fatalError("Не удалось создать FavoriteCell: проверь Class и Identifier у прототипа ячейки")
        }

        cell.configure(with: items[indexPath.row])
        return cell
    }
}
