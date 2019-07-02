//
//  RDTaskListVC.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/1.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit
import FirebaseFirestore

class RDTaskListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var rdTaskLists = [RDTaskInfo](){
        didSet{
            topLabelAnimate() //如果內容有變 做個動畫
        }
    }
    
    var linstener: ListenerRegistration!
    
    
    @IBOutlet weak var taskListTableview: UITableView!
    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var topView: UIView!
    
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        taskListTableview.delegate = self
        taskListTableview.dataSource = self
        
        
        topViewConfigure()
        

       
      
    }
    
 
    
   
    
    
    override func viewDidAppear(_ animated: Bool) {
        setRDTaskListener() //開始監聽
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if linstener != nil{
            linstener.remove() //移除監聽
        }
    }
    
    
    //MARK:- tableViewDataSorce
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rdTaskLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RDcell", for: indexPath) as! RDTaskListCustomCell
        //這樣可以把資料傳過去
        cell.configureCell(rdTask: rdTaskLists[indexPath.row])
        
        
        return cell
        
    }
    
    //MARK:- TableViewDelegate
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            Firestore.firestore().collection("RD").document(rdTaskLists[indexPath.row].documentID).delete { (error) in
                if error != nil{
                    print("刪除失敗")
                }
            }
        }

    }
    

    
    
    //MARK: -
    //MARK: 監聽collection "RD" 裡全部的資料 的方法
    func setRDTaskListener(){
        linstener =    //放到最上面方便我移除監聽   //照時間排序
        Firestore.firestore().collection("RD")/*.order(by: "timestamp", descending: false)*/.order(by: "status", descending: true).order(by: "timestamp").addSnapshotListener { (querySnapshop, error) in
            if error != nil {
                print("讀取資料失敗")
                return
            }
            self.rdTaskLists.removeAll()//先移除原本的
            
            //步驟一 把querySnapShop的資料群拿出來（好多個）
            guard let documents = querySnapshop?.documents else {return}
            //步驟二 把單一個文件取出
            for document in documents {
            //步驟三 文件的內容
              let data = document.data()
            //步驟四 轉型
                let documentID = document.documentID
                guard let clientName = data["clientName"] as? String,
                let taskTxt = data["taskTxt"] as? String,
                let status = data["status"] as? Int,
                let timestamp = data["timestamp"] as? Timestamp
                else{return}
                
                let rdTask = RDTaskInfo(client: clientName, taskTxt: taskTxt, status: status, timestamp: timestamp, documentID: documentID)
            //加到陣列裡面

                self.rdTaskLists.append(rdTask)//再加入新的
               self.topLabel.text = "共有\(self.rdTaskLists.count)個研發品項" //更新字幕
               
                self.taskListTableview.reloadData()
                
            }
        }
  
    }
    
    
    //MARK: -
    //MARK:tableView的設定
    func tableviewConfigure(){
        taskListTableview.rowHeight = UITableView.automaticDimension //自動rowHeight
        taskListTableview.estimatedRowHeight = 120
        
    }
    
    //MARK: -
    //MARK:topLabel的動畫
    func topLabelAnimate(){
        UIView.animate(withDuration: 0.2) {
            UIView.setAnimationRepeatCount(3)
            self.topLabel.alpha = 0
        }
        
        UIView.animate(withDuration: 0.7, delay: 0.5, options:.autoreverse, animations: {
            
            self.topLabel.alpha = 1
        }, completion:nil)
        
    }
    //MARK:topView的美編
    func topViewConfigure(){
        topView.layer.borderColor = UIColor.black.cgColor //匡顏色
        topView.layer.borderWidth = 1
        topView.layer.shadowColor = UIColor.lightGray.cgColor //陰影顏色
        topView.layer.shadowOffset = CGSize(width: 5, height: 5) //陰影位置
        topView.layer.shadowOpacity = 0.7   //陰影透明度
        topView.layer.cornerRadius = 10
    }
    
    

}
