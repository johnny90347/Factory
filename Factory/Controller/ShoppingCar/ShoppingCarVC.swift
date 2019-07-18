//
//  ShoppingCarVC.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/18.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit


protocol pruchasedItemsChangeDelegate:NSObjectProtocol {
    func itemChange(_ pruchasedItems:[PurchasedItem])
}

class ShoppingCarVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
  
    
    
    var pruchasedItemsFormVC = [PurchasedItem]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    weak var itemChangeDelegate:pruchasedItemsChangeDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
       
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
    
    
    override func viewDidAppear(_ animated: Bool) {
        calculateTotalPrice()
     
    }
    
    
    //MARK:-
    @IBAction func backButtonPress(_ sender: UIBarButtonItem) {
        
        itemChangeDelegate?.itemChange(pruchasedItemsFormVC)
        navigationController?.popViewController(animated: true)
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
