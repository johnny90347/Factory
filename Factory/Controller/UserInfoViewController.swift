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
    
    var userEmail:String = ""
    var loginSuccess:Bool = false
    var userName:String = ""
    var department:String = ""
    var position:String = ""
    
    
    
    @IBOutlet weak var accountTextFiled: UITextField!
    
    @IBOutlet weak var passwordTextFiled: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var longOutButton: UIButton!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
        


    //MARK: - 使用按鈕的互動方法
    
    //TODO:  登入的方法
    @IBAction func loginButtomPress(_ sender: UIButton) {
        
        Auth.auth().signIn(withEmail: accountTextFiled.text!, password: passwordTextFiled.text!) { (authResult, error) in
            if error != nil{
                print("登入失敗")
                self.showAlert(withTitle: "登入失敗", withMessage: "請重新輸入")
            }else{
                if let email =  Auth.auth().currentUser?.email{
                    self.userEmail = email
                    
                    let staff = Staff()
                    let person = staff.staffs[email]!
                    self.userName = person[0]
                    self.department = person[1]
                    self.position = person [2]
                }
                self.showAlert(withTitle: "登入成功", withMessage: "您好\(self.position)")
                self.hiddenComponent()

            }
        }

    }
    
    //TODO: 登出的方法
    @IBAction func longoutButtonPress(_ sender: UIButton) {
        
        do{
            try Auth.auth().signOut()
                print("登出成功")
                showComponent()
                self.userName = ""
        }catch{
            print("登出失敗")
        }
    }
    
    
    
    //TODO: 隱藏登入元件＆顯示登出元件 的方法
    func hiddenComponent(){
        
        self.loginSuccess = true
        self.accountTextFiled.isHidden = true  //隱藏帳號欄
        self.passwordTextFiled.isHidden = true //隱藏密碼欄
        self.loginButton.isHidden = true //隱藏登入鍵
        self.longOutButton.isHidden = false //顯示登出鍵
        self.statusLabel.isHidden = false //顯示狀態列
        self.accountTextFiled.text = ""
        self.passwordTextFiled.text = ""
        self.statusLabel.text = "您好！\(userName) \(position)"
        
    }
    
    //TODO:顯示登入元件＆隱藏登出元件 的方法
    func showComponent(){
        self.loginSuccess = false
        self.accountTextFiled.isHidden = false  //顯示帳號欄
        self.passwordTextFiled.isHidden = false //顯示密碼欄
        self.loginButton.isHidden = false //顯示登入鍵
        self.longOutButton.isHidden = true //隱藏登出鍵
        self.statusLabel.isHidden = true //隱藏狀態列
        self.accountTextFiled.becomeFirstResponder()
        
        
        
    }
    
    //TODO:警告控制器的方法
    func showAlert(withTitle title:String, withMessage message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.accountTextFiled.text = ""
            self.passwordTextFiled.text = ""
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
}
