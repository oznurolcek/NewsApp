//
//  SceneDelegate.swift
//  NewsApp
//
//  Created by Öznur Ölçek on 5.09.2023.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let storyboard: UIStoryboard
        let vc: UIViewController
        
        if (UserDefaults.standard.value(forKey: "openedApp") as? Bool) == nil {
            storyboard = UIStoryboard(name: "OnboardingPage", bundle: nil)
            vc = (storyboard.instantiateViewController(withIdentifier: "OnboardingPage") as? OnboardingPage)!
        } else {
            let currentUser = Auth.auth().currentUser
            if currentUser != nil {
                storyboard = UIStoryboard(name: "NewsPage", bundle: nil)
                vc = (storyboard.instantiateViewController(withIdentifier: "CustomTabBarController") as? CustomTabBarController)!
            } else {
                storyboard = UIStoryboard(name: "LoginPage", bundle: nil)
                vc = (storyboard.instantiateViewController(withIdentifier: "LoginPage") as? LoginPage)!
            }
            
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

