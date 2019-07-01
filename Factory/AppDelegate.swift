//
//  AppDelegate.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/6/26.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit
import Firebase


//var userInfomationShare:UserInfo?

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
//        getUserInfo()
        
        return true
    }
//    func getUserInfo(){
//
//        guard let userID = Auth.auth().currentUser?.uid else {return}
//
//        Firestore.firestore().collection("users").document(userID).getDocument { (snapShot, error) in
//            if error != nil{
//
//                return
//            }
//
//
//            guard let snapShot = snapShot,
//                let data = snapShot.data(),
//                let username = data["userName"] as? String,
//                let sex = data["sex"] as? String,
//                let department = data["department"] as? String,
//                let positionTxt = data["positionTxt"] as? String,
//                let level = data["level"] as? Int,
//                let createdTime = data["createdTime"] as? Timestamp
//                else {return}
//
//            let userInfo = UserInfo(userName: username, sex: sex, department: department, positionTxt: positionTxt, level: level, createdTime: createdTime)
//            userInfomationShare = userInfo
//
//        }

//    }
    
    
   
        
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

