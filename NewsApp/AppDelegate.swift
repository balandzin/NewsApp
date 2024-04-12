//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Антон Баландин on 21.03.24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window {
            let tabBarController = TabBarController()
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        }
        return true
    }
}
