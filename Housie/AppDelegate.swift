//
//  AppDelegate.swift
//  Housie
//
//  Created by Alpay Kücük on 03.08.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var currentUser: User?
    var datamodel = ModelData()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let defaults = UserDefaults.standard
        if defaults.string(forKey: "id") == nil{
            print("New User!")
            defaults.setValue("1", forKey: "id")
            defaults.setValue("0", forKey: "coins")
            defaults.set([String](), forKey: "ownhouses")

            datamodel.mapHousesintoarray()
            AppDelegate.currentUser = User(id: "1", coins: 0)
        } else {
            print("User exists!")
            let id = defaults.string(forKey: "id")
            let coins = defaults.integer(forKey: "coins")
            AppDelegate.currentUser = User(id: id!, coins: coins)
            AppDelegate.currentUser?.listOfUnlockedHouses = defaults.object(forKey:"ownhouses") as? [String] ?? [String]()
            AppDelegate.currentUser?.costsOfUnlockedHouses = defaults.object(forKey:"costsofhouses") as? [Int] ?? [Int]()
            
            mapHousesToIds(houseslist: AppDelegate.currentUser!.listOfUnlockedHouses, pricelist: AppDelegate.currentUser!.costsOfUnlockedHouses)
            
        }
        
        return true
    }
    
    func mapHousesToIds(houseslist: [String], pricelist: [Int]) {
        var index = 0
        for haus in datamodel.houses {
            haus.remainingPrice = pricelist[index]
            haus.unlocked = checkIfUnlocked(houselist: houseslist, currenthaus: haus)
            AppDelegate.currentUser!.listOfHouses.append(haus)
            index+=1
        }
    }
    
    func checkIfUnlocked(houselist: [String], currenthaus: House) -> Bool {
        for haus in houselist {
            if (haus == currenthaus.id) {
                return true
            }
        }
        return false
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

