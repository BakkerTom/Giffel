//
//  GifCollectionViewCell.swift
//  Giffel
//
//  Created by Tom Bakker on 04-10-16.
//  Copyright © 2016 Fontys. All rights reserved.
//

import UIKit
import NukeFLAnimatedImagePlugin

class GifCollectionViewCell: UICollectionViewCell {
    
    let imageView: AnimatedImageView
    let activityIndicator: UIActivityIndicatorView
    
    override init(frame: CGRect){
        imageView = AnimatedImageView()
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        
        super.init(frame: frame)
        
        imageView.imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        contentView.addSubview(imageView)
        contentView.backgroundColor = UIColor(red: 244.0/255.0, green: 245.0/255.0, blue: 248.0/255.0, alpha: 1.0)
        
        imageView.frame = contentView.bounds
        imageView.autoresizingMask =  [.flexibleWidth, .flexibleHeight]
        
        contentView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraint(NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1.0, constant: 0.0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.imageView.animatedImage = nil
    }
}
