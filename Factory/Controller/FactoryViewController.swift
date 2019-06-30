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
    
    
    var userInfo:UserInfo?
    

    
    @IBOutlet weak var leftDoorLeading: NSLayoutConstraint!
    
    @IBOutlet weak var rightDoorTraling: NSLayoutConstraint!
    
    @IBOutlet weak var leftDoorImageView: UIImageView!
    
    @IBOutlet weak var rightDoorImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var greetTextLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        leftDoorImageView.layer.cornerRadius = 10
        rightDoorImageView.layer.cornerRadius = 10
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
     
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //確認是否在登陸狀態
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                print("有在登入狀態")
                self.getUserInfo()
            }else{
                print("沒有在登入狀態")
                self.LoginAlert ()
                self.doorClose()  //離開畫面時門關上
                
            }
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        doorClose()  //離開畫面時門關上
    }
    
    

    
    
    //開啟門 動畫
    func doorOpenAnimete (){
        UIView.animate(withDuration: 1.5) {
            self.leftDoorLeading.constant = -250
            self.rightDoorTraling.constant = 250
            self.leftDoorImageView.alpha = 0
            self.rightDoorImageView.alpha = 0
            self.view.layoutIfNeeded()
        }
    }
    //關閉門
    func doorClose(){
        self.leftDoorLeading.constant = 0
        self.rightDoorTraling.constant = 0
        self.leftDoorImageView.alpha = 1
        self.rightDoorImageView.alpha = 1
    }
    
   
    //未登入警告
    func LoginAlert (){
        
        let alert = UIAlertController(title: "請登入帳號", message: "按下ok進入登入頁面", preferredStyle: .alert)
        let action = UIAlertAction(title: "登入", style: .default) { (action) in
           self.tabBarController?.selectedIndex = 2
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }
    
    
    
    //通用警告
    func commonAlert(withTitle title:String){
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "確認", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //取得使用者資料
    func getUserInfo(){
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(userID).getDocument { (snapshot, error) in
            if error != nil{
                print("取得資料失敗")
                self.commonAlert(withTitle: "網路異常")
                return
            }
            
            guard let data = snapshot?.data(),
            let username = data["userName"] as? String,
            let sex = data["sex"] as? String,
            let department = data["department"] as? String,
            let positionTxt = data["positionTxt"] as? String,
            let level = data["level"] as? Int,
            let createdTime = data["createdTime"] as? Timestamp
            else {return}
            
           self.userInfo = UserInfo(userName: username, sex: sex, department: department, positionTxt: positionTxt, level: level, createdTime: createdTime)
            self.setGreetTxt()
            self.doorOpenAnimete()
            
        
        }
        
    }
    
    
    func setGreetTxt(){
        guard let name = userInfo?.userName,
            let position = userInfo?.positionTxt
            else{ return }
        greetTextLabel.text = "您好！\(name) \(position)"
    }
    



}
