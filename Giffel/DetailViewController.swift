//
//  DetailViewController.swift
//  Giffel
//
//  Created by Tom Bakker on 05-10-16.
//  Copyright © 2016 Fontys. All rights reserved.
//

import UIKit
import Nuke
import NukeFLAnimatedImagePlugin

class DetailViewController: UITableViewController {
    
    var selectedGif: Gif?
    let imageView: AnimatedImageView = AnimatedImageView()
    var headerView: UIView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView = tableView.tableHeaderView
        
        //Adds an animated imageview to header
        headerView.addSubview(imageView)
        imageView.frame = headerView.bounds
        imageView.autoresizingMask =  [.flexibleWidth, .flexibleHeight]
        
        let urlString = "https:" + (selectedGif?.imageUrl)!
        let url: URL = URL(string: urlString)!
        let urlRequest = Request(url: url)
        
        AnimatedImage.manager.loadImage(with: urlRequest, into: imageView)
        
        let imageWidth = (imageView.imageView.image?.size.width)!
        let screenWidth = headerView.frame.size.width
        let ratio = screenWidth / imageWidth
        
        headerView.bounds = CGRect(x: headerView.frame.origin.x, y: headerView.frame.origin.y, width: headerView.frame.size.width, height: (imageView.imageView.image?.size.height)! * ratio)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
