//
//  CateCollectionCell.swift
//  MenuTask
//
//  Created by MacBook Pro on 11/18/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit

class CateCollectionCell: UICollectionViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.borderWidth = 1
    }

}
