//
//  CustomTableViewCell.swift
//  testing
//
//  Created by Vido Valianto on 3/1/19.
//  Copyright © 2019 Vido Valianto. All rights reserved.
//

import UIKit
import Cosmos

class CustomTableViewCell: UITableViewCell {

//    let imgUser = UIImageView()
//    let labUerName = UILabel()
//    let labMessage = UILabel()
//    let labTime = UILabel()
    
    let imgBook = UIImageView()
//    let imgBook = UILabel()
    let judulLbl = UILabel()
    let authorLbl = UILabel()
    let ratingLbl = UILabel()
    
    let descriptor1Lbl = UILabel()
    let descriptor2Lbl = UILabel()
    let descriptor3Lbl = UILabel()
    let cosmosView = CosmosView()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imgBook.translatesAutoresizingMaskIntoConstraints = false
        judulLbl.translatesAutoresizingMaskIntoConstraints = false
        authorLbl.translatesAutoresizingMaskIntoConstraints = false
        ratingLbl.translatesAutoresizingMaskIntoConstraints = false
        cosmosView.translatesAutoresizingMaskIntoConstraints = false
        
        descriptor1Lbl.translatesAutoresizingMaskIntoConstraints = false
        descriptor2Lbl.translatesAutoresizingMaskIntoConstraints = false
        descriptor3Lbl.translatesAutoresizingMaskIntoConstraints = false

        
        
        
        judulLbl.font = UIFont(name: "AvenirNextCondensed-Regular", size: 12)!
        authorLbl.font = UIFont(name: "AvenirNextCondensed-Regular", size: 12)!
        
        descriptor1Lbl.text = "Judul"
        descriptor2Lbl.text = "Author"
        descriptor3Lbl.text = "Rating"
        
        descriptor1Lbl.font = UIFont(name:"AvenirNextCondensed-Bold", size: 16.0)
        descriptor2Lbl.font = UIFont(name:"AvenirNextCondensed-Bold", size: 16.0)
        descriptor3Lbl.font = UIFont(name:"AvenirNextCondensed-Bold", size: 16.0)
        
        
        contentView.addSubview(imgBook)
        contentView.addSubview(descriptor1Lbl)
        contentView.addSubview(judulLbl)
        contentView.addSubview(descriptor2Lbl)
        contentView.addSubview(authorLbl)
        contentView.addSubview(descriptor3Lbl)
        contentView.addSubview(ratingLbl)
        contentView.addSubview(cosmosView)
        
        let viewsDict = [
            "image" : imgBook,
            "judul" : judulLbl,
            "author" : authorLbl,
            "rating" : ratingLbl,
            "srating" : cosmosView,
            "desc1" : descriptor1Lbl,
            "desc2" : descriptor2Lbl,
            "desc3" : descriptor3Lbl
            ] as [String : Any]
        
//        if(!self.imgBook.bounds.size.width.isNaN){
//            let aspect = self.imgBook.bounds.size.width / self.imgBook.bounds.size.height
//            contentView.addConstraints([NSLayoutConstraint(item: imgBook, attribute:  NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: imgBook, attribute: NSLayoutAttribute.height, multiplier: aspect, constant: 0.0)])
//        }
        
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[desc1]-[judul]-[desc2]-[author]-[desc3]-[rating]-[srating]-|", options: [], metrics: nil, views: viewsDict))


        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[author]-[image(100)]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[judul]-[image]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[rating]-[image]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[srating]-[image]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[desc1]-[image]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[desc2]-[image]-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[desc3]-[image]-|", options: [], metrics: nil, views: viewsDict))
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


