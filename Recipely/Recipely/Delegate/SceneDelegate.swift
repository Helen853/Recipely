// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
//        configureSceneDeklegate(windowScene: windowScene)
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: CategoryViewController())
        window.makeKeyAndVisible()
        self.window = window
    }

//    private func configureSceneDeklegate(windowScene: UIWindowScene) {
//        window = UIWindow(windowScene: windowScene)

//        if let window {
//            window.makeKeyAndVisible()
//            appCoordinator = AppCoordinator()
//            appCoordinator?.start()
//        }
}

// }
