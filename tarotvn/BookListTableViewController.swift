//
//  BookListTableViewController.swift
//  tarotvn
//
//  Created by Nhan Nguyen on 5/21/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit
import Parse

class BookListTableViewController: UITableViewController {
    
    var arrlist: [AnyObject]!
    var selected: PFObject!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        arrlist = []
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
            var query = PFQuery(className: "DataBook")
            let userDefault = NSUserDefaults.standardUserDefaults()
           
            if let arrFileNameDownloaded: AnyObject = userDefault.objectForKey("fileDownload")
            {
                var readArray: [NSString] = arrFileNameDownloaded as! [NSString]
                query.whereKey("FullName", notContainedIn: readArray)
            }
        ///add to dislay
        if let arrFileNameDownloadedDislay: AnyObject = userDefault.objectForKey("fileDownloadDislay")
        {
            var readArrayDislay: [NSString] = arrFileNameDownloadedDislay as! [NSString]
            query.whereKey("name", notContainedIn: readArrayDislay)
        }
        ////
        
        query.findObjectsInBackgroundWithBlock {(objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                
                self.arrlist = objects
            }
            
            self.tableView.reloadData()
            
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
        
       
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onCreatedNotification", name: "reloadListBooks" , object: nil)
        
    }
    
    func onCreatedNotification()
    {
        arrlist = []
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        var query = PFQuery(className: "DataBook")
        let userDefault = NSUserDefaults.standardUserDefaults()
        
        if let arrFileNameDownloaded: AnyObject = userDefault.objectForKey("fileDownload")
        {
            var readArray: [NSString] = arrFileNameDownloaded as! [NSString]
            query.whereKey("FullName", notContainedIn: readArray)
        }
        
        ///add to dislay
        if let arrFileNameDownloadedDislay: AnyObject = userDefault.objectForKey("fileDownloadDislay")
        {
            var readArrayDislay: [NSString] = arrFileNameDownloadedDislay as! [NSString]
            query.whereKey("name", notContainedIn: readArrayDislay)
        }
        ////
        
        query.findObjectsInBackgroundWithBlock {(objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                
                self.arrlist = objects
            }
            
            self.tableView.reloadData()
            
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
        
        //self.tableView.reloadData()
    }
   /////get data from Parse.com
    

    

    ////

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return arrlist.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookList", forIndexPath: indexPath) as! UITableViewCell

        var nameBook: PFObject = arrlist[indexPath.row] as! PFObject
        
        // Configure the cell...
        cell.textLabel?.text =  nameBook["name"] as? String
        

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
        //alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
        
        
        
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { action in
            switch action.style{
            case .Default:
                println("default")
                
                self.selected = self.arrlist[indexPath.row] as! PFObject
                let daBook: PFFile = self.selected["file"] as! PFFile
                let daBookName: String = self.selected["FullName"] as! String
                let daBookNameDislay: String = self.selected["name"] as! String
                var checkValidation = NSFileManager.defaultManager()
                
                
                ///
                var myHUb:MBProgressHUD =  MBProgressHUD.showHUDAddedTo(UIApplication.sharedApplication().keyWindow, animated: true)
                myHUb.labelText = "Downloading";
                myHUb.dimBackground = true;
                
                ///
                
                daBook.getDataInBackgroundWithBlock { (fileTarot: NSData?, error: NSError?) -> Void in
                    let dirPaths = NSSearchPathForDirectoriesInDomains( .DocumentDirectory, .UserDomainMask, true)
                    let docsDir = dirPaths[0] as! String
                    let databasePath: String = String(format: "%@/%@", arguments: [docsDir, daBookName])
                    
                    NSLog("dataPath = %@", databasePath)
                    
                    fileTarot?.writeToFile(databasePath, atomically: true)
                    
                    
                    if (checkValidation.fileExistsAtPath(databasePath))
                    {
                        
                        self.arrlist.removeAtIndex(indexPath.row)
                        tableView.reloadData()
                        
                        let userDefault = NSUserDefaults.standardUserDefaults()
                        //userDefault.setObject(NSNumber(bool: true), forKey: daBookName)
                        
                        if let arrFileNameDownloaded: AnyObject = userDefault.objectForKey("fileDownload")
                        {
                            var readArray:[NSString] = arrFileNameDownloaded as! [NSString]
                            
                            readArray.append(daBookName)
                            
                            userDefault.setObject(readArray, forKey: "fileDownload")
                        }
                        else
                        {
                            // NIl
                            var readArray:[NSString]  = []
                            readArray.append(daBookName)
                            
                            userDefault.setObject(readArray, forKey: "fileDownload")
                        }
                        
                        if let arrFileNameDownloadedDislay: AnyObject = userDefault.objectForKey("fileDownloadDislay")
                        {
                            var readArrayDislay:[NSString] = arrFileNameDownloadedDislay as! [NSString]
                            
                            readArrayDislay.append(daBookNameDislay)
                            
                            userDefault.setObject(readArrayDislay, forKey: "fileDownloadDislay")
                        }
                        else
                        {
                            // NIl
                            var readArrayDislay:[NSString]  = []
                            readArrayDislay.append(daBookNameDislay)
                            
                            userDefault.setObject(readArrayDislay, forKey: "fileDownloadDislay")
                        }

                        
                    }else {
                        println("file already exitence")
                    }
                    
                    // Hide
                    MBProgressHUD.hideHUDForView(UIApplication.sharedApplication().keyWindow, animated: true)
                }
                
            case .Cancel:
                println("cancel")
                
            case .Destructive:
                println("destructive")
            }
            
        }))
        
        let cancel = UIAlertAction(title: "cancel", style: .Cancel, handler: {
            action in
            
            self.tableView.reloadData()
            
        })
        
        alert.addAction(cancel)
        
        self.presentViewController(alert, animated: true, completion: nil)
       
    }

   

}
