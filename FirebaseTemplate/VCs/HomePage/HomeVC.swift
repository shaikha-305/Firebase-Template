//
//  HomeVC.swift
//  iVetAR
//
//  Created by Huda on 7/7/20.
//  Copyright © 2020 shaikha aljenaidel. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
