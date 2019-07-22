//
//  DetailTableViewController.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/11.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    
    
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var supplementLabel: UILabel!
    
     var infoFormADDetial:ADClientInfo?
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 1{
            guard let number = infoFormADDetial?.phoneNumber else{return}
            let url = URL(string: "tel://\(number)")
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
       
        
    }
  
}
