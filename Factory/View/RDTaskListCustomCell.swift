//
//  RDTaskListCustomCell.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/1.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit

class RDTaskListCustomCell: UITableViewCell {
    @IBOutlet weak var taskStatusView: UIView!
    
    @IBOutlet weak var backGroundView: UIView!
    
    @IBOutlet weak var taskLabel: UILabel!
    
    @IBOutlet weak var clientNameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        taskStatusView.layer.cornerRadius = 6
        backGroundView.layer.cornerRadius = 6
        
    }


    
}
