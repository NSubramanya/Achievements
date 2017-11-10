//
//  GroupRequest.swift
//  achivement
//
//  Created by subramanya on 09/11/17.
//  Copyright © 2017 Chanel. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct AllGroupRequest : ModifiableBaseRequest {
    var baseRequest: BaseRequest = BaseRequest()
    init() {
        self.endpoint = "v2/achievements/groups"
    }
    
    public func retriveAllGroupIds(completion: @escaping(_ groupIds: [String]?, _ error: WebResponseError?)-> Void) {
        
        let groupIdsFetcherRequest = AllGroupRequest()
        let webserviceManager = WebServiceManager()
        webserviceManager.getResponse(for: groupIdsFetcherRequest) { (request, response, data, error) in
            let error = WebResponseError.check(response: response, request: request, error: error)
            if error != nil {
                completion(nil, error)
            } else {
                guard let data = data else {
                    completion(nil, WebResponseError.invalidRequest)
                    return
                }
                let json = JSON(data: data)
                guard let groupIdsArray = json.arrayObject as? [String] else {
                    completion(nil, WebResponseError.invalidRequest)
                    return
                }
                completion(groupIdsArray, nil)
            }
        }
    }
}

public struct GroupRequest : ModifiableBaseRequest {
    var baseRequest: BaseRequest = BaseRequest()
    init(with groupIds: [String]) {
        self.endpoint = "v2/achievements/groups"
        let groupIdString = groupIds.joined(separator: ",")
        self.parameters = ["ids": groupIdString as AnyObject]
    }
}
