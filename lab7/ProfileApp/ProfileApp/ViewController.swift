//
//  ViewController.swift
//  ProfileApp
//
//  Created by Asiya Kenesbay on 30.10.2026.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var statsView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let avatar = avatarView {
            avatar.layer.cornerRadius = avatar.bounds.width / 2
            avatar.layer.masksToBounds = true
        }

        if let stats = statsView {
            stats.layer.cornerRadius = 16
            stats.layer.masksToBounds = true
        }
    }
}
