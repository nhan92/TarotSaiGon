//
//  DownloadedTableViewController.swift
//  tarotvn
//
//  Created by Nhan Nguyen on 6/8/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit

class DownloadedTableViewController: UITableViewController {
   
    var arrDownloadedFile: [NSString] = []
    var arrDownloadedFileDislay: [NSString] = []
    var selectedFile:String!
    var indexPathOfDownloadedList: Int!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let userDefault = NSUserDefaults.standardUserDefaults()
        
        if let arrFileNameDownloaded: AnyObject = userDefault.objectForKey("fileDownload")
        {
            var readArray: [NSString] = arrFileNameDownloaded as! [NSString]
            
            arrDownloadedFile = readArray
        }
        
        if let arrFileNameDownloadedDislay: AnyObject = userDefault.objectForKey("fileDownloadDislay")
        {
            var readArrayDislay: [NSString] = arrFileNameDownloadedDislay as! [NSString]
            
            arrDownloadedFileDislay = readArrayDislay
        }

        self.tableView .reloadData()
    }
    
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
        return arrDownloadedFile.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        cell.textLabel?.text = arrDownloadedFileDislay[indexPath.row] as String
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        let name:String = arrDownloadedFile[indexPath.row] as String;
        indexPathOfDownloadedList = indexPath.row;
        
        selectedFile = name;
        
        if arrDownloadedFileDislay[indexPath.row] == "Runes"{
            
            self.performSegueWithIdentifier("pushDetailRunes", sender: nil)
        
        }else{
            
            self.performSegueWithIdentifier("pushDetailCard", sender: nil);
        }
    }

    override func  prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "pushDetailCard"{
        var destination:ViewController = segue.destinationViewController as! ViewController
        
        destination.nameFileDatabase = selectedFile
        destination.nameFileDatabaseIndexPaths = indexPathOfDownloadedList
        
        }else{
            
            var destinationRunes:ListCardViewRunesViewController = segue.destinationViewController as! ListCardViewRunesViewController
            
            destinationRunes.nameFileDatabase = selectedFile
            destinationRunes.nameFileDatabaseIndexPaths = indexPathOfDownloadedList

        }
    }
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            //self.tableView.reloadData()
            let userDefault = NSUserDefaults.standardUserDefaults()
            if let arrFileNameDownloaded: AnyObject = userDefault.objectForKey("fileDownload"){
                
                var readArray: [NSString] = arrFileNameDownloaded as! [NSString]
                readArray.removeAtIndex(indexPath.row)
                userDefault.setObject(readArray, forKey: "fileDownload")
            }
            
            if let arrFileNameDownloadedDislay: AnyObject = userDefault.objectForKey("fileDownloadDislay"){
                
                var readArrayDislay: [NSString] = arrFileNameDownloadedDislay as! [NSString]
                readArrayDislay.removeAtIndex(indexPath.row)
                userDefault.setObject(readArrayDislay, forKey: "fileDownloadDislay")
            }
            
            
            removeData(arrDownloadedFile[indexPath.row] as String)
            removeData(arrDownloadedFileDislay[indexPath.row] as String)
            
            arrDownloadedFile .removeAtIndex(indexPath.row)
            arrDownloadedFileDislay.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            ///add notification
            
            let newCreatedNotification = NSNotification(name: "reloadListBooks", object: nil)
            NSNotificationCenter.defaultCenter().postNotification(newCreatedNotification)
            ///

                       
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
      
        let movedObject = self.arrDownloadedFile[sourceIndexPath.row]
        arrDownloadedFile.removeAtIndex(sourceIndexPath.row)
        arrDownloadedFile.insert(movedObject, atIndex: destinationIndexPath.row)
       // NSLog("%@", "\(sourceIndexPath.row) => \(destinationIndexPath.row) \(data)")
        // To check for correctness enable: self.tableView.reloadData()
        

    }
    
    func removeData(itemName: String){
        
        var fileManager: NSFileManager = NSFileManager.defaultManager()
        let nsDocumentDirectory = NSSearchPathDirectory.DocumentDirectory
        let nsUserDomainMask = NSSearchPathDomainMask.UserDomainMask
        if let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true){
            
            if paths.count > 0{
                
                if let dirPath = paths[0] as? String {
                    var filePath = NSString(format:"%@/%@", dirPath, itemName) as String
                    NSLog("%@",filePath)
                    var error: NSErrorPointer = NSErrorPointer()
                    fileManager.removeItemAtPath(filePath, error: error)
                    if error != nil{
                    println(error.debugDescription)
                    }
                    
                    
                }
            }
            
        }

    }
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
