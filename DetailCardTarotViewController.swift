//
//  DetailCardVnViewController.swift
//  tarotvn
//
//  Created by Nhan Nguyen on 8/5/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit

class DetailCardTarotViewController: UIViewController {

    var arrCard:[TarotCard]!
    var card:TarotCard!
    
    @IBOutlet weak var myDescription: UITextView!
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        myDescription.text = card.forwardCard
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
