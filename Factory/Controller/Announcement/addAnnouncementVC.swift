//
//  addAnnouncementVC.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/22.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import SVProgressHUD






class addAnnouncementVC: UIViewController {
    
    
    
    
    
    
    @IBOutlet weak var contentTextView: UITextView!
    

    var userInfo:UserInfo?


    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserInfo()
    }
    
    
    deinit {
        print("deinit addAnnouncementVC")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    
    @IBAction func addAnnouncementButtonPressed(_ sender: UIButton) {
    
        SVProgressHUD.show()
        guard let userID = Auth.auth().currentUser?.uid else {return}
        guard let userInfo = self.userInfo else {return}
        Firestore.firestore().collection("announcement").addDocument(data: [
            "announcer" : "\(userInfo.userName)-\(userInfo.positionTxt)",
            "contentTxt" : contentTextView.text!,
            "timeStamp" : FieldValue.serverTimestamp(),
            "userID" : userID
        ]) {[weak self] (error) in
            guard let self = self else{return}
            if error != nil{
                return
            }else{
                SVProgressHUD.dismiss()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
    
    
    //MARK:方法
    func getUserInfo(){
        
        guard let userID = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(userID).getDocument {[weak self] (documentSnapshot, error) in
            guard let self = self else {return}
            if error != nil{
                return
            }
            
            guard let data = documentSnapshot?.data(),
                let username = data["userName"] as? String,
                let sex = data["sex"] as? String,
                let department = data["department"] as? String,
                let positionTxt = data["positionTxt"] as? String,
                let level = data["level"] as? Int,
                let createdTime = data["createdTime"] as? Timestamp
                else {return}
            
            self.userInfo = UserInfo(userName: username, sex: sex, department: department, positionTxt: positionTxt, level: level, createdTime: createdTime)
            
        }
    }
}
