//
//  AchievementsTableViewController.swift
//  achivement
//
//  Created by sukhjeet singh sandhu on 10/11/17.
//  Copyright © 2017 Chanel. All rights reserved.
//

import UIKit

class AchievementsTableViewController: UITableViewController {

    var achievement: Achievement!
    var keys: [String] = []
    var values: [String] = []
    var dataSource: [String: String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.keys.removeAll()
        self.values.removeAll()
        self.title = "Details"
        self.prepareDataSource()
        self.tableView.reloadData()
    }

    func prepareDataSource() {
        if let name = self.achievement.name {
            self.keys.append("Name")
            self.values.append(name)
        }
        if let description = self.achievement.description {
            if !description.isEmpty {
                self.keys.append("Description")
                self.values.append(description)
            }
        }
        if let requirement = self.achievement.requirement {
            self.keys.append("Requirement")
            self.values.append(requirement)
        }
        if let type = self.achievement.type {
            self.keys.append("Type")
            self.values.append(type)
        }
        if !self.achievement.flags.isEmpty {
            self.keys.append("Flags")
            self.values.append(self.achievement.flags.joined(separator: "\n"))
        }
        if !self.achievement.tiers.isEmpty {
            var array: [String] = []
            for dict in self.achievement.tiers {
                for (key, value) in dict {
                    if let value = value {
                       array.append("\(key): \(String(describing: value))")
                    }
                }
            }
            self.keys.append("Tiers")
            self.values.append(array.joined(separator: "\n"))
        }
        if let prerequisites = self.achievement.prerequisites {
            if !prerequisites.isEmpty {
                var array: [String] = []
                for prerequisite in prerequisites {
                    array.append(String(prerequisite))
                }
                self.keys.append("Prerequisites")
                self.values.append(array.joined(separator: "\n"))
            }
        }
        if let point_cap = self.achievement.point_cap {
            self.keys.append("Point_cap")
            self.values.append(String(point_cap))
        }
        if let rewards = self.achievement.rewards {
            if !rewards.isEmpty {
                var array: [String] = []
                for dict in rewards {
                    for (key, value) in dict {
                        array.append("\(key): \(value)")
                    }
                }
                self.keys.append("Rewards")
                self.values.append(array.joined(separator: "\n"))
            }
        }
        if let bits = self.achievement.bits {
            if !bits.isEmpty {
                var array: [String] = []
                for dict in bits {
                    for (key, value) in dict {
                        array.append("\(key): \(value)")
                    }
                }
                self.keys.append("Bits")
                self.values.append(array.joined(separator: "\n"))
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keys.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "achievements", for: indexPath) as! AchievementTableViewCell
        cell.titleLabel.text = keys[indexPath.row]
        cell.subtitleLabel.text = values[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}
