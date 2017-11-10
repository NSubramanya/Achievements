//
//  TableViewCell.swift
//  achivement
//
//  Created by sukhjeet singh sandhu on 09/11/17.
//  Copyright © 2017 Chanel. All rights reserved.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView?
    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameLabelBottomConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(with group: Group) {
        if let _ = iconImageView {
            self.iconImageView?.removeFromSuperview()
        }
        self.nameLabelLeadingConstraint.constant = 8
        self.nameLabel.text = group.name
        self.descriptionLabel.text = group.description
    }

    func configureCell(with category: Category) {
        self.iconImageView?.image = #imageLiteral(resourceName: "placeholder")
        let downloadManager = SDWebImageManager.shared()
        let _ = downloadManager.imageDownloader?.downloadImage(with: category.icon!, options: .continueInBackground, progress: nil, completed: { (image, data, error, isSucceeded) in
            self.iconImageView?.image = image
            self.setNeedsLayout()
        })
        self.removeConstraint(nameLabelBottomConstraint)
        self.nameLabel.text = category.name
        self.descriptionLabel.text = category.description
    }

    func configureCell(with achievement: Achievement) {
        self.iconImageView?.image = #imageLiteral(resourceName: "placeholder")
        let downloadManager = SDWebImageManager.shared()
        if let icon = achievement.icon {
            let url = URL(string: icon)
            let _ = downloadManager.imageDownloader?.downloadImage(with: url, options: .continueInBackground, progress: nil, completed: { (image, data, error, isSucceeded) in
                self.iconImageView?.image = image
                self.setNeedsLayout()
            })
        }
        self.removeConstraint(nameLabelBottomConstraint)
        self.nameLabel.text = achievement.name
        self.descriptionLabel.text = achievement.description
    }
}
