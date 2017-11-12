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

    func getGroups(completion: @escaping(_ groups: [Group?]?, _ error: String?)-> Void) {
        let allGroupReq = AllGroupRequest()
        allGroupReq.retriveAllGroupIds { (groupIdsArray, error) in
            if error == nil {
                self.groupIds = groupIdsArray!
                self.retrieveGroupInfo { (groups, error) in
                    if error == nil {
                        completion(groups!, nil)
                    } else {
                        completion(nil, error)
                    }
                }
            } else {
                completion(nil, WebResponseError.description(for: error!))
            }
        }
    }

    func retrieveGroupInfo(completion: @escaping(_ groups: [Group?]?, _ error: String?)-> Void) {
        let groupFetcherRequest = GroupRequest(with: groupIds)
        self.perfom(request: groupFetcherRequest, type: .group) { (achievements, categories, groups, error) in
            if error == nil {
                completion(groups, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    func getCategories(from ids: [String], completion: @escaping(_ categoris: [Category?]?, _ error: String?)-> Void) {        let categoryFetcherRequest = CategoryRequest(with: ids)
        self.perfom(request: categoryFetcherRequest, type: .category) { (achievements, categories, groups, error) in
            if error == nil {
                completion(categories, nil)
            } else {
                completion(nil, error)
            }
        }
    }

    func getAchievements(from ids: [String], completion: @escaping(_ achievements: [Achievement?]?, _ error: String?)-> Void) {
        let achievementFetcherRequest = AchivementRequest(with: ids)
        self.perfom(request: achievementFetcherRequest, type: .achievement) { (achievements, categories, groups, error) in
            if error == nil {
                completion(achievements, nil)
            } else {
                completion(nil, error)
            }
        }
        
    }

    func perfom(request: ModifiableBaseRequest, type: Type, completion: @escaping(_ achievements: [Achievement?]?,_ categories: [Category?]?, _ groups: [Group?]?, _ error: String?)-> Void) {
        let webserviceManager = WebServiceManager()
        var achievements: [Achievement] = []
        var categories: [Category] = []
        var groups: [Group] = []
        var didSucceed = false
        
        webserviceManager.getResponse(for: request) { (request, response, data, error) in
            let error = WebResponseError.check(response: response, request: request, error: error)
            if error != nil {
                completion(nil, nil, nil, WebResponseError.description(for: error!))
            }
            else{
                guard let data = data else {
                    completion(nil, nil, nil, WebResponseError.description(for: WebResponseError.invalidRequest))
                    return
                }
                let json = JSON(data: data)
                guard let jsonArray = json[].array else {
                    completion(nil, nil, nil, WebResponseError.description(for: WebResponseError.invalidRequest))
                    return
                }
                for json in jsonArray {
                    if type == .achievement {
                        if let achievement = Achievement.init(from: json) {
                            achievements.append(achievement)
                            didSucceed = true
                        } else {
                            completion(nil, nil, nil, WebResponseError.description(for: WebResponseError.invalidRequest))
                        }
                    } else if type == .category {
                        if let category = Category.init(from: json) {
                            categories.append(category)
                            didSucceed = true
                        } else {
                            completion(nil, nil, nil, WebResponseError.description(for: WebResponseError.invalidRequest))
                        }
                    } else if type == .group {
                        if let group = Group.init(from: json) {
                            groups.append(group)
                            didSucceed = true
                        } else {
                            completion(nil, nil, nil, WebResponseError.description(for: WebResponseError.invalidRequest))
                        }
                    }
                }
            }
            if didSucceed {
                if type == .group {
                    completion(nil, nil, groups, nil)
                } else if type == .category {
                    completion(nil, categories, nil, nil)
                } else if type == .achievement {
                    completion(achievements, nil, nil, nil)
                }
            }
        }
    }
}
