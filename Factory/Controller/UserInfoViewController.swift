//
//  UserInfoViewController.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/6/26.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class UserInfoViewController: UIViewController,UITextFieldDelegate{
    
    
    var userInfomation:UserInfo?
    var listener:AuthStateDidChangeListenerHandle!
    
    
    @IBOutlet weak var accountTextFiled: UITextField!
    
    @IBOutlet weak var passwordTextFiled: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var longOutButton: UIButton!
    
    @IBOutlet weak var viewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topAnimateView: UIView!
    
    @IBOutlet weak var topLabelOne: UILabel!
    
    @IBOutlet weak var createdUserButton: UIButton!
    
    @IBOutlet weak var bgImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

  
    }
    

    //按空白處 收鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
      
        //確認是否在登入狀態
       listener = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                    self.getUserInfo()
            }else{
               
            }
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(listener)
    }
    
    
    
    //按下鍵盤return 收鍵盤
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    //MARK: -
    
    //TODO:  登入的按鈕
    @IBAction func loginButtomPress(_ sender: UIButton) {
        
        //登入
        Auth.auth().signIn(withEmail: accountTextFiled.text!, password: passwordTextFiled.text!) {[weak self] (data, error) in
            guard let self = self else {return}
            if error == nil {
                self.getUserInfo()                  //取得用戶資訊
            }else{
                self.showAlert(withTitle: "錯誤的帳號密碼")
                return
            }
            
        }
        
        
        
        //        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 5.0, options: .curveEaseIn, animations: {
        //            self.viewConstraint.constant = 0
        //            self.view.layoutIfNeeded()
        //        }, completion: nil)
        
        
    }
    
    //TODO: 登出的方法
    @IBAction func longoutButtonPress(_ sender: UIButton) {
        do{
            try Auth.auth().signOut()
        }catch{
            showAlert(withTitle: "登出失敗")
            return
        }
        
        noLoginUIConfigure()           //轉換成未登入介面        
        userInfomation = nil          //把登入者資訊拿掉
        accountTextFiled.text = ""    //帳號密碼欄清空
        passwordTextFiled.text = ""
        
    }
    
    
    
    //MARK:-
    //TODO:取得使用者資料的方法
    // 取得使用者資料
    func getUserInfo(){
        SVProgressHUD.show()
        
        guard let userID = Auth.auth().currentUser?.uid else {return}
        
        Firestore.firestore().collection("users").document(userID).getDocument {
            [weak self](snapShot, error) in
            guard let self = self else{return}
            if error != nil{
                self.showAlert(withTitle: "請稍後再試")
                return
            }
            
            
            guard let snapShot = snapShot,
            let data = snapShot.data(),
            let username = data["userName"] as? String,
            let sex = data["sex"] as? String,
            let department = data["department"] as? String,
            let positionTxt = data["positionTxt"] as? String,
            let level = data["level"] as? Int,
            let createdTime = data["createdTime"] as? Timestamp
            else {return}
            
            let userInfo = UserInfo(userName: username, sex: sex, department: department, positionTxt: positionTxt, level: level, createdTime: createdTime)
            self.userInfomation = userInfo
            self.LoginUIConfigure()     //再顯示資訊 （不然會出錯）
            
        }
        
    }
    
    
    //TODO: 未登入狀態介面設定
    func LoginUIConfigure(){
        
        SVProgressHUD.dismiss()
        
        UIView.animate(withDuration: 1) {   //往上飄 變透明
            self.viewConstraint.constant = 0
            self.topAnimateView.alpha = 0
            self.loginButton.alpha = 0
            self.createdUserButton.alpha = 0
            self.longOutButton.alpha = 1
            
            self.view.layoutIfNeeded()
        }
        guard let userInfo = userInfomation else { return }
        let username = userInfo.userName
        let department = userInfo.department
        let position = userInfo.positionTxt
        
        self.topLabelOne.text = "歡迎您登入系統\n\n\(username)\n\n\(department)\n\n\(position)"
        
    }
    
    //TODO: 未登入狀態的介面設定
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
    func showAlert(withTitle title:String){
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        SVProgressHUD.dismiss()
    }
    
    
}
