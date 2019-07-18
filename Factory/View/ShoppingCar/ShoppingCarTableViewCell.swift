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
        productNameLabel.text = item.productName
        countLabel.text = String(item.count)
        priceLabel.text = String(item.price)
        
        
        
        
       
        
        let urlString = item.imageAddress
        
//        let imageCache = NSCache<AnyObject, AnyObject>()
//
//        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
//                productPhotoImageView.image = imageFromCache
//            return
//        }
//
        
        guard let url = URL(string: urlString) else {return}
        let task =  URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
            if error != nil{
                return
            }
        if let data = data{
            if let image = UIImage(data: data) {
//                imageCache.setObject(image, forKey:urlString as AnyObject )
                DispatchQueue.main.async {
                    self.productPhotoImageView.image = image
                }
            }
            
        }
        
        }
        task.resume()
    }

}
