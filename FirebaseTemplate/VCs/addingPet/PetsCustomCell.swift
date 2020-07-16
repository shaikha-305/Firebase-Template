//
//  PetsCustomCell.swift
//  iVetAR
//
//  Created by Huda on 7/12/20.
//  Copyright © 2020 shaikha aljenaidel. All rights reserved.
//

import UIKit

class PetsCustomCell: UITableViewCell {
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var petImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
