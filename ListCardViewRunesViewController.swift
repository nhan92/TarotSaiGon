//
//  ListCardViewRunesViewController.swift
//  tarotvn
//
//  Created by Nhan Nguyen on 8/11/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit

class ListCardViewRunesViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate {
    
    var arrCard:[TarotCard]!
    var card:TarotCard!
    var searchActive : Bool = false
    var database:DatabaseManager!;
    var filtered:[TarotCard] = []
    var selectedCard:TarotCard!
    ///
    var arrDownloadedFile: [NSString] = []
    var arrDownloadedFileDislay: [NSString] = []
    var selectedFile:String!
    
    
    
    
    //@IBOutlet weak var searchBarContainerView: UIView!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var mySearch: UISearchBar!
    @IBAction func hamButt(sender: AnyObject) {
        
        if sender.currentMode == JTHamburgerButtonMode.Hamburger
        {
            sender.setCurrentModeWithAnimation(JTHamburgerButtonMode.Cross)
        }else{
            sender.setCurrentModeWithAnimation(JTHamburgerButtonMode.Hamburger)
        }
        
    }
    
    var nameFileDatabase:String!
    var nameFileDatabaseIndexPaths:Int!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        arrCard = []
        //myTableView.dataSource = self
        myTableView.delegate = self
        
        mySearch.delegate = self
        
       // self.searchBarContainerView.backgroundColor = UIColor.blueColor()
        
        // self.shyNavBarManager.scrollView = self.myTableView;
        
        database = DatabaseManager();
        
        // Connect
        database .confirgureDatabaseWithName(nameFileDatabase)
        
        arrCard =  database.getAllOfTarotCaseInDatabase()
        
        self.myTableView.reloadData()
        
    }
    
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(mySearch: UISearchBar, textDidChange searchText: String) {
        
        if searchText.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0
        {
            searchActive = true;
            
            self.filtered = database.getAllCardWithName(searchText);
            
            myTableView.reloadData();
        }
        else
            
        {
            searchActive = false;
            
            myTableView.reloadData();
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if (segue.identifier == "SelectedRider")
        {
            // pass data to next view
            var detailScreen:DetailCardViewController = segue.destinationViewController as! DetailCardViewController;
            
            detailScreen.card = selectedCard;
            
        }
        
        if (segue.identifier == "SelectedTarot")
        {
            // pass data to next view
            var detailScreen1:DetailCardTarotViewController = segue.destinationViewController as! DetailCardTarotViewController;
            
            detailScreen1.card = selectedCard;
            
        }
        
        if (segue.identifier == "SelectedRunes")
        {
            // pass data to next view
            var detailScreen1:DetailCardTarotViewController = segue.destinationViewController as! DetailCardTarotViewController;
            
            detailScreen1.card = selectedCard;
            
        }

        
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
        if(searchActive) {
            return filtered.count
        }
        return arrCard.count;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedCard = arrCard[indexPath.row];
        
        var  defaultName: String = arrDownloadedFileDislay[nameFileDatabaseIndexPaths] as String
        
        if defaultName == "Rider Waite Tarot"
        {
            
            [self .performSegueWithIdentifier("SelectedRider", sender: nil)]
            
        }
        else {
            
            [self.performSegueWithIdentifier("SelectedRunes", sender: nil)]
        }
    }
    
    func tableView(myListCard: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> RunesTableViewCell {
        let cell = myListCard.dequeueReusableCellWithIdentifier("RunesCell", forIndexPath: indexPath) as! RunesTableViewCell
        
        // Configure the cell...
        if(searchActive){
            
           // cell.textLabel?.text = filtered[indexPath.row].nameCard
            cell.myRunesText.text = filtered[indexPath.row].nameCard
            cell.myRunesImages.image = UIImage(named: filtered[indexPath.row].images)
            
        } else {
            let card = arrCard[indexPath.row] as TarotCard
            cell.myRunesText.text = card.nameCard
            cell.myRunesImages.image = UIImage(named: card.images)
        }
        
        
        return cell
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
        
        
    }
    
    
}
