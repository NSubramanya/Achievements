//
//  BaseController.swift
//  achivement
//
//  Created by sukhjeet singh sandhu on 09/11/17.
//  Copyright © 2017 Chanel. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class BaseController {

    var groupIds: [String] = []

    func getGroups(success: @escaping ([Group])->(), failure: @escaping (String)->()) {
        let allGroupReq = AllGroupRequest()
        allGroupReq.retriveAllGroupIds { (groupIdsArray, error) in
            if error == nil {
                self.groupIds = groupIdsArray!
                self.retrieveGroupInfo { (groups, error) in
                    if error == nil {
                        success(groups! as! [Group])
                    } else {
                        failure(WebResponseError.description(for: error!))
                    }
                }
            } else {
                failure(WebResponseError.description(for: error!))
            }
        }
    }

    func retrieveGroupInfo(completion: @escaping(_ groups: [Group?]?, _ error: WebResponseError?)-> Void) {
        
        var groups: [Group] = []
        var didSucceed = false
        let groupFetcherRequest = GroupRequest(with: groupIds)
        let webserviceManager = WebServiceManager()
        webserviceManager.getResponse(for: groupFetcherRequest) { (request, response, data, error) in
            let error = WebResponseError.check(response: response, request: request, error: error)
            if error != nil {
                completion(nil, error)
            }
            else{
                guard let data = data else {
                    completion(nil, WebResponseError.invalidRequest)
                    return
                }
                let json = JSON(data: data)
                guard let groupJsonArray = json[].array else {
                    completion(nil, WebResponseError.invalidRequest)
                    return
                }
                for groupJson in groupJsonArray {
                    if let group = Group.init(from: groupJson) {
                        groups.append(group)
                        didSucceed = true
                    } else {
                        completion(nil, WebResponseError.invalidRequest)
                    }
                }
            }
            if didSucceed {
                completion(groups, nil)
            }
        }
    }

    func getCategories(from ids: [String], completion: @escaping(_ categoris: [Category?]?, _ error: String?)-> Void) {
        var categories: [Category] = []
        var didSucceed = false
        let categoryFetcherRequest = CategoryRequest(with: ids)
        let webserviceManager = WebServiceManager()

        webserviceManager.getResponse(for: categoryFetcherRequest) { (request, response, data, error) in
            let error = WebResponseError.check(response: response, request: request, error: error)
            if error != nil {
                completion(nil, WebResponseError.description(for: error!))
            }
            else{
                guard let data = data else {
                    completion(nil, WebResponseError.description(for: WebResponseError.invalidRequest))
                    return
                }
                let json = JSON(data: data)
                guard let categoryJsonArray = json[].array else {
                    completion(nil, WebResponseError.description(for: WebResponseError.invalidRequest))
                    return
                }
                for categoryJson in categoryJsonArray {
                    if let category = Category.init(from: categoryJson) {
                        categories.append(category)
                        didSucceed = true
                    } else {
                        completion(nil, WebResponseError.description(for: WebResponseError.invalidRequest))
                    }
                }
            }
            if didSucceed {
                completion(categories, nil)
            }
        }
    }

    func getAchievements(from ids: [String], completion: @escaping(_ achievements: [Achievement?]?, _ error: String?)-> Void) {
        var achievements: [Achievement] = []
        var didSucceed = false
        let achievementFetcherRequest = AchivementRequest(with: ids)
        let webserviceManager = WebServiceManager()
        
        webserviceManager.getResponse(for: achievementFetcherRequest) { (request, response, data, error) in
            let error = WebResponseError.check(response: response, request: request, error: error)
            if error != nil {
                completion(nil, WebResponseError.description(for: error!))
            }
            else{
                guard let data = data else {
                    completion(nil, WebResponseError.description(for: WebResponseError.invalidRequest))
                    return
                }
                let json = JSON(data: data)
                guard let achievementJsonArray = json[].array else {
                    completion(nil, WebResponseError.description(for: WebResponseError.invalidRequest))
                    return
                }
                for achievementJson in achievementJsonArray {
                    if let achievement = Achievement.init(from: achievementJson) {
                        achievements.append(achievement)
                        didSucceed = true
                    } else {
                        completion(nil, WebResponseError.description(for: WebResponseError.invalidRequest))
                    }
                }
            }
            if didSucceed {
                completion(achievements, nil)
            }
        }
    }
}
