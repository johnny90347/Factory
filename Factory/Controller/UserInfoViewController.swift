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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
     
        
    }
        


    //MARK: - 使用按鈕的互動方法
    
    //TODO:  登入的方法
    @IBAction func loginButtomPress(_ sender: UIButton) {
        
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10.0, options: .curveEaseIn, animations: {
            self.viewConstraint.constant = 0
//            self.topAnimateView.alpha = 0
            self.view.layoutIfNeeded()
        }, completion: nil)
        
//        UIView.animate(withDuration: 1) {
//            self.viewConstraint.constant = 170
//            self.view.layoutIfNeeded()
//        }
//
//        UIView.animate(withDuration: 1) {
//            self.viewConstraint.constant = -140
//            self.view.layoutIfNeeded()
//
//        }
    }
    
    //TODO: 登出的方法
    @IBAction func longoutButtonPress(_ sender: UIButton) {
        
       
      
    }
    
    
    
    //TODO: 隱藏登入元件＆顯示登出元件 的方法
    func hiddenComponent(){
        
        self.loginSuccess = true
        self.accountTextFiled.isHidden = true  //隱藏帳號欄
        self.passwordTextFiled.isHidden = true //隱藏密碼欄
        self.loginButton.isHidden = true //隱藏登入鍵
        self.longOutButton.isHidden = false //顯示登出鍵
        self.accountTextFiled.text = ""
        self.passwordTextFiled.text = ""
       
        
    }
    
    //TODO:顯示登入元件＆隱藏登出元件 的方法
    func showComponent(){
        self.loginSuccess = false
        self.accountTextFiled.isHidden = false  //顯示帳號欄
        self.passwordTextFiled.isHidden = false //顯示密碼欄
        self.loginButton.isHidden = false //顯示登入鍵
        self.longOutButton.isHidden = true //隱藏登出鍵
        self.accountTextFiled.becomeFirstResponder()
        
        
        
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
