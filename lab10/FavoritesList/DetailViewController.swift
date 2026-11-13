import UIKit
class DetailViewController: UIViewController {
    var item: FavoriteItem?

    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var star1ImageView: UIImageView!
    @IBOutlet private weak var star2ImageView: UIImageView!
    @IBOutlet private weak var star3ImageView: UIImageView!
    @IBOutlet private weak var star4ImageView: UIImageView!
    @IBOutlet private weak var star5ImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let item else { return }

        title = item.title

        posterImageView.image = UIImage(named: item.imageName) ?? UIImage(systemName: "kdrama")
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        descriptionLabel.text = item.description
        showRating(item.rating)
    }

    private func showRating(_ rating: Double) {
        let stars: [UIImageView] = [star1ImageView, star2ImageView, star3ImageView, star4ImageView, star5ImageView]

        for (index, star) in stars.enumerated() {
            let position = Double(index)
            let symbol: String

            if rating >= position + 1 {
                symbol = "star.fill"
            } else if rating >= position + 0.5 {
                symbol = "star.leadinghalf.filled"
            } else {
                symbol = "star"
            }

            star.image = UIImage(systemName: symbol)
        }
    }
}
