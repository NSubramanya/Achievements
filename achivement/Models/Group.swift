//
//  Group.swift
//  achivement
//
//  Created by subramanya on 09/11/17.
//  Copyright © 2017 Chanel. All rights reserved.
//

import Foundation
import SwiftyJSON


struct Group {
    var id: String?
    var name: String?
    var description: String?
    var order: Int?
    var categories: [Int] = []
    
    
    init?(from json: JSON) {
        let id = json["id"].string
        let name = json["name"].string
        let description = json["description"].string
        let order = json["order"].int
        let categories = json["categories"].arrayObject
        
        self.id = id
        self.name = name
        self.description = description
        self.order = order
        self.categories = categories as! Array<Int>
    }
}
