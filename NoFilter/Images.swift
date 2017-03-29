//
//  Images.swift
//  MyImagesTab
//
//  Created by Luis Esquivel on 2017-02-28.
//  Copyright © 2017 luis. All rights reserved.
//

import UIKit

class Images {
    // MARK: Properties
    
    var photo1: UIImage?
    var photo2: UIImage?
    var photo3: UIImage?
    
    
    // MARK: Initialization
    
    init?(photo1: UIImage?, photo2: UIImage?, photo3: UIImage?) {
        
        // Initialize stored properties.

        self.photo1 = photo1
        self.photo2 = photo2
        self.photo3 = photo3

        
    }
}
