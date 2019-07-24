//
//  AnnouncementVC.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/22.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit
import FirebaseFirestore

class AnnouncementVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    
    var listener:ListenerRegistration!
    var announcements = [AnnouncementInfo]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setAnoListener()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        listener.remove()
    }
    
    
    
    
    //MARK: - tableViewDataSocre
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return announcements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "announcementCell", for: indexPath) as! AnnouncementTableViewCell
        
        cell.cellConfigure(Txt: announcements[indexPath.row])
        
        
        return cell
        
    }
    

    //MARK: - 監聽公告欄內容
    func setAnoListener(){
       listener = Firestore.firestore().collection("announcement").addSnapshotListener { [weak self](querySnapshot, error) in
        guard let self = self else {return}
            if error != nil {
                return
            }
            self.announcements.removeAll() //先移除原本的
        
            guard let documents = querySnapshot?.documents else {return}
            for document in documents {
            let data = document.data()
             guard let announcer = data["announcer"] as? String,
                let contentTxt = data["contentTxt"] as? String,
                let timeStamp = data["timeStamp"] as? Timestamp,
                let userID = data["userID"] as? String
                else{return}
                
                let anoTxt = AnnouncementInfo(announcer: announcer, contentTxt: contentTxt, timeStamp: timeStamp , userID:userID )
                self.announcements.append(anoTxt)
                self.tableView.reloadData()
                
            }
        }
    }
    
    
    


    
    
}
