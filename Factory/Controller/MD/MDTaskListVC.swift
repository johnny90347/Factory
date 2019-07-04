//
//  MDTaskListVC.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/3.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit
import FirebaseFirestore

class MDTaskListVC: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    
    var mdTaskLists = [MDTaskInfo]()
    var mdListener:ListenerRegistration?
    
    var deviceCatCategory = "total"
    
    
    @IBOutlet weak var taskListTableView: UITableView!
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var taskNumberLabel: UILabel!
    
    //選取設備segment 切換設備
    @IBAction func deviceSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            deviceCatCategory =  "total"
        case 1:
            deviceCatCategory = "真空乳化機"
        case 2:
            deviceCatCategory = "升降乳化頭"
        default:
            deviceCatCategory = "攪拌桶"
        }
        mdListener!.remove()
        setMDTaskListener()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        taskListTableView.dataSource = self
        taskListTableView.delegate = self
        
        taskListTableView.rowHeight = UITableView.automaticDimension
        taskListTableView.estimatedRowHeight = 120
        
        
        //UI element的 畫面
        topView.layer.cornerRadius = 10
        topView.layer.shadowOffset = CGSize(width: 5, height: 5)
        topView.layer.shadowColor = UIColor.lightGray.cgColor
        topView.layer.shadowOpacity = 0.7
        
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setMDTaskListener()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if mdListener != nil{
            mdListener?.remove()
        }
    }
    

   
    //MARK: - TableViewDataSorce
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mdTaskLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mdCell", for: indexPath) as! MDTaskListCustomCell
        cell.configureCell(mdTask: mdTaskLists[indexPath.row])
        
        return cell
    }
    
    
    //MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            Firestore.firestore().collection("MD").document(mdTaskLists[indexPath.row].documentID).delete { (error) in
                if error != nil{
                    print("刪除失敗")
                }
            }
        }
    }
    
    
    //MARK: - 監聽資料
    func setMDTaskListener (){
        
        if deviceCatCategory == "total"{
            mdListener =  Firestore.firestore().collection("MD")
                .order(by: "status", descending: true)  //狀態level 1的 排上面
                .order(by: "shipDate")                  //日期數字大的牌下面
                .addSnapshotListener { (querySnapShop, error) in
                    if error != nil{
                        print("讀取資料失敗")
                        return
                    }
                    self.mdTaskLists.removeAll()   //先刪除原本的排程
                    guard let docoments = querySnapShop?.documents else{ return }  //哪拿到一包文件
                    for document in docoments{    //把每個文件拿出來做點事情
                        let documentID = document.documentID  // 取得documentID
                        
                        let data = document.data() //拿到一個key 一個 value
                        //轉型
                        guard let shipDate = data["shipDate"] as? Timestamp,
                            let client = data["client"] as? String,
                            let productName = data["productName"] as? String,
                            let numberOfKg = data["numberOfKg"] as? String,
                            let device = data["device"] as? String,
                            let status = data["status"] as? Int
                            else{return}
                        let mdTask = MDTaskInfo(shipDate: shipDate, client: client, productName: productName, numberOfKg: numberOfKg, device: device, status: status, documentID: documentID)
                        
                        self.mdTaskLists.append(mdTask)
                        self.taskNumberLabel.text = "共有\(self.mdTaskLists.count)張訂單"
                        self.taskListTableView.reloadData()
                    }
                    
            }
            
        }else{
            mdListener =  Firestore.firestore().collection("MD")
                .whereField("device", isEqualTo: self.deviceCatCategory)
                .order(by: "status", descending: true)  //狀態level 1的 排上面
                .order(by: "shipDate")                  //日期數字大的牌下面
                .addSnapshotListener { (querySnapShop, error) in
                    if error != nil{
                        print("讀取資料失敗")
                        return
                    }
                    self.mdTaskLists.removeAll()   //先刪除原本的排程
                    guard let docoments = querySnapShop?.documents else{ return }  //哪拿到一包文件
                    for document in docoments{    //把每個文件拿出來做點事情
                        let documentID = document.documentID  // 取得documentID
                        
                        let data = document.data() //拿到一個key 一個 value
                        //轉型
                        guard let shipDate = data["shipDate"] as? Timestamp,
                            let client = data["client"] as? String,
                            let productName = data["productName"] as? String,
                            let numberOfKg = data["numberOfKg"] as? String,
                            let device = data["device"] as? String,
                            let status = data["status"] as? Int
                            else{return}
                        let mdTask = MDTaskInfo(shipDate: shipDate, client: client, productName: productName, numberOfKg: numberOfKg, device: device, status: status, documentID: documentID)
                        
                        self.mdTaskLists.append(mdTask)
                        
                        self.taskNumberLabel.text = "共有\(self.mdTaskLists.count)張訂單"
                        self.taskListTableView.reloadData()
                    }
                    
            }
            
        }
        
        
        
        
        
 

        
    }
    
    
    //MARK:- 畫面元件的美化
    func uiElementConfigure(){
        
    }

}
