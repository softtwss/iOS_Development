//
//  ViewController.swift
//  Favorites roulette
//
//  Created by Asiya Kenesbay on 16.10.2026.
//

import UIKit

struct Favorite {
    let imageName: String
    let title: String
    let description: String
}

class ViewController: UIViewController {

    @IBOutlet weak var dramaImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    let favorites: [Favorite] = [
        Favorite(
            imageName: "drama1",
            title: "Extraordinary You",
            description: "A girl discovers she is a character in a comic book."
        ),
        Favorite(
            imageName: "drama2",
            title: "Dive Into You",
            description: "A story about love, dreams, and personal growth."
        ),
        Favorite(
            imageName: "drama3",
            title: "Strong Woman Do Bong Soon",
            description: "A girl with superhuman strength falls in love."
        ),
        Favorite(
            imageName: "drama4",
            title: "The Judge from Hell",
            description: "A demon judge punishes criminals."
        ),
        Favorite(
            imageName: "drama5",
            title: "Lovely Runner",
            description: "A girl travels back in time to save her favorite idol."
        ),
        Favorite(
            imageName: "drama6",
            title: "Tomorrow",
            description: "Grim reapers help people who have lost hope."
        ),
        Favorite(
            imageName: "drama7",
            title: "Twinkling Watermelon",
            description: "A boy travels to the past and meets his young parents."
        ),
        Favorite(
            imageName: "drama8",
            title: "See You in My 19th Life",
            description: "A woman remembers all her previous lives."
        ),
        Favorite(
            imageName: "drama9",
            title: "Tale of the Nine Tailed",
            description: "A mythical fox falls in love with a human."
        ),
        Favorite(
            imageName: "drama10",
            title: "The Nanyang Mystery",
            description: "A mysterious story full of secrets and supernatural events."
        )
    ]

    var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        showFavorite(at: currentIndex)
    }

    func showFavorite(at index: Int) {
        let favorite = favorites[index]

        dramaImageView.image = UIImage(named: favorite.imageName)
        titleLabel.text = favorite.title
        descriptionLabel.text = favorite.description
    }

    @IBAction func surpriseButtonTapped(_ sender: UIButton) {
        let availableIndices = favorites.indices.filter {
            $0 != currentIndex
        }

        guard let newIndex = availableIndices.randomElement() else {
            return
        }

        currentIndex = newIndex
        showFavorite(at: currentIndex)
    }
}
