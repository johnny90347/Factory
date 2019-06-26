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
    
    var userName:String = ""
    var loginSuccess:Bool = false
    
    
    @IBOutlet weak var accountTextFiled: UITextField!
    
    @IBOutlet weak var passwordTextFiled: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var longOutButton: UIButton!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
        


    
    @IBAction func loginButtomPress(_ sender: UIButton) {
        
        Auth.auth().signIn(withEmail: accountTextFiled.text!, password: passwordTextFiled.text!) { (authResult, error) in
            if error != nil{
                print("登入失敗")
                self.showAlert()
            }else{
                if let email =  Auth.auth().currentUser?.email{
                    self.userName = email
                }
                print("登入成功")
                self.hiddenComponent()

            }
        }

    }
    
    
    @IBAction func longoutButtonPress(_ sender: UIButton) {
        
        do{
            try Auth.auth().signOut()
                print("登出成功")
                showComponent()
            
            
        }catch{
            print("登出失敗")
        }
        
    }
    
    
    
    
    func hiddenComponent(){
        
        self.loginSuccess = true
        self.accountTextFiled.isHidden = true  //隱藏帳號欄
        self.passwordTextFiled.isHidden = true //隱藏密碼欄
        self.loginButton.isHidden = true //隱藏登入鍵
        self.longOutButton.isHidden = false //顯示登出鍵
        self.statusLabel.isHidden = false //顯示狀態列
        self.accountTextFiled.text = ""
        self.passwordTextFiled.text = ""
        
    }
    
    
    func showComponent(){
        self.loginSuccess = false
        self.accountTextFiled.isHidden = false  //顯示帳號欄
        self.passwordTextFiled.isHidden = false //顯示密碼欄
        self.loginButton.isHidden = false //顯示登入鍵
        self.longOutButton.isHidden = true //隱藏登出鍵
        self.statusLabel.isHidden = true //隱藏狀態列
        self.accountTextFiled.becomeFirstResponder()
        
        
    }
    
    
    func showAlert(){
        let alert = UIAlertController(title: "帳號或密碼錯誤", message: "請重新輸入", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "重新輸入", style: .default) { (action) in
            self.accountTextFiled.text = ""
            self.passwordTextFiled.text = ""
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
}
