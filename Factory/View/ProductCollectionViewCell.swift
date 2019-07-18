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
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    func configureCell(Info:ProductInfo){
        productNameLabel.text = Info.productName  //產品名子
        priceLabel.text = Info.price              //價格
        
        let address = Info.photoAddress           //圖片的urlString
        photoAddress = address
        
        //如果用key:urlString 去快取 Image ,如果image存在了話 就放在imageview並且return ,不再執行下面的下載了
        if let imageFromCache = imageCache.object(forKey: address as AnyObject) as? UIImage{
            self.productImageView.image = imageFromCache
            return  //有快取到圖片就return
        }
        
        productImageView.image = nil              //沒有圖片時 先設定nil
        //走到這邊就是 key:urlString 取不到值
        if let url = URL(string: address){
            //分配給global
            DispatchQueue.global().async {
                do{
                    //這個是同步下載資料
                    let data = try Data(contentsOf: url)
                    let imageToCache = UIImage(data: data) //data轉圖片
                    
                    //儲存照片到快取裡面。key用urlString  所以一個key(urlString)就有一個 imageData
                    self.imageCache.setObject(imageToCache!, forKey: address as AnyObject)
                    DispatchQueue.main.async {
                        self.productImageView.image = imageToCache
                    }
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
          
        }
    }
    
    
  
    
}
