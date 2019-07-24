//
//  ProductCollectionViewCell.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/15.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit


struct PurchasedItem {
    var productName:String
    var price:Int
    var count:Int
    var imageAddress:String
}

protocol ShoppingCarDelegate:NSObjectProtocol {
    func pruchasedItemInfo(item:PurchasedItem)
}

protocol showAlertDelegate:NSObjectProtocol {
    func showAlert()
}

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var productCountTxt: UITextField!
    
    @IBOutlet weak var cellBackGroundView: UIView!
    
    @IBOutlet weak var addProductButtonOutlet: UIButton!
    
    @IBOutlet weak var stepperOutlet: UIStepper!
    
    

    weak var delegate:ShoppingCarDelegate?
    weak var alertDelegate:showAlertDelegate?
    
    var photoAddress:String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellBackGroundView.layer.cornerRadius = 10
        productImageView.layer.cornerRadius = 10
        productImageView.layer.masksToBounds = true
        productImageView.clipsToBounds = true
        
        addProductButtonOutlet.layer.cornerRadius = 10
        addProductButtonOutlet.layer.masksToBounds = true
        
        
    }
    
    
   
    
    @IBAction func countStepper(_ sender: UIStepper) {
    
        productCountTxt.text = "\(Int(sender.value))"
        
        
        
    }
    
    
    @IBAction func addBuyListButtonPressed(_ sender: UIButton) {
        
        //輸入的數字不能是0
        if productCountTxt.text != "0"{
            guard  let name = productNameLabel.text,
                let price = priceLabel.text,
                let count = productCountTxt.text,
                let photoAddress = self.photoAddress
                else { return }
            
            let pruchased = PurchasedItem(productName: name, price:Int(price)!, count: Int(count)!,imageAddress:photoAddress )
            delegate?.pruchasedItemInfo(item: pruchased)
            
            productCountTxt.text = "0"
            stepperOutlet.value = 0
            
        }else{
            alertDelegate?.showAlert()
        }
        
        
      
        
        
    }
    //新增一個快取 目的是解決 每次滾到cell時 就要重新下載一次照片
    
    func configureCell(Info:ProductInfo){
        productNameLabel.text = Info.productName  //產品名子
        priceLabel.text = Info.price              //價格
        
        let address = Info.photoAddress           //圖片的urlString
        photoAddress = address
        
        
        productImageView.image = nil         //沒有圖片時 先設定nil
        if let url = URL(string: address){
            
           let task = URLSession.shared.dataTask(with: url) {[weak self] (data, urlResponse, error) in
                guard let self = self else {return}
                if error != nil{
                    print("下載圖片失敗")
                    return
                }
                guard let okData = data else{return}
                let image = UIImage(data: okData)
                DispatchQueue.main.async {
                    self.productImageView.image = image
                }
   
            }
          task.resume()
            
        
            }
          
        
    }
    
    
  
    
}
