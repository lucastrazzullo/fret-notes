//
//  SceneDelegate.swift
//  Fret Notes
//
//  Created by luca strazzullo on 15/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private let application = Application()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            application.active()

            let contentView = ChallengeView(challenge: application.challenge)
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }


    func sceneDidEnterBackground(_ scene: UIScene) {
        application.unactive()
    }


    func sceneWillEnterForeground(_ scene: UIScene) {
        application.active()
    }
}
