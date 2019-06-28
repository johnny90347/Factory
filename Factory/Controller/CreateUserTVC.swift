//
//  CreateUserTVC.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/6/28.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit

class CreateUserTVC: UITableViewController {


    @IBOutlet weak var sexTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sexTap = UITapGestureRecognizer(target: self, action: #selector(showSelectedSexAlert))
        sexTextField.addGestureRecognizer(sexTap)
        sexTextField.isUserInteractionEnabled = true
    }
    
    
    //觸發手勢的方法
    @objc func showSelectedSexAlert(){
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

    
    //設定cell的Header 顏色
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .blue
        
    }
    
    
    
    
    
   
    
    
  
   
}
