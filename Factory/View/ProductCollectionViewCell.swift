//
//  ProductCollectionViewCell.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/15.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var productCountTxt: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    @IBAction func countStepper(_ sender: UIStepper) {
        productCountTxt.text = "\(Int(sender.value))"
    }
    
    
    @IBAction func addBuyListButtonPressed(_ sender: UIButton) {
        
        print("被按到拉")
    }
    
    
}
