//
//  Home.swift
//  tesDrop
//
//  Created by Zhipeng Mei on 3/12/16.
//  Copyright © 2016 Zhipeng Mei. All rights reserved.
//

import UIKit
import Parse
import M13PDFKit

class Home: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var tableView: UITableView!
    var path: String!
    
    var mediaArr: [PFObject]?
    var refreshControl:UIRefreshControl!

    let userDefaults = NSUserDefaults.standardUserDefaults()

    
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
        
        let query = PFQuery(className: "userData")
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
        let userImageFile = media["media"] as! PFFile
        
        path = userImageFile.url! as String
        print("this is path \(path)")
        //userDefaults.setValue(path, forKey: "pdfstring")

     
        let fileUrl = NSURL(string: path)
        cell.webView.loadRequest(NSURLRequest(URL: fileUrl!))

        
    
//                            let url = NSURL.fileURLWithPath(self.path)
//                            cell.webView.loadRequest(NSURLRequest(URL: url))
        
//        userImageFile.getDataInBackgroundWithBlock {
//            (imageData: NSData?, error: NSError?) -> Void in
//            if error == nil {
//                if let imageData = imageData {
//                    //let image = UIImage(data:imageData)
//                    //cell.profileImageView.image = image
//                    
//
//                }
//            }
        
            
            
        //}
        return cell
    }
    
    func refresh(sender: AnyObject) {
        let query = PFQuery(className: "userData")
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
    
    
    
    //******** testing PDF view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "pdfviewer"){
            //Create the document for the viewer when the segue is performed.
            let viewer: PDFKBasicPDFViewer = segue.destinationViewController as! PDFKBasicPDFViewer
            
            //Load the document (pdfUrl represents the path on the phone of the pdf document you wish to load)
            //let omgPath = userDefaults.stringForKey("pdfstring")

//
            
            
           // let document: PDFKDocument = PDFKDocument(contentsOfFile: "http://agile-tundra-85978.herokuapp.com/Parse/files/instaPicsjanlcw7i4r49r4f/a4e2224c79fb73cf54c0ff6e351f3d44_pdf.pdf", password: nil)
           // viewer.loadDocument(document)
        }
        
    }
    

    

}
