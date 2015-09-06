//
//  RecipeProduceTableViewCell.swift
//  Blender
//
//  Created by Bryan Lin on 9/7/15.
//  Copyright (c) 2015 GiantCroissant. All rights reserved.
//

import UIKit

class RecipeProduceTableViewCell: UITableViewCell {

    @IBOutlet weak var stepNumber: UILabel!
    @IBOutlet weak var stepContent: UILabel!
    @IBOutlet weak var stepCheckIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
