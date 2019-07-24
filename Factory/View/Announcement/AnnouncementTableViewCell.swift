//
//  AnnouncementTableViewCell.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/22.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit
import FirebaseAuth

class AnnouncementTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backGroundView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backGroundView.layer.cornerRadius = 15
       
    }

    
    
    func cellConfigure(Txt:AnnouncementInfo){
        nameLabel.text = Txt.announcer
        contentLabel.text = Txt.contentTxt
        
        let timeStamp = Txt.timeStamp
        let date = timeStamp.dateValue()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/M/d    H:m"
        timeLabel.text = formatter.string(from: date)
        
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        if Txt.userID == uid{
            backGroundView.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
//            backGroundView.transform = CGAffineTransform(rotationAngle: .pi)
//            backGroundView.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        
    }
 
}
