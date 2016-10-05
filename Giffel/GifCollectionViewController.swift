//
//  GifCollectionViewController.swift
//  Giffel
//
//  Created by Tom Bakker on 04-10-16.
//  Copyright © 2016 Fontys. All rights reserved.
//

import UIKit
import Nuke
import NukeFLAnimatedImagePlugin

private let reuseIdentifier = "Cell"

class GifCollectionViewController: UICollectionViewController {
    
    private var gifs = [Gif]()
    var manager = Nuke.Manager.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        GiffelAPI.retrievePopular { (results) -> (Void) in
            self.gifs = results
            self.collectionView?.reloadData()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        collectionView?.register(GifCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if let viewController = segue.destination as? DetailViewController {
            if let cell = sender as? GifCollectionViewCell {
                let indexPath = collectionView?.indexPath(for: cell)
                viewController.selectedGif = gifs[(indexPath?.item)!]
            }
            
            //viewController.selectedGif = gifs[collectionView?.selectedItem]
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifs.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GifCollectionViewCell
        
        let gif = gifs[indexPath.item]
        
        let urlString = "https:" + gif.imageUrl!
        let url: URL? = URL(string: urlString)
        let request: Request = Request(url: url!)
        
        cell.activityIndicator.startAnimating()
        
        cell.activityIndicator.startAnimating()
        AnimatedImage.manager.loadImage(with: request, into: cell.imageView) { [weak cell] in
            cell?.activityIndicator.stopAnimating()
            cell?.imageView.handle(response: $0, isFromMemoryCache: $1)
        }
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "show", sender: collectionView.cellForItem(at: indexPath))
    }

}
