//
//  ViewController.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/6/26.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth




class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
 
    
    var productInfos = [ProductInfo]()
    var lintener:ListenerRegistration?
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    
    
    
    
    let openingView = UIView()         //做開場動畫的view
    let openImageVie = UIImageView()
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width ) / 2
        return CGSize(width: width, height: 350)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        openingViewConfigure() //開場畫面
        
       
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
         setProductListener() //取得產品資訊
    }
       
    
    override func viewDidDisappear(_ animated: Bool) {
        if lintener != nil{
            lintener?.remove()
        }
    }
    
    
//    "productName" : self.productNameTxt.text!,
//    "price" :  self.productPriceTxt.text!,
//    "picture" : url!.absoluteString
    
    
    //取得產品資訊
    func setProductListener(){
       lintener = Firestore.firestore().collection("product").addSnapshotListener { (querySnapshot, error) in
            if error != nil{
                print(error!.localizedDescription)
                return
            }
            self.productInfos.removeAll()  //每次有更新 先移除原本的array
            guard let  documents = querySnapshot?.documents else{return}
            for document in  documents{
                let documentID = document.documentID
                let data = document.data()
                guard
                let ProductName = data["productName"] as? String,
                let price = data["price"] as? String,
                let photoAddress = data["picture"] as? String
                else{return}
                
                let info =  ProductInfo(productName: ProductName, price: price, photoAddress: photoAddress, documentID: documentID)
                self.productInfos.append(info)
                self.collectionView.reloadData()
                
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        openingAnimate()  //開場動畫

        //確認是否在登陸狀態
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                print("有在登入狀態")
            }else{
                print("沒有在登入狀態")
            }
        }
        
    }
    
    
    
    //MARK:- collectionView 的 datasorce
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        cell.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        cell.configureCell(Info: productInfos[indexPath.item])
        return cell
    }
    
    
    
    //MARK:- 開場動畫設置
    
    
    func openingViewConfigure(){
        //一隻藍色的小鳥圖案
        openingView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        openingView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        view.addSubview(openingView)
        
        openImageVie.frame = CGRect(x: 0, y: 0, width: 150 , height: 150)
        openImageVie.image = UIImage(named: "openLogo")
        openImageVie.center = view.center
        openingView.addSubview(openImageVie)
      
    }
    
    
    
    func openingAnimate(){
        //動畫內容：先縮小再放大 ->消失
        UIView.animate(withDuration: 0.5, animations: {
            self.openImageVie.frame = CGRect(x: 0, y: 0, width: 90, height: 90)
            self.openImageVie.center = self.view.center
            
        }) { (finished) in
            
            UIView.animate(withDuration: 0.5, animations: {
                self.openImageVie.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
                self.openImageVie.center = self.view.center
                self.openingView.alpha = 0
                
            })
            
        }
        
    }


}

