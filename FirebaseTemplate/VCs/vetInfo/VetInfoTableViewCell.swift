//
//  VetInfoTableViewCell.swift
//  iVetAR
//
//  Created by Huda on 7/11/20.
//  Copyright © 2020 shaikha aljenaidel. All rights reserved.
//

import UIKit

class VetInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var vetIcon: UIImageView!
    @IBOutlet weak var cellImgView: UIImageView!
    @IBOutlet weak var vetNameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
