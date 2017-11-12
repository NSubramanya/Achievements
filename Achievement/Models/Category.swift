//
//  category.swift
//  achivement
//
//  Created by subramanya on 09/11/17.
//  Copyright © 2017 Chanel. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Category {
    var id: String?
    var name: String?
    var description: String?
    var order: Int?
    var icon: URL?
    var image: UIImage?
    var achievements: [Int] = []
    
    
    init?(from json: JSON) {
        let id = json["id"].string
        let name = json["name"].string
        let description = json["description"].string
        let order = json["order"].int
        let icon = json["icon"].string
        let achievements = json["achievements"].arrayObject
        
        self.id = id
        self.name = name
        self.description = description
        self.order = order
        if let iconString = icon {
            self.icon = URL(string: iconString)
        }
        self.achievements = achievements as! Array<Int>
    }
}
