//
//  ADInfoListVC.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/9.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ADInfoListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var staredSelectedBtn: UIButton!
    
    @IBOutlet var options: [UIButton]! //隱藏或顯示選單
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var clientInfos = [ADClientInfo]()   //儲存廠商資訊
    
    var linstener:ListenerRegistration?
    
    var category = "total"
    
    var adDetailVC:adDetailVC?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        uiElementConfigure()
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        getClientInfo() //取得客戶名單
        print("開始監聽")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if linstener != nil{
           clearedInfo() //離開時清空資訊包括 陣列
            print("離開監聽")
        }
    }
    
    //MARK:- tableview DataSorce
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clientInfos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "adcell", for: indexPath)
        
        cell.textLabel?.text = clientInfos[indexPath.row].clientName
        cell.detailTextLabel?.text = clientInfos[indexPath.row].phoneNumber
        cell.imageView?.image = UIImage(named: "client")
        
        return cell
    }
    
    
    //MARK:- tableview Delegate
    
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{            Firestore.firestore().collection("AD").document(clientInfos[indexPath.row].documentID).delete { (error) in
                if error != nil{
                    return
                }
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "adDetial", sender: self)
        
        adDetailVC?.infoFormADinfoList = clientInfos[indexPath.row]
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "adDetial"{
            
            adDetailVC = segue.destination as? adDetailVC
            
            
        }
    }
    
    
    
    //動畫
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let rotationTransfor = CATransform3DTranslate(CATransform3DIdentity, -300, 0, 0)
        cell.layer.transform = rotationTransfor
        
        
        UIView.animate(withDuration: 0.3) {
            cell.layer.transform = CATransform3DIdentity
            
        }
    }
    
    //MARK: - 按鈕群

    // 顯示選單  按鈕
    @IBAction func staredSelectedBtnPress(_ sender: UIButton) {

        showOptions()
 
    }
    //選項按鈕 (多個)
    @IBAction func optionPressed(_ sender: UIButton) {
        showOptions()
        
        //不同的按鈕 會改變上面的category 內容
        if sender.tag == 1{
            self.category = "廠商"
            staredSelectedBtn.titleLabel?.text = "廠商" //改變 按鈕 的文字
        }else if sender.tag == 2{
             self.category = "客戶"
            staredSelectedBtn.titleLabel?.text = "客戶" //改變 按鈕 的文字
        }else{
            self.category = "其他"
            staredSelectedBtn.titleLabel?.text = "其他" //改變 按鈕 的文字
        }
        
        linstener!.remove()
        getClientInfo()
      
        
    }
    //新增客戶資訊
    @IBAction func addClientButtonPressed(_ sender: UIBarButtonItem) {
        
        
    }
    


    
    //在firebase取資料
    func getClientInfo(){
        if category == "total"{
            linstener = Firestore.firestore().collection("AD").addSnapshotListener { (querySnapshot, error) in
                if error != nil{
                    print("取得資料失敗")
                    return
                }else{
                    self.clientInfos.removeAll() //資料一有變動先刪除原本的資料
                    guard let documents =  querySnapshot?.documents else{return}
                    for document in documents{
                        let id = document.documentID
                        let data =  document.data()
                        guard let clientName = data["clientName"] as? String,
                            let address = data["address"] as? String,
                            let phoneNumber = data["phoneNumber"] as? String,
                            let category = data["category"] as? String,
                            let supplement = data["supplement"] as? String
                            else{return}
                        
                        let info = ADClientInfo(clientName: clientName, address: address, phoneNumber: phoneNumber, category: category, supplement: supplement,documentID:id)
                        self.clientInfos.append(info)
                        self.tableView.reloadData()
                    }
                }
            }
        }else{
            linstener = Firestore.firestore().collection("AD").whereField("category", isEqualTo: self.category).addSnapshotListener { (querySnapshot, error) in
                if error != nil{
                    print("取得資料失敗")
                    return
                }else{
                    self.clientInfos.removeAll() //資料一有變動先刪除原本的資料
                    guard let documents =  querySnapshot?.documents else{return}
                    for document in documents{
                        let id = document.documentID
                        let data =  document.data()
                        guard let clientName = data["clientName"] as? String,
                            let address = data["address"] as? String,
                            let phoneNumber = data["phoneNumber"] as? String,
                            let category = data["category"] as? String,
                            let supplement = data["supplement"] as? String
                            else{return}
                        
                        let info = ADClientInfo(clientName: clientName, address: address, phoneNumber: phoneNumber, category: category, supplement: supplement,documentID:id)
                        self.clientInfos.append(info)
                        
                    }
                    self.tableView.reloadData()
                }
            }
        }
 
    }
    
    
    
    //MARK:- 畫面設定
    //修飾畫面的元件
    func uiElementConfigure(){
        
        staredSelectedBtn.layer.cornerRadius = 15
        staredSelectedBtn.layer.masksToBounds = true
        
        for option in options{
            option.layer.cornerRadius = 15
            option.layer.masksToBounds = true
        }
        
    }
    //秀出 或 收起選單
    func showOptions(){
        for option in options{
            UIView.animate(withDuration: 0.3) {
                option.isHidden = !option.isHidden
                if option.isHidden == true{
                    option.alpha = 0
                }else{
                    option.alpha = 1
                }
                
                self.view.layoutIfNeeded()
            }
            
        }
    }
    
    //MARK:-其他方法
    
    //清空array 監聽。  reloadData是因為 修復進入時會閃一下的bug
    func clearedInfo(){
        linstener!.remove()
        clientInfos.removeAll()
        tableView.reloadData()
    }
    
    
   
  

}
