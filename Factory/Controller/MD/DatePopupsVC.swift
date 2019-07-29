//
//  DatePopupsVC.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/3.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit

class DatePopupsVC: UIViewController {
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var backGroundView: UIView!
    
    var date:Date!
    
    var formattedDate:String {
        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
        formatter.dateFormat = "yyyy/M/d"
        return formatter.string(from: datePicker.date)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        backGroundView.layer.cornerRadius = 8
        
        
        backGroundView.transform = CGAffineTransform(scaleX: 0.3, y: 2.0)  //視窗變形(配合動畫還原）
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        //還原變形動畫
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [.curveEaseOut,.allowUserInteraction], animations: {
            self.backGroundView.transform = .identity
        }, completion: nil)
    }
    
    @IBAction func saveDateButtonPress(_ sender: UIButton) {
        date =  datePicker.date
       
       transferInfo()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      transferInfo()
    }
    
    //傳送資料
    func transferInfo(){
        dismiss(animated: false, completion: nil)  //畫面撤掉
        NotificationCenter.default.post(name:.saveDate , object: self)   //post資料
    }
    
}

extension Notification.Name{
    static let saveDate = Notification.Name("saveDate")
}
