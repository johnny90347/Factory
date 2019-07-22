//
//  adDetailVC.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/11.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps


class adDetailVC: UIViewController,CLLocationManagerDelegate {
    
    
    @IBOutlet weak var googleMapView: GMSMapView!
    
    var DetailTVC:DetailTableViewController?
    var infoFormADinfoList:ADClientInfo?

    override func viewDidLoad() {
        super.viewDidLoad()

        
////        UIApplication.shared.openURL(URL(string:"https://www.google.com/maps/@42.585444,13.007813,6z")!)
//        //導航的
//        UIApplication.shared.openURL(URL(string:
//            "comgooglemaps://?saddr=Google+Inc,+8th+Avenue,+New+York,+NY&daddr=John+F.+Kennedy+International+Airport,+Van+Wyck+Expressway,+Jamaica,+New+York&directionsmode=transit")!)
//
        setDetailTxt()
        
       
        
        
        
        locationEncode()
        
        
    }
    
    
    
    
    
    //字串轉座標
    func locationEncode(){
        let geocoder = CLGeocoder()
        guard let address = infoFormADinfoList?.address else{return}
        geocoder.geocodeAddressString(address, completionHandler: {
           [weak self] (placemarks:[CLPlacemark]?, error:Error?) -> Void in
            guard let self = self else {return}
            
            if error != nil {
               print("错误：\(error!.localizedDescription))")
                return
            }
            if let p = placemarks?[0]{
                //從地址轉成座標
                let longitude = p.location!.coordinate.longitude
                let latitude = p.location!.coordinate.latitude
                
                
                //利用googleMap在UIview上顯示地圖
                let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 15)
                self.googleMapView.camera = camera
                
                let maker = GMSMarker()
                maker.position = CLLocationCoordinate2D(latitude: latitude, longitude:  longitude)
                maker.map = self.googleMapView
                maker.title = self.infoFormADinfoList!.clientName
                maker.icon = GMSMarker.markerImage(with: .blue)
                
                
                
                
            }
        })
    }
    
    
    //MARK:- 取得containView 的 controller 存入變數  DetailTVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "moreDetial"{
                DetailTVC = segue.destination as? DetailTableViewController
                DetailTVC?.infoFormADDetial = infoFormADinfoList
        }
    }
    
    func setDetailTxt(){
        DetailTVC?.clientNameLabel.text = infoFormADinfoList?.clientName
        DetailTVC?.phoneNumberLabel.text = infoFormADinfoList?.phoneNumber
        DetailTVC?.addressLabel.text = infoFormADinfoList?.address
        if infoFormADinfoList?.supplement == "" {
             DetailTVC?.supplementLabel.text = "無"
        }else{
             DetailTVC?.supplementLabel.text = infoFormADinfoList?.supplement
        }
       
    }
    
    


}
