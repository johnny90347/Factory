//
//  MDTaskListCustomCell.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/3.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit

class MDTaskListCustomCell: UITableViewCell {
    
    @IBOutlet weak var leftStatusView: UIView!
    @IBOutlet weak var upperRightView: UIView!
    
    @IBOutlet weak var shipDateLabel: UILabel!
    @IBOutlet weak var clientNameLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var numberOfKgLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
   
    }
    
    
    func configureCell(mdTask:MDTaskInfo) {
        //date
        
        clientNameLabel.text = mdTask.client
        productNameLabel.text = mdTask.productName
        numberOfKgLabel.text = mdTask.numberOfKg
        
    }



}
