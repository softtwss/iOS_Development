import UIKit
class FavoriteCell: UITableViewCell {
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    func configure(with item: FavoriteItem) {
        titleLabel.text = item.title
        posterImageView.image = UIImage(named: item.imageName) ?? UIImage(systemName: "kdrama")
    }
}
