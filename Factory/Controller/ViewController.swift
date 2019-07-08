//
//  ViewController.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/6/26.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ViewController: UIViewController {
    
    
     let openingView = UIView()         //做開場動畫的view
    let openImageVie = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        openingViewConfigure() //開場畫面 
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        openingAnimate()  //開場動畫

        //確認是否在登陸狀態
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                print("有在登入狀態")
            }else{
                print("沒有在登入狀態")
            }
        }
        
    }
    
    
    //MARK:- 開場動畫設置
    
    
    func openingViewConfigure(){
        //一隻藍色的小鳥圖案
        openingView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        openingView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        view.addSubview(openingView)
        
        openImageVie.frame = CGRect(x: 0, y: 0, width: 150 , height: 150)
        openImageVie.image = UIImage(named: "openLogo")
        openImageVie.center = view.center
        openingView.addSubview(openImageVie)
      
    }
    
    
    
    func openingAnimate(){
        //動畫內容：先縮小再放大 ->消失
        UIView.animate(withDuration: 0.3, animations: {
            self.openImageVie.frame = CGRect(x: 0, y: 0, width: 90, height: 90)
            self.openImageVie.center = self.view.center
            
        }) { (finished) in
            
            UIView.animate(withDuration: 0.5, animations: {
                self.openImageVie.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
                self.openImageVie.center = self.view.center
                self.openingView.alpha = 0
                
            })
            
        }
        
    }


}

