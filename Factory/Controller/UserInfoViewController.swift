//
//  UserInfoViewController.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/6/26.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit
import FirebaseAuth

class UserInfoViewController: UIViewController {
    

    var loginSuccess:Bool = false

    
    
    
    @IBOutlet weak var accountTextFiled: UITextField!
    
    @IBOutlet weak var passwordTextFiled: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var longOutButton: UIButton!
    
    @IBOutlet weak var viewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topAnimateView: UIView!
    
    @IBOutlet weak var topLabelOne: UILabel!
    
    @IBOutlet weak var createdUserButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
     
        
    }
        


    //MARK: - 使用按鈕的互動方法
    
    //TODO:  登入的方法
    @IBAction func loginButtomPress(_ sender: UIButton) {
        LoginUIConfigure()
//        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 5.0, options: .curveEaseIn, animations: {
//            self.viewConstraint.constant = 0
//            self.view.layoutIfNeeded()
//        }, completion: nil)
        

    }
    
    //TODO: 登出的方法
    @IBAction func longoutButtonPress(_ sender: UIButton) {
       noLoginUIConfigure()
        
    }
    
    
    
    //TODO: 未登入狀態介面設定
    func LoginUIConfigure(){
        
        UIView.animate(withDuration: 1) {   //往上飄 變透明
            self.viewConstraint.constant = 0
            self.topAnimateView.alpha = 0
            self.loginButton.alpha = 0
            self.createdUserButton.alpha = 0
            self.longOutButton.alpha = 1
            self.topLabelOne.text = "歡迎您登入系統\n\n梁鑫文\n\n經理"
            self.view.layoutIfNeeded()
        }
    }
    
    //TODO: 登入狀態的介面設定
    func noLoginUIConfigure(){
        UIView.animate(withDuration: 1) {   //往上飄 變透明
            self.viewConstraint.constant = 138
            self.topAnimateView.alpha = 1
            self.loginButton.alpha = 1
            self.createdUserButton.alpha = 1
            self.longOutButton.alpha = 0
            self.topLabelOne.text = "請輸入您的帳號"
            self.view.layoutIfNeeded()
        }
        
    }
    
    //TODO:警告控制器的方法
    func showAlert(withTitle title:String, withMessage message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
}
