//
//  BaseViewController.swift
//  achivement
//
//  Created by subramanya on 07/11/17.
//  Copyright © 2017 Chanel. All rights reserved.
//

import UIKit
import SwiftyJSON
import MBProgressHUD

enum Type {
    case group
    case category
    case achievement
}

class BaseViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let baseController = BaseController()
    var ids: [String] = []
    var titleText = "Groups"
    var type: Type = .group
    var groups: [Group] = []
    var categories: [Category] = []
    var achievements: [Achievement] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = titleText
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.tableView.isUserInteractionEnabled = false
        self.loadData()
    }

    func loadData() {
        switch type {
        case .group:
            DispatchQueue.global(qos: .userInitiated).async {
                self.baseController.getGroups(success: { (groups) in
                    self.groups = groups
                    DispatchQueue.main.async {
                        MBProgressHUD.hide(for: self.view, animated: true)
                        self.tableView.isUserInteractionEnabled = true
                        self.tableView.reloadData()
                    }
                }, failure: { (error) in
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.tableView.isUserInteractionEnabled = true
                    self.alert(with: error)
                })
            }
        case .category:
            DispatchQueue.global(qos: .userInitiated).async {
                self.baseController.getCategories(from: self.ids, completion: { (categories, error) in
                    if error == nil {
                        self.categories = categories! as! [Category]
                        DispatchQueue.main.async {
                            MBProgressHUD.hide(for: self.view, animated: true)
                            self.tableView.isUserInteractionEnabled = true
                            self.tableView.reloadData()
                        }
                    } else {
                        MBProgressHUD.hide(for: self.view, animated: true)
                        self.tableView.isUserInteractionEnabled = true
                        self.alert(with: error!)
                    }
                })
            }
        case .achievement:
            DispatchQueue.global(qos: .userInitiated).async {
                self.baseController.getAchievements(from: self.ids, completion: { (achievements, error) in
                    if error == nil {
                        self.achievements = achievements! as! [Achievement]
                        DispatchQueue.main.async {
                            MBProgressHUD.hide(for: self.view, animated: true)
                            self.tableView.isUserInteractionEnabled = true
                            self.tableView.reloadData()
                        }
                    } else {
                        MBProgressHUD.hide(for: self.view, animated: true)
                        self.tableView.isUserInteractionEnabled = true
                        self.alert(with: error!)
                    }
                })
            }
        }
    }

    func alert(with message: String) {
        
    }
}

extension BaseViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type {
        case .group:
            return groups.count
        case .category:
            return categories.count
        case .achievement:
            return achievements.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        switch self.type {
        case .group:
            cell.configureCell(with: groups[indexPath.row])
        case .category:
            cell.configureCell(with: categories[indexPath.row])
        case .achievement:
            cell.configureCell(with: achievements[indexPath.row])
        }
        
        return cell
    }
}

extension BaseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "baseViewController") as! BaseViewController
        var items: [String] = []
        switch type {
        case .group:
            items.removeAll()
            let group = groups[indexPath.row]
            vc.type = .category
            vc.titleText = group.name!
            for category in group.categories {
                items.append("\(category)")
            }
            vc.ids = items
            self.navigationController?.pushViewController(vc, animated: true)
        case .category:
            items.removeAll()
            let category = categories[indexPath.row]
            vc.type = .achievement
            vc.titleText = category.name!
            for achievement in category.achievements {
                items.append("\(achievement)")
            }
            vc.ids = items
            self.navigationController?.pushViewController(vc, animated: true)
        case .achievement:
            let vc = storyboard.instantiateViewController(withIdentifier: "achievementsViewController") as! AchievementsTableViewController
            vc.achievement = achievements[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

