//
//  ProductAddViewController.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/15.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD


class ProductAddViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var productImageView: UIImageView!
    
    @IBOutlet weak var productNameTxt: UITextField!
    
    @IBOutlet weak var productPriceTxt: UITextField!
    
    @IBOutlet weak var addButtonPress: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButtonPress.layer.cornerRadius = addButtonPress.frame.width / 2 
        addButtonPress.layer.masksToBounds = true
        
        //點擊照片加入圖片
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectedPicture))
        productImageView.addGestureRecognizer(tap)
        productImageView.isUserInteractionEnabled = true
        
    
        
        

        
    }
    
    
    
    
    @objc func selectedPicture(){
        //點擊照片跳出照片欄位
        let picker =  UIImagePickerController()
        picker.delegate = self //成為代理
        picker.allowsEditing = true //可以修改照片大小
        present(picker, animated: true, completion: nil) //跳出picker
    
    }
    
    
     var selectedImageFromPicker:UIImage?   //選到的照片
     var fileName = "image.JPG"             //建立一個檔案名 （上傳用）
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        //取得圖片有分有修改 跟沒修改
        if let editingImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            selectedImageFromPicker = editingImage
        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        //把圖片它存到上面方便取用
        if let selectedImage = selectedImageFromPicker {
            productImageView.image = selectedImage
        }
        
        
       //設定fileName
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL{
            fileName = url.lastPathComponent
        }
        
        //選好後就離開picker畫面
          picker.dismiss(animated: true, completion: nil)
       
    }
    
    
    
    
    //按下按鈕 上傳資料
    @IBAction func addProductButtonPressed(_ sender: UIButton) {
        SVProgressHUD.show()
        
        //存在storage的child檔名叫pic的下面
        let storeRef = Storage.storage().reference().child("pic")
        //轉換UIImage to DATA 並且 壓縮（會傳送比較快）（compressionQuality = 1 就是原大小）
        if let data = selectedImageFromPicker?.jpegData(compressionQuality: 0.5){
          let task = storeRef.child(fileName).putData(data, metadata: nil) { (metadata, error) in   //在pic下用檔名 傳送檔案
                if error != nil{
                    print("上傳失敗")
                    return
                }
            
            
                print("上傳成功")
                //上傳成功後
                //利用路徑取得下載圖片的url
                storeRef.child(self.fileName).downloadURL(completion: { (url, error) in
                    if error != nil{
                        print("url失敗")
                    }else{
                        //成功取得url
                        //開始建立資料商品資料（商品名稱,價格,照片）
                        Firestore.firestore().collection("product").addDocument(data: [
                            "productName" : self.productNameTxt.text!,
                            "price" :  self.productPriceTxt.text!,
                            "picture" : url!.absoluteString,
                            "timeStamp": FieldValue.serverTimestamp()

                        ]) { (error) in
                            if error != nil{
                                return
                            }else{
                                SVProgressHUD.dismiss()
                                self.navigationController?.popViewController(animated: true)
                            }
                            
                        }
    
                    }
                })
                
                
            }
            task.observe(.progress) { (storageTaskSnapshot) in
                if let progress = storageTaskSnapshot.progress?.fractionCompleted{
                    self.progressView.progress = Float(progress)
                }
            }
        }
    }
    
    //點空白處 收鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    

}
