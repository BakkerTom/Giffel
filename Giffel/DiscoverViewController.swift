//
//  DiscoverViewController.swift
//  Giffel
//
//  Created by Tom Bakker on 06-10-16.
//  Copyright © 2016 Fontys. All rights reserved.
//

import UIKit

class DiscoverViewController: UITableViewController {

    var tags = [Tag]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load data
        loadData()
        
        self.refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    func loadData(){
        GiffelAPI.retrieveAllTags { (tags) -> (Void) in
            self.tags = tags
            self.tableView?.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tagCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = tags[indexPath.row].name
        cell.detailTextLabel?.text = String(tags[indexPath.row].taggings)
        
        return cell
    }



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination  as? GifCollectionViewController {
            viewController.tag = tags[(tableView.indexPathForSelectedRow?.row)!]
        }
    }

}
