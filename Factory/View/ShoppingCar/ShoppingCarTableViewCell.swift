//
//  ShoppingCarTableViewCell.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/18.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit

class ShoppingCarTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var productPhotoImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    func configureCell(item:PurchasedItem) {
        productPhotoImageView.image = item.image
        productNameLabel.text = item.productName
        countLabel.text = String(item.count)
        priceLabel.text = String(item.price)
        
    }

}
