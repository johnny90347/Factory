//
//  CreateUserTVC.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/6/28.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit
import Firebase



class CreateUserTVC: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var accountTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var checkPasswordTxt: UITextField!
    
    @IBOutlet weak var usernameTextFiled: UITextField!
    
    @IBOutlet weak var sexTextField: UITextField!
    
    @IBOutlet weak var departmentTxt: UITextField!
    
    @IBOutlet weak var positionTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        sexTapConfigure()       //性別選單
        departmentConfigure()   //部門選單
        positionConfigure()     //職稱選單
        
    }
    
    @IBAction func registerButtonPress(_ sender: UIButton) {
        
        if accountTextField.text! != "" &&     //檢查空白
            passwordTextField.text! != "" &&
            checkPasswordTxt.text! != "" &&
            usernameTextFiled.text != "" &&
            sexTextField.text! != "" &&
            departmentTxt.text! != "" &&
            positionTxt.text! != "" {
            
            if passwordTextField.text! == checkPasswordTxt.text! {    //重複確認密碼
                createdUserInfo()
            }else{
                showAlert(withTitle: "密碼檢查錯誤")   //密碼前後輸入錯誤
                
                passwordTextField.text = ""    //把密碼變空白
                checkPasswordTxt.text = ""
            }
            
            
            
        }else{
            //有資料還沒填完喔！
            showAlert(withTitle: "資料還沒填完喔！")
        }
        
       
  
    }
    
    //返回按鈕
    
    @IBAction func backButtonPress(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - 設定
    
    //按下鍵盤return 收鍵盤
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //按空白處 收鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //設定cell的Header 顏色
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor(red: 9/255, green: 132/255, blue: 227/255, alpha: 1)
        
    }
    
    
    //MARK: - 方法
    
    //使用者申請 ＆ 資料
    func createdUserInfo(){
        Auth.auth().createUser(withEmail: accountTextField.text!, password: passwordTextField.text!) { (authData, error) in
            if error != nil{
                print("帳號申請失敗\(error!.localizedDescription)")
                self.showAlert(withTitle: "帳號格式錯誤或帳號已存在")
        
            }
            
            guard let userID = Auth.auth().currentUser?.uid else{ return }
            Firestore.firestore().collection("users").document(userID).setData([
                "userName" : self.usernameTextFiled.text!,
                "sex" : self.sexTextField.text!,
                "department" : self.departmentTxt.text!,
                "positionTxt" : self.positionTxt.text!,
                "level" : 3,
                "createdTime" : FieldValue.serverTimestamp()
                ], completion: { (error) in
                    if error != nil{
                    print("建立帳號失敗\(error!.localizedDescription)")
                    self.showAlert(withTitle: "資料建立失敗")
                        
                    }
            })
            
            self.showAlertSuccessCreated()
        }
    }
    
    
    //警告控制器 (通用）
    func showAlert(withTitle title:String){
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "確認", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    //警告控制器（申請成功專用）
    func showAlertSuccessCreated(){
        let alert = UIAlertController(title:"建立成功", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "確認", style: .default) { (action) in
             self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    //MARK: - 性別選單
    //建立性別手勢
    func sexTapConfigure(){
        let sexTap = UITapGestureRecognizer(target: self, action: #selector(showSelectedSex))
        sexTextField.addGestureRecognizer(sexTap)
        sexTextField.isUserInteractionEnabled = true
        
        
    }
    //觸發性別手勢實作的方法
    @objc func showSelectedSex(){
        let sexs = ["男生","女生"]
        let alert = UIAlertController(title: "性別", message: "請選擇您的性別", preferredStyle: .actionSheet)
        for sex in sexs {
            let action = UIAlertAction(title:sex, style: .default) { (action) in
                self.sexTextField.text = sex
            }
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    //MARK: - 部門選單
    //建立部門手勢
    func departmentConfigure(){
        let departmentTap = UITapGestureRecognizer(target: self, action: #selector(showSelectedDepartment))
        departmentTxt.addGestureRecognizer(departmentTap)
        departmentTxt.isUserInteractionEnabled = true
    }
    //觸發部門手勢實作的方法
    @objc func showSelectedDepartment(){
        let departments = ["管理部","研發部","製造部","包裝部","業務部"]
        let alert = UIAlertController(title: "部門", message: "請選擇您的部門", preferredStyle: .actionSheet)
        
        for department in departments {
            let action = UIAlertAction(title: department, style: .default) { (action) in
                self.departmentTxt.text = department
            }
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
    
    
    
    //MARK: - 職位選單
    //建立職稱手勢
    func positionConfigure(){
        let positionTap = UITapGestureRecognizer(target: self, action: #selector(showSelectedPosition))
        positionTxt.addGestureRecognizer(positionTap)
        positionTxt.isUserInteractionEnabled = true
    }
    //觸發職稱手勢實作的方法
    @objc func showSelectedPosition(){
        let Positions = ["總經理","經理","主管","專員","工員"]
        let alert = UIAlertController(title: "職稱", message: "請選擇您的職稱", preferredStyle: .actionSheet)
        
        for Position in Positions {
            let action = UIAlertAction(title: Position, style: .default) { (action) in
                self.positionTxt.text = Position
            }
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
    

    
   
    
    
  
   
}
