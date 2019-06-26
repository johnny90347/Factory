//
//  TabBarViewController.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/6/26.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController ,UITabBarControllerDelegate{

    var userName:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
    }
    
        //MARK: - TabBarController Delegate
        
        func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            if viewController == viewControllers?[1]{
                
                let factoryVC = viewControllers?[2] as! UserInfoViewController

                let  name = factoryVC.userName    //抓到使用者名稱
                    
                userName = name

                if factoryVC.userName == "" {  //登入流程控制
                    LoginAlert()
                }else{
                    successLoginAlert()
                }

                
                
                
            }
        }
        
        //MARK: - 方法
        
        //MARK: 未登入狀態時跳出警告的方法
        func LoginAlert (){
            
            let alert = UIAlertController(title: "請登入帳號", message: "按下ok進入登入頁面", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "登入", style: .default) { (action) in
                self.selectedIndex = 2
            }
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
            
        }
        
        //MARK:登入狀態時跳出警告的方法
        func successLoginAlert (){
            let alert = UIAlertController(title: "\(userName) 歡迎回來工廠系統", message: "", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "進入畫面", style: .default, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
            
        }
        
        
        
        


}
