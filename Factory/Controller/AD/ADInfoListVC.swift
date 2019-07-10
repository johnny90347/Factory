//
//  ADInfoListVC.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/9.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit

class ADInfoListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var staredSelectedBtn: UIButton!
    
    @IBOutlet var options: [UIButton]!
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        uiElementConfigure()
        
    }
    
    
    
    //MARK:- tableview DataSorce
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "adcell", for: indexPath)
        
        return cell
    }
    
    
    //MARK:- tableview Delegate
    
    
    //MARK: - 按鈕群

    // 顯示選單  按鈕
    @IBAction func staredSelectedBtnPress(_ sender: UIButton) {
        
        showOptions()
    }
    //選項按鈕 (多個)
    @IBAction func optionPressed(_ sender: UIButton) {
        showOptions()
        
    }
    //新增客戶資訊
    @IBAction func addClientButtonPressed(_ sender: UIBarButtonItem) {
        
        
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
    
    
   
  

}
