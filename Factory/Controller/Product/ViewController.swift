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



extension ViewController:ShoppingCarDelegate,showAlertDelegate,pruchasedItemsChangeDelegate {
    
    //代理 實作的方法 - 使用者進入購物車 刪除物品後,把購物清單傳回來
    func itemChange(_ shoppingCarVC:ShoppingCarVC,_ pruchasedItems: [PurchasedItem]) {
        self.pruchasedItems = pruchasedItems
        shoppingCarContentCntLabel.text = "\(pruchasedItems.count)"
    }
    
    //從cell傳來購物名單 要加入到上面的購物車
    func pruchasedItemInfo(item: PurchasedItem) {
        pruchasedItems.append(item)     //append到購物清單
        shoppingCarContentCntLabel.text = "\(pruchasedItems.count)"  //顯示有幾筆資料
        showAlert(message: "已加入購物車")   //跳出通知
    }
    
    //代理秀出警告控制器的方法
    //FIXME: 用找到最前面的 controller 來解決 （上網找）
    func showAlert() {
        showAlert(message: "數量不能是0")
    }
    
    
}



class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate{
    
    
    //MARK: - outlet區
    
    
    
    @IBOutlet weak var shoppingCarContentCntLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
//    @IBOutlet weak var scrollView: UIScrollView!
//    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var topView: UIView!
    
    
    let topIntroductionView = UIView()
    
    
    
    //MARK: - 宣告變數常數區
    
    var pruchasedItems:[PurchasedItem] = []  //購物清單  裝購物的資料 一開始是空的
    
    var productInfos = [ProductInfo]()  //儲存從伺服器存下來的資料
    
    var lintener:ListenerRegistration?  //監聽使用者資料
    
    var userIsOnline:Bool = false  //判斷使用者是否在線上 (進入購物車時會用到）
    
    let openingView = UIView()         //做開場動畫的view
    let openImageVie = UIImageView()   //做開場動畫的view
    
    var authListener:AuthStateDidChangeListenerHandle! //監聽使用者在不在線上
    
   
    
    //MARK: - 生命週期區
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        topIntroductionView.frame = CGRect(x: 0, y: topView.frame.maxY, width: view.frame.width, height: 200)
        topIntroductionView.backgroundColor = .blue
        view.addSubview(topIntroductionView)
        view.insertSubview(topIntroductionView, belowSubview: topView)
        topIntroductionView.layer.masksToBounds = true
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        topIntroductionView.addSubview(imageView)
        imageView.image = UIImage(named: "1")
        imageView.contentMode = .scaleAspectFill
        
        
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
//        scrollView.delegate = self
        
        setProductListener() //取得產品資訊
        
        openingViewConfigure() //開場畫面
        openingAnimate()  //開場動畫
        
        self.collectionView.contentInset = UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0)
        
        
    }
    var translation:CGFloat = 0

    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         translation = scrollView.contentOffset.y + 200

          topIntroductionView.frame = CGRect(x:0, y: 120 - translation, width: topIntroductionView.frame.width, height: 200)
        
    }
    
  
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        
       authListener = Auth.auth().addStateDidChangeListener {[weak self] (auth, user) in
        guard let self = self else {return}
            if user != nil {
                self.userIsOnline = true
            }else{
                self.userIsOnline = false
            }
        }
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
//        collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        
        //autolayout的原因 才要放在這
        //        creatImageView()
        
        //生出一個View 這是要順著collectionView往上推而伸縮的
 
        
        
       

        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(authListener) //取消監聽使用者
        print("viewcontroller disappear")
    }
    
    
    deinit {
        print("Viewcontroller deinit")
    }
    
    
    
    
    
    
    //MARK: - 連結到storyboard的互動區

    //進入購物車的按鈕
    
    @IBAction func gotoShoppingCarButtonPressed(_ sender: UIButton) {
        
        //確認是否在登陸狀態
        if userIsOnline == false{
              showAlert(message: "要登入才可以買東西喔！")
        }else{
            if self.pruchasedItems.count != 0{
                self.performSegue(withIdentifier: "gotoShoppingCar", sender: self)
            }else{
                self.showAlert(message: "購物車是空的喔")
            }
        }
    }
    
    
    
//    @IBAction func pageControlChange(_ sender: UIPageControl) {
//        let currentPageNumber = sender.currentPage
//        let width = scrollView.frame.width
//        scrollView.contentOffset = CGPoint(x: width * CGFloat(currentPageNumber), y: 0)
//    }
    
    
    
    
    //MARK: - scroll View delegate
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
//        pageControl.currentPage = Int(pageNumber)
//
//    }
    
    
    
    
    
    
    //MARK:- collectionView 的 datasorce
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return productInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        cell.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        cell.configureCell(Info: productInfos[indexPath.item])
        
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(cellOperating(sender:)))
        longPress.minimumPressDuration = 0.5 //按一秒判斷為長按
        cell.addGestureRecognizer(longPress)
        
        cell.delegate = self
        cell.alertDelegate = self
        
        return cell
    }
    
    //MARK:- collectionView 的 delegate
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width ) / 2
        return CGSize(width: width, height: 350)
    }
    
    

   
    
    //MARK: - 方法區
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoShoppingCar"{
           let vc = segue.destination as! ShoppingCarVC
            vc.pruchasedItemsFormVC = pruchasedItems
            vc.itemChangeDelegate = self
        }
    }
    
    
//    //在scrollView上 添加imageView
//    func creatImageView(){
//        var images = ["0","1","2"]
//        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
//        for index in 0..<images.count{
//            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
//            frame.size = scrollView.frame.size
//
//            let imageView = UIImageView(frame: frame)
//            imageView.image = UIImage(named: images[index])
//            imageView.contentMode = .scaleAspectFill
//            self.scrollView.addSubview(imageView)
//
//        }
//
//        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width)*CGFloat(images.count), height: scrollView.frame.size.height)
//
//    }
    
    
    
    


    
    
    
    //警告控制器
    func showAlert(item:Int){
        let alert = UIAlertController(title: "你確定要刪除他嗎？", message: "", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "確定", style: .default) {[weak self] (action) in
            guard let self = self else {return}
    Firestore.firestore().collection("product").document(self.productInfos[item].documentID).delete()
            print("被刪掉了")
        }
        alert.addAction(action)
        let cancelAction = UIAlertAction(title: "取消", style: .destructive, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    //警告控制器 通用
    func showAlert(message:String){
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "確認", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
 
    @objc func cellOperating(sender:UILongPressGestureRecognizer){
        //點擊
       let touchPoint = sender.location(in: self.collectionView)
        if sender.state == UIGestureRecognizer.State.began{
            if let indexPath = self.collectionView.indexPathForItem(at: touchPoint){
                showAlert(item: indexPath.item)
                print(indexPath.item)
                
            }
            
        }
    }
    

    //取得產品資訊
    func setProductListener(){
       lintener = Firestore.firestore().collection("product").order(by: "timeStamp", descending: true).addSnapshotListener {[weak self] (querySnapshot, error) in
            guard let self = self else {return}
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

