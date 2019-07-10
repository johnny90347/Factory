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
    @IBOutlet weak var categoryTxt: UITextField!
    
    @IBOutlet weak var supplementTxtView: UITextView!
    
    
    
    var supplementOn:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        uielementConfigure() //一開始先收起來備註欄
        supplementTxtView.delegate = self
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        supplementTxtView.text = ""
    }
    
    
    @IBAction func addClientInfo(_ sender: UIButton) {
        SVProgressHUD.show()
        Firestore.firestore().collection("AD").addDocument(data: [
            "clientName" : clientNameTxt.text!,
            "address" : addressTxt.text!,
            "category" : categoryTxt.text!,
            "supplement" : supplementTxtView.text!
        ]) { (error) in
            if error != nil{
                return
            }else{
                SVProgressHUD.dismiss()
                 self.navigationController?.popViewController(animated: true)
            }
            
          
        }
        
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
    }
    //MARK:開啟補充視窗
    func supplementViewOpen(){
      
    }
     //MARK:關閉補充視窗
    func supplementViewClose(){
      
    }
}
