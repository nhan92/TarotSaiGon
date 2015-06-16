//
//  ViewController.swift
//  tarotvn
//
//  Created by Nhan Nguyen on 4/21/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var arrCard:[TarotCard]!
    var card:TarotCard!
    var searchActive : Bool = false

    var filtered:[TarotCard] = []
    
    var selectedCard:TarotCard!
    
    //var hamButt: HamburgerButton!
    
    @IBOutlet weak var searchBarContainerView: UIView!
    
    @IBOutlet weak var myListCard: UITableView!
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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       // var  nameCard = card.nameCard
        arrCard = []
       
        // Init
//        self.hamButt = HamburgerButton(frame: CGRectMake(267, 0, 130, 130))
//        self.searchBarContainerView.addSubview(hamButt)
        
        myListCard.dataSource = self
        myListCard.delegate = self
        mySearch.delegate = self
        
        self.searchBarContainerView.backgroundColor = UIColor.blueColor()
        
        self.shyNavBarManager.scrollView = self.myListCard;
        
        var databaseManager:DatabaseManager = DatabaseManager();
        
        // Connect
        databaseManager .confirgureDatabaseWithName(nameFileDatabase)
        
        arrCard =  databaseManager.getAllOfTarotCaseInDatabase()

        self.myListCard.reloadData()
        
        //self.hamButt.addTarget(self, action: "toggle:", forControlEvents:.)
//        self.hamButt.addTarget(self, action: "toggle:", forControlEvents: UIControlEvents.TouchUpInside)
   }
//    
//    func toggle(sender: AnyObject!)
//    {
//        self.hamButt.showsMenu = !self.hamButt.showsMenu
//    }
    
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
        
//        filtered = arrCard.filter({ (text) -> Bool in
//            let tmp: TarotCard = text
//            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
//            return range.location != NSNotFound
//        })
//        
//        if(filtered.count == 0){
//            searchActive = false;
//        } else {
//            searchActive = true;
//        }
//        self.myListCard.reloadData()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "selected")
        {
            // pass data to next view
            var detailScreen:DetailCardViewController = segue.destinationViewController as! DetailCardViewController;
            
            detailScreen.card = selectedCard;
            
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
        
        [self .performSegueWithIdentifier("selected", sender: nil)]
        
    }
    
     func tableView(myListCard: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = myListCard.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        if(searchActive){
          
            cell.textLabel?.text = filtered[indexPath.row].nameCard
            
        } else {
            let card = arrCard[indexPath.row] as TarotCard
            cell.textLabel?.text = card.nameCard
        }

        
        return cell
    }
        
}

