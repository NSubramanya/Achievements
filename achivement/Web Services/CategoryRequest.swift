//
//  CategoryRequest.swift
//  achivement
//
//  Created by subramanya on 09/11/17.
//  Copyright © 2017 Chanel. All rights reserved.
//

import Foundation

public struct CategoryRequest : ModifiableBaseRequest {
    var baseRequest: BaseRequest = BaseRequest()
    init(with categoryIds: [String]) {
        self.endpoint = "v2/achievements/categories"
        let categoriesIdString = categoryIds.joined(separator: ",")
        self.parameters = ["ids": categoriesIdString as AnyObject]
    }
}
