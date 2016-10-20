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
import TagListView

class DetailViewController: UITableViewController {
    
    var selectedGif: Gif?
    let imageView: AnimatedImageView = AnimatedImageView()
    var headerView: UIView!
    @IBOutlet weak var tagListView: TagListView!

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
        
        tagListView.textFont = UIFont.boldSystemFont(ofSize: 18)
        for tag in (selectedGif?.tags)!{
            tagListView.addTag(tag)
        }
        
        let likeButton = UIBarButtonItem(title: "Like", style: .done, target: self, action: #selector(likeGif))
        self.navigationItem.rightBarButtonItem = likeButton
        
    }

    @IBAction func btnShareGif(_ sender: UIButton) {
        
        let gif = imageView.imageView.animatedImage.data
        let shareData: NSData = NSData(data: gif!)
        let firstActivityItem: Array = [shareData]

                
        //Removed cast to AnyObject in the Function Call to get rid of error from removing it above
        let activityVC = UIActivityViewController(activityItems: firstActivityItem , applicationActivities: nil)
        
        
        //Moved cast for as! UIView outside the perantheses of sender so
        //that the as! can be used more efficiently. But most importantly
        // I changed the as! to a as? instead thinking that might catch an error and it did... so this works.
        activityVC.popoverPresentationController?.sourceView = (sender) as UIView
        self.present(activityVC, animated: true, completion: nil)
    }

    @IBAction func btnCopyGifURL(_ sender: UIButton) {
        let gifToShare = selectedGif?.shareUrl!
        UIPasteboard.general.string = gifToShare
        
        let alertController = UIAlertController(title: "Gelukt!", message:
            "U heeft de URL naar de gif succesvol naar het klembord gekopieerd!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Oke", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
}
