//
//  CreateUserTVC.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/6/28.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit

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
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

   

    
    //設定cell的Header 顏色
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .blue
        
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
