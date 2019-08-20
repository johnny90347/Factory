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
import SVProgressHUD

class FactoryViewController: UIViewController {
    
    
    var userInfo:UserInfo?
    var listener:AuthStateDidChangeListenerHandle!

    
    @IBOutlet weak var leftDoorLeading: NSLayoutConstraint!
    
    @IBOutlet weak var rightDoorTraling: NSLayoutConstraint!
    
    @IBOutlet weak var leftDoorImageView: UIImageView!
    
    @IBOutlet weak var rightDoorImageView: UIImageView!
    
    @IBOutlet weak var greetTextLabel: UILabel!
    

    @IBOutlet weak var rdLabel: UILabel!   //畫面設定用
    @IBOutlet weak var rdButton: UIButton!
    
    @IBOutlet weak var mdLabel: UILabel!
    @IBOutlet weak var mdButton: UIButton!
    
    @IBOutlet weak var pgLabel: UILabel!
    @IBOutlet weak var pgButton: UIButton!
    
    @IBOutlet weak var adLabel: UILabel!
    @IBOutlet weak var adButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        leftDoorImageView.layer.cornerRadius = 20 //設定門的圓角
        rightDoorImageView.layer.cornerRadius = 20
 
        uiElementShapeConfigure()
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        doorClose()  //登入畫面之前 先關門 (修改登出後再登入 會沒有動畫的bug)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //確認是否在登陸狀態
      listener = Auth.auth().addStateDidChangeListener { [weak self](auth, user) in
            guard let self = self else { return }

            if user != nil {
                print("有在登入狀態")
                self.getUserInfo()  //有登入時 門開啟
            }else{
                print("沒有在登入狀態")
                self.LoginAlert () //沒有登入時 轉場登入的畫面
                self.doorClose()  //沒有登入時 門關起來
                
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(listener)
    }
    

    
    //MARK:- 部門按鈕群
    
    @IBAction func RDButtonPress(_ sender: UIButton) {
        entryCondition(withDepartment: "研發部", segueID: "goToRD")

    }
    
    @IBAction func MDButtonpress(_ sender: UIButton) {
        entryCondition(withDepartment: "製造部", segueID:"goToMD")
    }
    
    
    @IBAction func PDbuttonPress(_ sender: UIButton) {
        performSegue(withIdentifier: "goToPD", sender: self)
    }
    
    @IBAction func ADbuttonPress(_ sender: UIButton) {
        entryCondition(withDepartment: "管理部", segueID: "goToAD")
    }
   
    
    //MARK: 進入部門的條件
    func entryCondition(withDepartment department:String,segueID sgID:String){
        guard let myDepartment = userInfo?.department,
            let level = userInfo?.level else {return}
        
        if myDepartment == department || level <= 2 {   //登入限制自己的所屬部門or高階級人士
            performSegue(withIdentifier: sgID, sender: self)
        }else{
            commonAlert(withTitle: "抱歉！您不符合資格")
        }
        
        
    }
    
    
    //MARK:- 到伺服器端 取資料
    //取得使用者資料
    func getUserInfo(){
        
        SVProgressHUD.show() //
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(userID).getDocument {[weak self] (snapshot, error) in
            guard let self = self else { return }
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
    

    
    
 
    //MARK:- 警告控制器
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
        SVProgressHUD.dismiss()
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "確認", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    //MARK: - 畫面設定的方法
    
    //設定招呼文字
    func setGreetTxt(){
        SVProgressHUD.dismiss()
        guard let name = userInfo?.userName,
            let position = userInfo?.positionTxt
            else{ return }
        greetTextLabel.text = "您好！\(name) \(position)"
    }
    
    //開啟門 動畫
    func doorOpenAnimete (){
        UIView.animate(withDuration: 1.0) {
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
        self.view.layoutIfNeeded()
    }
    
    //畫面元件設定圓角
    func uiElementShapeConfigure(){
        
        rdLabel.layer.cornerRadius = 20
        rdLabel.layer.masksToBounds = true
        rdButton.layer.cornerRadius = 15
        rdButton.layer.masksToBounds = true
        
        mdLabel.layer.cornerRadius = 20
        mdLabel.layer.masksToBounds = true
        mdButton.layer.cornerRadius = 15
        mdButton.layer.masksToBounds = true
        
        pgLabel.layer.cornerRadius = 20
        pgLabel.layer.masksToBounds = true
        pgButton.layer.cornerRadius = 15
        pgButton.layer.masksToBounds = true
        
        adLabel.layer.cornerRadius = 20
        adLabel.layer.masksToBounds = true
        adButton.layer.cornerRadius = 15
        adButton.layer.masksToBounds = true
        
        
    }
    
    



}
