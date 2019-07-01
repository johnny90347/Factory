//
//  RDAddTaskViewController.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/1.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit
import FirebaseFirestore

class RDAddTaskViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var clientNameLabel: UITextField!
    
    
    @IBOutlet weak var taskTextView: UITextView!
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        taskTextView.text = ""
        textView.textColor = .darkGray
    }
    //按到空白地方 鍵盤收起來
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTextView.delegate = self
        
        taskTextView.textColor = .lightGray

    }
    
    
    //MARK: 加入代辦任務 按鈕
    @IBAction func addTaskButtonPress(_ sender: UIButton) {
        //將待辦事項存到叫RD的collection內
        Firestore.firestore().collection("RD").addDocument(data: [
            "clientName" : clientNameLabel.text!,
            "taskTxt" : taskTextView.text!,
            "status" : false,
            "timestamp" : FieldValue.serverTimestamp()
        ]) { (error) in
            if error != nil{
                print("輸入失敗")
                return
            }else{
                print("輸入成功")
                self.navigationController?.popToRootViewController(animated: true)
            }
            
        }
        
        
    }
    

   

}
