//
//  ImagesTableViewCell.swift
//  MyImagesTab
//
//  Created by Luis Esquivel on 2017-02-28.
//  Copyright © 2017 luis. All rights reserved.
//

import UIKit

class ImagesTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var image1Cell: UIImageView!
    @IBOutlet weak var image2Cell: UIImageView!
    @IBOutlet weak var image3Cell: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
