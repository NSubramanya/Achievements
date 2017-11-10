//
//  AchivementRequest.swift
//  achivement
//
//  Created by subramanya on 09/11/17.
//  Copyright © 2017 Chanel. All rights reserved.
//

import Foundation

public struct AchivementRequest : ModifiableBaseRequest {
    var baseRequest: BaseRequest = BaseRequest()
    init(with achivementIds: [String]) {
        self.endpoint = "v2/achievements"
        let achivementsIdString = achivementIds.joined(separator: ",")
        self.parameters = ["ids": achivementsIdString as AnyObject]
    }
}

