//
//  Home.swift
//  tesDrop
//
//  Created by Zhipeng Mei on 3/12/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit
import Parse

class Home: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    
    var mediaArr: [PFObject]?
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.estimatedRowHeight = 220.0
        //tableView.rowHeight = 520;
        
        //tableView.rowHeight = UITableViewAutomaticDimension
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        let query = PFQuery(className: "UserMedia")
        query.orderByDescending("_created_at")
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if media != nil {
                self.mediaArr = media
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mediaArr != nil {
            return mediaArr!.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("homeTableViewCell", forIndexPath: indexPath) as! homeTableViewCell
        let media = mediaArr![indexPath.row]
        cell.imageLabel.text = media["caption"] as? String
//        let userImageFile = media["media"] as! PFFile
//        
//        userImageFile.getDataInBackgroundWithBlock {
//            (imageData: NSData?, error: NSError?) -> Void in
//            if error == nil {
//                if let imageData = imageData {
//                    let image = UIImage(data:imageData)
//                    cell.profileImageView.image = image
//                }
//            }
//        }
        return cell
    }
    
    func refresh(sender: AnyObject) {
        let query = PFQuery(className: "UserMedia")
        query.orderByDescending("_created_at")
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if media != nil {
                self.mediaArr = media
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
        self.refreshControl.endRefreshing()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.refresh(tableView)
    }

}
