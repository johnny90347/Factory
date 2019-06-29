//
//  FactoryViewController.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/6/26.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class FactoryViewController: UIViewController {
    

    
    @IBOutlet weak var nameLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        //確認是否在登陸狀態
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                print("有在登入狀態")
            }else{
                print("沒有在登入狀態")
                self.LoginAlert ()
            }
        }
        
    }
    
    
    func LoginAlert (){
        
        let alert = UIAlertController(title: "請登入帳號", message: "按下ok進入登入頁面", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "登入", style: .default) { (action) in
           self.tabBarController?.selectedIndex = 2
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
        
    }
    



}
