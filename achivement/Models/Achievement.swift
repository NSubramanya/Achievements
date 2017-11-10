//
//  Achievement.swift
//  achivement
//
//  Created by subramanya on 09/11/17.
//  Copyright © 2017 Chanel. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Achievement {
    var id: String?
    var icon: String?
    var name: String?
    var description: String?
    var requirement: String?
    var locked_text: String?
    var type: String?
    var flags: [String] = []
    var tiers: [Dictionary<String,Int?>] = [] as! [Dictionary<String,Int>]
    var prerequisites: [Int]? = []
    var rewards: [Dictionary<String,String>]? = [] as? [Dictionary<String,String>]
    var bits: [Dictionary<String, String>]? = [] as? [Dictionary<String, String>]
    var point_cap: Int?

    init?(from json: JSON) {
        let id = json["id"].string
        let icon = json["icon"].string
        let name = json["name"].string
        let description = json["description"].string
        let requirement = json["requirement"].string
        let locked_text = json["locked_text"].string
        let type = json["type"].string
        let flags = json["flags"].arrayObject
        let tiersJson = json["tiers"].array
        var tiersDict: [Dictionary<String,Int?>] = [] as! [Dictionary<String,Int>]
        for aTier in tiersJson! {
            let count = aTier["count"].int
            let point = aTier["points"].int
            let singleTierValue = ["count": count,"points": point]
            tiersDict.append(singleTierValue)
        }
        let prerequisites = json["prerequisites"].arrayObject
        var rewardsDict: [Dictionary<String,String>]? = [] as? [Dictionary<String,String>]
        if let rewardsJson = json["rewards"].array {
            var singleRewardValue: [String: String] = [:]
            for aReward in rewardsJson {
                let type = aReward["type"].string!
                if type == "Coins" {
                    let count = aReward["count"].int
                    singleRewardValue = ["type": type, "count": "\(count!)"]
                } else if type == "Item" {
                    let id = aReward["id"].int
                    let count = aReward["id"].int
                    singleRewardValue = ["type": type, "id": "\(id!)", "count": "\(count!)"]
                } else if type == "Mastery" {
                    let id = aReward["id"].int
                    let region = aReward["region"].string
                    singleRewardValue = ["type": type, "id": "\(id!)", "region": "\(region!)"]
                } else if type == "Title" {
                    let id = aReward["id"].int
                    singleRewardValue = ["type": type, "id": "\(id!)"]
                }
                rewardsDict?.append(singleRewardValue)
            }
        }
        var bitsDict: [Dictionary<String, String>]? = [] as? [Dictionary<String, String>]
        if let bitsJson = json["bits"].array {
            for aBitValue in bitsJson {
                let type = aBitValue["type"].string
                let id: Int?
                let text: String?
                var singleBitValue: [String: String] = ["type": type!]
                if let idValue = aBitValue["id"].int {
                    id = idValue
                    singleBitValue = ["type": type!, "id": "\(id!)"]
                    if let textValue = aBitValue["text"].string {
                        text = textValue
                        singleBitValue = ["type": type!, "id": "\(id!)", "text": text!]
                    }
                }
                bitsDict?.append(singleBitValue)
            }
        }
        
        let point_cap = json["point_cap"].int
        
        self.id = id
        self.icon = icon
        self.name = name
        self.description = description
        self.requirement = requirement
        self.locked_text = locked_text
        self.type = type
        self.flags = flags as! [String]
        self.tiers = tiersDict
        if let prerequisitesArray = prerequisites {
            self.prerequisites = prerequisitesArray as? [Int]
        }
        self.rewards = rewardsDict
        self.bits = bitsDict
        if let pointCap = point_cap {
            self.point_cap = pointCap
        }
    }
}
