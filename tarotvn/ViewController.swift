//
//  ViewController.swift
//  tarotvn
//
//  Created by Nhan Nguyen on 4/21/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var mang:[String]!
    @IBOutlet weak var myListCard: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mang = ["v","m","n"]
       // self.myListCard.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        myListCard.dataSource = self
        myListCard.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Table view data source
    
     func numberOfSectionsInTableView(myListCard: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
     func tableView(myListCard: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return mang.count
    }
    
    
     func tableView(myListCard: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = myListCard.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        cell.textLabel?.text = mang[indexPath.row]
        
        return cell
    }
    

}

