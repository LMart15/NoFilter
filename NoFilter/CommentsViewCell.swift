//
//  CommentsViewCell.swift
//  NoFilter
//
//  Created by harpreet singh on 2017-03-29.
//  Copyright © 2017 mapd.centennial.proapptive. All rights reserved.
//

import UIKit

class CommentsViewCell: UITableViewCell {

    @IBOutlet weak var userWhoCommented: UILabel!
    @IBOutlet weak var comments: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
