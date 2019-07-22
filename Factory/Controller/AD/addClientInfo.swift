//
//  addClientInfo.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/9.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit
import FirebaseFirestore
import SVProgressHUD

class addClientInfo: UIViewController ,UITextViewDelegate{
    
    @IBOutlet weak var bottonViewHeightCt: NSLayoutConstraint! //動畫用
    @IBOutlet weak var expansionBtn: UIButton! //動畫用
    
    @IBOutlet weak var clientNameTxt: UITextField!
    @IBOutlet weak var addressTxt: UITextField!
    @IBOutlet weak var phoneNumberTxt: UITextField!
    @IBOutlet weak var categoryTxt: UITextField!
    
    @IBOutlet weak var supplementTxtView: UITextView!
    @IBOutlet weak var addClientBtnOutlet: UIButton!  //美觀用
    
    
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        supplementTxtView.delegate = self
        uielementConfigure() //一開始先收起來備註欄
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectedCategory))
        categoryTxt.addGestureRecognizer(tap)
        categoryTxt.isUserInteractionEnabled = true
    }
    
    @objc func selectedCategory(){
        self.view.endEditing(true)
        let alert = UIAlertController(title: "請選擇", message: "", preferredStyle: .actionSheet)
        
        let categorys = ["客戶","廠商","其他"]
        for category in categorys{
            let action = UIAlertAction(title:category , style: .default) {[weak self] (action) in
                guard let self = self else {return}
                self.categoryTxt.text = category
                
            }
            alert.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        supplementTxtView.text = ""
    }
    
    
    @IBAction func addClientInfo(_ sender: UIButton) {
        SVProgressHUD.show()
        Firestore.firestore().collection("AD").addDocument(data: [
            "clientName" : clientNameTxt.text!,
            "address" : addressTxt.text!,
            "phoneNumber" : phoneNumberTxt.text!,
            "category" : categoryTxt.text!,
            "supplement" : supplementTxtView.text!
        ]) { [weak self](error) in
            guard let self = self else {return}
            if error != nil{
                return
            }else{
                SVProgressHUD.dismiss()
                 self.navigationController?.popViewController(animated: true)
            }
            
          
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    
    
    //展開備註欄
    @IBAction func expansionBtnPressed(_ sender: UIButton) {
        
        
        if expansionBtn.transform == .identity {
            UIView.animate(withDuration: 0.5) {
                self.bottonViewHeightCt.constant = self.view.frame.height/3
                self.view.layoutIfNeeded()
                self.expansionBtn.transform = CGAffineTransform(rotationAngle: .pi)
            }
        }else{
            UIView.animate(withDuration: 0.5) {
                self.bottonViewHeightCt.constant = 0
                self.view.layoutIfNeeded()
                self.expansionBtn.transform = .identity
            }
        }
        
        
       
        
    }
    
    
    
  
    
    
    //MARK: - 畫面設定 與 動畫
    
    
    //初始畫面設定
    func uielementConfigure(){
        bottonViewHeightCt.constant = 0
        view.layoutIfNeeded()
        addClientBtnOutlet.layer.cornerRadius = 20
        addClientBtnOutlet.layer.masksToBounds = true
        supplementTxtView.layer.cornerRadius = 15
        
        
    }
    //MARK:開啟補充視窗
    func supplementViewOpen(){
      
    }
     //MARK:關閉補充視窗
    func supplementViewClose(){
      
    }
}
