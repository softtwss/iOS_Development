//
//  Favorites_rouletteApp.swift
//  Favorites roulette
//
//  Created by Asiya Kenesbay on 16.10.2026.
//

import SwiftUI
import UIKit

@main
struct Favorites_rouletteApp: App {
    var body: some Scene {
        WindowGroup {
            StoryboardView()
                .ignoresSafeArea()
        }
    }
}

struct StoryboardView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        return storyboard.instantiateInitialViewController()
            ?? UIViewController()
    }

    func updateUIViewController(
        _ uiViewController: UIViewController,
        context: Context
    ) {
    }
}
