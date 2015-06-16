//
//  TarotCard.swift
//  tarotvn
//
//  Created by Nhan Nguyen on 4/21/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit

class TarotCard: NSObject {
    var nameCard: String
    var keyWord: String
    var keyDetail: String
    var images: String
    var cardAntonyms: String
    var cardSynonyms: String
    var information: String
    var forwardCard: String
    var reverseCard: String
    var idCard: Int
    
    
    init(nameCard: String, keyWord: String, keyDetail: String, images: String, cardAntonyms: String,
cardSynonyms: String, information: String, forwardCard: String, reverseCard: String, idCard: Int) {
        self.nameCard = nameCard
        self.keyWord = keyWord
        self.keyDetail = keyDetail
        self.images = images
        self.cardAntonyms = cardAntonyms
        self.cardSynonyms = cardSynonyms
        self.information = information
        self.forwardCard = forwardCard
        self.reverseCard = reverseCard
        self.idCard = idCard
        super.init()
    }
    
}
