import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var star1ImageView: UIImageView!
    @IBOutlet private weak var star2ImageView: UIImageView!
    @IBOutlet private weak var star3ImageView: UIImageView!
    @IBOutlet private weak var star4ImageView: UIImageView!
    @IBOutlet private weak var star5ImageView: UIImageView!

    func configure(with item: FavoriteItem) {
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        posterImageView.image = UIImage(named: item.imageName) ?? UIImage(systemName: "kdrama")

        let stars: [UIImageView] = [star1ImageView, star2ImageView, star3ImageView,
                                    star4ImageView, star5ImageView]
        for (index, star) in stars.enumerated() {
            let position = Double(index)
            let symbol: String
            if item.rating >= position + 1 {
                symbol = "star.fill"
            } else if item.rating >= position + 0.5 {
                symbol = "star.leadinghalf.filled"
            } else {
                symbol = "star"
            }
            star.image = UIImage(systemName: symbol)
        }
    }
}
