//
//  MDAddTaskVC.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/3.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit
import FirebaseFirestore

class MDAddTaskVC: UIViewController {
    
    
    var observer:NSObjectProtocol?      //為了要解散 收聽
    var date:Date?
    
    @IBOutlet weak var clientNameTxt: UITextField!
    
    @IBOutlet weak var productNameTxt: UITextField!
    
    @IBOutlet weak var numberOfKgTxt: UITextField!
    
    @IBOutlet weak var deviceTxt: UITextField!
    
    @IBOutlet weak var shipDateTxt: UITextField!
    
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewConfigure()  //陰影 ＋ 圓角
        
        deviceAddTap() //設備Txt加入手勢 和 alert選項
       
        }
    
  
    
    
   
    //MARK: -
    //畫面出現時 收聽
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
       observer = NotificationCenter.default.addObserver(forName: .saveDate, object: nil, queue: OperationQueue.main) { (notification) in
            let dateVC = notification.object as! DatePopupsVC
            self.shipDateTxt.text = dateVC.formattedDate
            self.date = dateVC.date
        }
    }
    
    
    //畫面離開時 解散 收聽
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        if let observer = self.observer{
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    //MARK:-
    //MARK: 上傳資料 按鈕
    @IBAction func addTaskButtonPress(_ sender: UIButton) {
        
        //上傳資料
        
        Firestore.firestore().collection("MD").addDocument(data:
            ["shipDate" : shipDateTxt.text!,     //交貨日期
                "client" : clientNameTxt.text!,  //客戶名
                "productName" : productNameTxt.text!,   //產品名稱
                "numberOfKg" : numberOfKgTxt.text!,     //幾公斤
                "device" : deviceTxt.text!,             //用什麼設備做
                "status" : 0                            //狀態 預設 0 代表還沒開始工作
        ]) { (error) in
            if error != nil{
                self.commonAlert(withTitle: "輸入異常")
                return
            }else{
                self.navigationController?.popViewController(animated: true)
            }
        }
        
        
    }
    
    
    //MARK: - 通用跳出警告控制器
    func commonAlert(withTitle title:String){
        let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "確認", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)

    }
    
    
    
    //MARK:-
    //MARK:點選空白處,收起鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK:- 給diviceTxt加入一個手勢
    func deviceAddTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectedDeivce))
        deviceTxt.addGestureRecognizer(tap)
    }
    
    
    //手勢實作的方法
    @objc func selectedDeivce(){
        let alert = UIAlertController(title: "選擇設備", message: "", preferredStyle: .actionSheet)
        let devices = ["真空乳化機","升降乳化頭","攪拌桶"]
        for device in devices {
            let action = UIAlertAction(title: device, style: .default) { (action) in
                self.deviceTxt.text = device
            }
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: UI元件的設計
    func viewConfigure(){
        topView.layer.cornerRadius = 10
        topView.layer.shadowColor = UIColor.lightGray.cgColor
        topView.layer.shadowOpacity = 0.7
        topView.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        bottomView.layer.cornerRadius = 10
        bottomView.layer.shadowOffset = CGSize(width: 5, height: 5)
        bottomView.layer.shadowColor = UIColor.lightGray.cgColor
        bottomView.layer.shadowOpacity = 0.7
    }
    
    
    


}
