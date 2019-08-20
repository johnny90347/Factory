//
//  AnnouncementTableViewCell.swift
//  Factory
//
//  Created by 梁鑫文 on 2019/7/22.
//  Copyright © 2019 HsinWen. All rights reserved.
//

import UIKit
import FirebaseAuth



class TriangleView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    var fillcolor = UIColor.orange.cgColor
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.minY))
        context.closePath()
        
        //        context.setFillColor(red: 1.0, green: 0.5, blue: 0.0, alpha: 0.60)
        context.setFillColor(fillcolor)
        context.fillPath()
    }
}

class AnnouncementTableViewCellOne: UITableViewCell {
    
//    @IBOutlet weak var backGroundView: UIView!
    
//    @IBOutlet weak var nameLabel: UILabel!
    
//    @IBOutlet weak var timeLabel: UILabel!
    
//    @IBOutlet weak var contentLabel: UILabel!
    
    
    
    var info:AnnouncementInfo?{
        didSet{
            contentLabel.text = info?.contentTxt
        }
    }
    
    
    let userImage:UIImageView = {
        let imageview = UIImageView()
        imageview.backgroundColor = .green
        imageview.layer.cornerRadius = 30
        imageview.clipsToBounds = true
        imageview.image = UIImage(named: "girl")
        imageview.contentMode = UIImageView.ContentMode.scaleAspectFit
        return  imageview
    }()
    
    let triangleView:TriangleView = {
        
        let triangle = TriangleView()
        triangle.backgroundColor = UIColor.clear
        triangle.transform = CGAffineTransform(rotationAngle: -.pi/2)
        
        return triangle
    }()
    
    let bubbleView:UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    let contentLabel:UILabel = {
        let label = UILabel()
        label.text = "內文"
        label.numberOfLines = 0
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
         setupCell()
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        backgroundView.layer.cornerRadius = 15
       
    }
    
    
    
    func setupCell(){
        
        self.addSubview(userImage)
        self.addSubview(triangleView)
        self.addSubview(bubbleView)
        bubbleView.addSubview(contentLabel)
        
        
        
        
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        userImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8 ).isActive = true
        userImage.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -10).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        triangleView.translatesAutoresizingMaskIntoConstraints = false
        triangleView.leadingAnchor.constraint(equalTo: userImage.trailingAnchor).isActive = true
        triangleView.topAnchor.constraint(equalTo: userImage.topAnchor,constant: 10).isActive = true
        triangleView.widthAnchor.constraint(equalToConstant: 13).isActive = true
        triangleView.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        
        
        bubbleView.translatesAutoresizingMaskIntoConstraints = false
        bubbleView.leadingAnchor.constraint(equalTo: triangleView.trailingAnchor).isActive = true
        bubbleView.topAnchor.constraint(equalTo: userImage.topAnchor).isActive = true
        bubbleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40).isActive = true
//        bubbleView.heightAnchor.constraint(equalTo:self.heightAnchor).isActive = true
        bubbleView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
        
        
        
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 8).isActive = true
        contentLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 8).isActive = true
        contentLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -8).isActive = true
        contentLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -8).isActive = true
        
    }
    
    
    

    
    
//    func cellConfigure(Txt:AnnouncementInfo){
//        nameLabel.text = Txt.announcer
//        contentLabel.text = Txt.contentTxt
//
//        let timeStamp = Txt.timeStamp
//        let date = timeStamp.dateValue()
//
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy/M/d    H:m"
//        timeLabel.text = formatter.string(from: date)
//
//
//
//    }
 
}



class AnnouncementTableViewCellTwo: UITableViewCell {
    
    
    var info:AnnouncementInfo?{
        didSet{
            contentLabel.text = info?.contentTxt
        }
    }
    
    
    


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let contentLabel:UILabel = {
        let label = UILabel()
        label.text = "內文"
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    
    
    let userImage:UIImageView = {
        let imageview = UIImageView()
        imageview.backgroundColor = .red
        imageview.layer.cornerRadius = 30
        imageview.clipsToBounds = true
        imageview.image = UIImage(named: "man")
        imageview.contentMode = UIImageView.ContentMode.scaleAspectFill
        return  imageview
    }()
    
    let triangleView:TriangleView = {
        let triangle = TriangleView()
        triangle.backgroundColor = UIColor.clear
        triangle.fillcolor = UIColor.blue.cgColor
        triangle.transform = CGAffineTransform(rotationAngle: .pi/2)
        return triangle
    }()
    
    let bubbleView:UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    
    func setupCell(){
        
        self.addSubview(userImage)
        self.addSubview(triangleView)
        self.addSubview(bubbleView)
        bubbleView.addSubview(contentLabel)
        
        
        
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: -68).isActive = true
        userImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8 ).isActive = true
        userImage.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -10).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        
        triangleView.translatesAutoresizingMaskIntoConstraints = false
        triangleView.trailingAnchor.constraint(equalTo: userImage.leadingAnchor).isActive = true
        triangleView.topAnchor.constraint(equalTo: userImage.topAnchor,constant: 8).isActive = true
        triangleView.widthAnchor.constraint(equalToConstant: 13).isActive = true
        triangleView.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        
        
        bubbleView.translatesAutoresizingMaskIntoConstraints = false
        bubbleView.trailingAnchor.constraint(equalTo: triangleView.leadingAnchor).isActive = true
        bubbleView.topAnchor.constraint(equalTo: userImage.topAnchor).isActive = true
        bubbleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
//        bubbleView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        bubbleView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
        
        
        
        
        
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 8).isActive = true
        contentLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 8).isActive = true
        contentLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -8).isActive = true
        contentLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -8).isActive = true
        
    }
}
