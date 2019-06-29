//
//  UserInfoViewController.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/6/26.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit
import Firebase

class UserInfoViewController: UIViewController {
    
    
    var userInfomation:UserInfo?
    
    
    
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
    
    
    

    
  
        


    //MARK: -
    
    //TODO:  登入的方法
    @IBAction func loginButtomPress(_ sender: UIButton) {
        //登入
        Auth.auth().signIn(withEmail: accountTextFiled.text!, password: passwordTextFiled.text!) { (data, error) in
            if error == nil {

                self.getUserInfo()                  //先取的資訊
                let alert = UIAlertController(title: "登入成功", message: "", preferredStyle: .alert)
                let action = UIAlertAction(title: "確認", style: .default, handler: { (action) in
                    DispatchQueue.main.async {
                        self.LoginUIConfigure()     //再顯示資訊 （不然會出錯）
                    }
                    
                })
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil)

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
            showAlert(withTitle: "您已經登出")
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
        
        guard let userID = Auth.auth().currentUser?.uid else {return}
        
        Firestore.firestore().collection("users").document(userID).getDocument { (snapShot, error) in
            if error != nil{
                self.showAlert(withTitle: "請稍後再試")
                return
            }
            guard let snapShot = snapShot else {return}
            guard let data = snapShot.data() else {return}
            let username = data["userName"] as? String ?? "沒有資料"
            let sex = data["sex"] as? String ?? "沒有資料"
            let department = data["department"] as? String ?? "沒有資料"
            let positionTxt = data["positionTxt"] as? String ?? "沒有資料"
            let level = data["level"] as? Int ?? 0
            let createdTime = data["createdTime"] as! Timestamp
            
            let userInfo = UserInfo(userName: username, sex: sex, department: department, positionTxt: positionTxt, level: level, createdTime: createdTime)
            self.userInfomation = userInfo
        }
        
    }
    
    
    //TODO: 未登入狀態介面設定
    func LoginUIConfigure(){
        
        guard let username = userInfomation?.userName else {return}
        guard let department = userInfomation?.department else {return}
        guard let position = userInfomation?.positionTxt else {return}
        
        UIView.animate(withDuration: 1) {   //往上飄 變透明
            self.viewConstraint.constant = 0
            self.topAnimateView.alpha = 0
            self.loginButton.alpha = 0
            self.createdUserButton.alpha = 0
            self.longOutButton.alpha = 1
            self.topLabelOne.text = "歡迎您登入系統\n\n\(username)\n\n\(department)\n\n\(position)"
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
    func showAlert(withTitle title:String){
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
}
