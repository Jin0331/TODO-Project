//
//  AppDelegate.swift
//  TODO-Project
//
//  Created by JinwooLee on 2/14/24.
//

import UIKit
import IQKeyboardManagerSwift
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.resignOnTouchOutside = true
        
        print("Realm Location : \(Realm.Configuration.defaultConfiguration.fileURL!)")
        print("Realm Schema version : \(Realm.Configuration.defaultConfiguration.schemaVersion)")
        
        //MARK: - realm schema update
        let configuration = Realm.Configuration(schemaVersion: 1) { migration, oldSchemeVersion in
            
            // TaskGroup : type -> listType
            if oldSchemeVersion < 1 {
                print("Schema : 0 -> 1")
                migration.renameProperty(onType: TaskGroup.className(), from: "type", to: "listType")
                
            }
            
        }
        
        Realm.Configuration.defaultConfiguration = configuration
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

