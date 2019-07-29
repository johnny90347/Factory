//
//  ShoppingCarTableViewCell.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/18.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit
import SDWebImage


class ShoppingCarTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var productPhotoImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    func configureCell(item:PurchasedItem) {
        productNameLabel.text = item.productName
        countLabel.text = String(item.count)
        priceLabel.text = String(item.price)
        
        
        
        
       
        
        let urlString = item.imageAddress
        
        
        guard let url = URL(string: urlString) else {return}
        productPhotoImageView.sd_setImage(with: url, completed: nil)
//        let task =  URLSession.shared.dataTask(with: url) {[weak self] (data, urlResponse, error) in
//            guard let self = self else {return}
//            if error != nil{
//                return
//            }
//        if let data = data{
//            if let image = UIImage(data: data) {
////                imageCache.setObject(image, forKey:urlString as AnyObject )
//                DispatchQueue.main.async {
//                    self.productPhotoImageView.image = image
//                }
//            }
//
//        }
//
//        }
//        task.resume()
    }

}
