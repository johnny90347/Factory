//
//  MDAddTaskVC.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/3.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit

class MDAddTaskVC: UIViewController {
    
    
    var observer:NSObjectProtocol?      //為了要解散 收聽
    
    @IBOutlet weak var clientNameTxt: UITextField!
    
    @IBOutlet weak var productNameTxt: UITextField!
    
    @IBOutlet weak var numberOfKgTxt: UITextField!
    
    @IBOutlet weak var deviceTxt: UITextField!
    
    @IBOutlet weak var shipDateTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        }
        
    
    //畫面出現時 收聽
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
       observer = NotificationCenter.default.addObserver(forName: .saveDate, object: nil, queue: OperationQueue.main) { (notification) in
            let dateVC = notification.object as! DatePopupsVC
            self.shipDateTxt.text = dateVC.formattedDate
        }
    }
    
    //畫面離開時 解散收聽
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        if let observer = self.observer{
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    
    @IBAction func addTaskButtonPress(_ sender: UIButton) {
        
        
    }
    
    


}
