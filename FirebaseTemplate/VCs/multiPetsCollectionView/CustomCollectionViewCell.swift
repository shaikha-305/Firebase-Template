//
//  CustomCollectionViewCell.swift
//  FirebaseTemplate
//
//  Created by Huda on 7/15/20.
//  Copyright © 2020 OMAR. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet var petImgView: UIImageView!
    @IBOutlet var view: UIView!
    @IBOutlet var petNameLabel: UILabel!
    
    var User: [User]!{
        didSet{
            self.updateUI()
        }
    }
    func updateUI() {
        if let User = User {
            view.layer.cornerRadius = 10.0
        }
    }
}

