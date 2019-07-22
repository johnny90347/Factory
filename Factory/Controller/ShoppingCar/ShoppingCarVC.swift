//
//  ShoppingCarVC.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/18.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit
import MessageUI
import Firebase

protocol pruchasedItemsChangeDelegate:NSObjectProtocol {
    func itemChange(_ shoppingCarVC:ShoppingCarVC, _ pruchasedItems:[PurchasedItem])
}

class ShoppingCarVC: UIViewController,UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate {
  
   
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var userInfoLabel: UILabel!

    @IBOutlet weak var sendEmailButtonOutlet: UIButton!
    
    
    
    
    
    
    //MARK: - 宣告區
    var userInfo:UserInfo?
    
    var pruchasedItemsFormVC = [PurchasedItem]()
    
    weak var itemChangeDelegate:pruchasedItemsChangeDelegate?
    
    private var listener:AuthStateDidChangeListenerHandle?
    
    //MARK: - 生命週期區
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        sendEmailButtonOutlet.layer.cornerRadius = 12
        sendEmailButtonOutlet.layer.masksToBounds = true
        
      
    }
    

    override func viewDidAppear(_ animated: Bool) {
        //確認是否在登入狀態
       listener = Auth.auth().addStateDidChangeListener { [weak self](auth, user) in
        guard let self = self else { return }
            if user != nil {
                print("有在登陸中")
                self.getUserInfo()
            }else{
                
            }
        }
        calculateTotalPrice()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let listener = listener else { return }
        Auth.auth().removeStateDidChangeListener(listener)
        
        itemChangeDelegate?.itemChange(self,pruchasedItemsFormVC)
       
    }
    deinit {
        print("SHoppingCarVC deinit")
    }
    
    
    
    
    //MARK:-
    //按下寄信的按鈕
    @IBAction func sendEmailButtonPressed(_ sender: UIButton) {
        
        guard let  user = userInfo else {return}
        
        if (MFMailComposeViewController.canSendMail()){          //如果mail可以用了話
            print("可以寄信")
            
            let mailController = MFMailComposeViewController()
            
            mailController.mailComposeDelegate = self
          
            let subject:String = "廠內訂單 來自 - \(user.department) \(user.userName) \(user.positionTxt) "
            
            var messageBody:String = "訂貨內容:\n\n"
            
            for item in pruchasedItemsFormVC {
                let name = item.productName
                let price = item.price
                let count = item.count
                let buyItem = "品名:\(name)   價格:\(price)   數量:\(count) \n\n"
                messageBody += buyItem
            }
            
            let totalPrice = totalPriceLabel.text
            messageBody += "\(totalPrice!)"
            
            mailController.setSubject(subject)
            mailController.setToRecipients(["johnny90347@gmail.com"])
            mailController.setMessageBody(messageBody, isHTML: false)
            self.present(mailController, animated: true, completion: nil)
        }
        else{
            print("不可以寄信")
        }
        
    }
    
    
    //MARK: mailComposeDelegate 發mial用
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result.rawValue{
            case MFMailComposeResult.cancelled.rawValue: print("取消")
            case MFMailComposeResult.sent.rawValue: print("寄出")
             case MFMailComposeResult.saved.rawValue: print("存檔")
            case MFMailComposeResult.failed.rawValue: print("失敗")
            
        default:
            print("都不是")
        }
        
        self.dismiss(animated: false, completion: nil)
        
      
    }
    
    
    func getUserInfo(){
        guard let userID = Auth.auth().currentUser?.uid else{return}
        Firestore.firestore().collection("users").document(userID).getDocument { [weak self](documentsnapshot, error) in
            guard let self = self else { return }
            if error != nil{
                print("取得資料失敗")
                return
            }
            guard let snapshot = documentsnapshot else{return}
            guard let data = snapshot.data(),
                let username = data["userName"] as? String,
                let sex = data["sex"] as? String,
                let department = data["department"] as? String,
                let positionTxt = data["positionTxt"] as? String,
                let level = data["level"] as? Int,
                let createdTime = data["createdTime"] as? Timestamp
            else{return}
            self.userInfo = UserInfo(userName: username, sex: sex, department: department, positionTxt: positionTxt, level:level , createdTime: createdTime)
            
            guard let userInfo = self.userInfo else {return}
            
            self.userInfoLabel.text = "\(userInfo.userName)\(userInfo.positionTxt)的 購物清單"  
            
        }
    }
    
    
    
     //計算總價格的方法
    func calculateTotalPrice (){
        var total = 0
        for item in  pruchasedItemsFormVC{
            let totalPrice = (item.price) * (item.count)
            total += totalPrice
        }
        totalPriceLabel.text = "總共\(total)元"
    }
    
    
    
    

    
    
    //MARK: - tableView dataSorce
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return pruchasedItemsFormVC.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "buyListCell", for: indexPath) as! ShoppingCarTableViewCell
        
             cell.configureCell(item: pruchasedItemsFormVC[indexPath.row])

        return cell
    }
    
    //MARK:- tableViewDeletage
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            pruchasedItemsFormVC.remove(at: indexPath.row)
            tableView.reloadData() //更新
             calculateTotalPrice() //計算價格
        }
    }
    

    
}
