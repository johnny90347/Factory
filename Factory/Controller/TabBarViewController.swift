//
//  TabBarViewController.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/6/26.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController ,UITabBarControllerDelegate{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
    }
    
        //MARK: - TabBarController Delegate
        
        func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
           
        }
        
        //MARK: - 方法
        
        //MARK: 未登入狀態時跳出警告的方法
        //FIXME: 要改寫成一個控制器就好
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
            let alert = UIAlertController(title: "歡迎進入工廠系統", message: "", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "進入畫面", style: .default, handler: nil)
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
            
         
            
        }
        
        
        
        


}
