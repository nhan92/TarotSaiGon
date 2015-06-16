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
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
            
        var query = PFQuery(className: "DataBook")
            
            let userDefault = NSUserDefaults.standardUserDefaults()
           
            if let arrFileNameDownloaded: AnyObject = userDefault.objectForKey("fileDownload")
            {
                var readArray: [NSString] = arrFileNameDownloaded as! [NSString]
                
                query.whereKey("FullName", notContainedIn: readArray)
            }
        
            
        query.findObjectsInBackgroundWithBlock {(objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                
                
//                let userDefault = NSUserDefaults.standardUserDefaults()
//                var arrFile:[PFObject] = []
//                
//              //  NSArray *arr = (NSArray *) objects;
//                
//                
//                var newArray = objects as AnyObject! as! Array<PFObject>
//             
//                for obj in newArray
//                {
//                    let nameFile :String = obj["FullName"] as! String
//                    
//                    let isDownloaded: AnyObject? = userDefault.objectForKey(nameFile)
//                    
//                    if isDownloaded == nil
//                    {
//                        arrFile.append(obj as PFObject)
//                    }
//                }
                
                self.arrlist = objects
            }
            self.tableView.reloadData()
            
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
            
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
      
        selected = arrlist[indexPath.row] as! PFObject
        let daBook: PFFile = selected["file"] as! PFFile
        let daBookName: String = selected["FullName"] as! String
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

                
            }else {
                println("file already exitence")
            }
            
            // Hide
            MBProgressHUD.hideHUDForView(UIApplication.sharedApplication().keyWindow, animated: true)
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
