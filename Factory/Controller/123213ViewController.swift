//
//  123213ViewController.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/6/29.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class _23213ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func sqwdwqd(_ sender: UIButton) {
        
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //確認是否在登陸狀態
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                print("有在登入狀態")
            }else{
                print("沒有在登入狀態")
            }
        }
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
