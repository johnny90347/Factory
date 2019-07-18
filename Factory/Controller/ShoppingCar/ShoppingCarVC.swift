//
//  ShoppingCarVC.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/18.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit

class ShoppingCarVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
  
    
    
    var pruchasedItemsFormVC:[PurchasedItem]?
    
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    //MARK: - tableView dataSorce
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if pruchasedItemsFormVC != nil{
            return pruchasedItemsFormVC!.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "buyListCell", for: indexPath)
        
        cell.textLabel?.text = pruchasedItemsFormVC?[indexPath.row].productName
        
        return cell
    }
    

    
}
