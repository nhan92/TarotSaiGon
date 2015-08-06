//
//  DetailCardViewController.swift
//  tarotvn
//
//  Created by Nhan Nguyen on 5/20/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit

class DetailCardViewController: UIViewController {
    
     var arrCard:[TarotCard]!
     var card:TarotCard!
    
    @IBOutlet weak var myDescription: UITextView!
    @IBOutlet weak var mySegment: UISegmentedControl!
    @IBAction func mySelection(sender: UISegmentedControl) {
        
        switch mySegment.selectedSegmentIndex
        {
        case 0:
            myDescription.text = card.keyDetail
        case 1:
            myDescription.text = card.forwardCard
        case 2:
            myDescription.text = card.information
        //case 3:
        //  myDescription.text = card.keyDetail
        default:
            break; 
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       myDescription.text = card.keyDetail
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
