//
//  HomeVC.swift
//  iVetAR
//
//  Created by Huda on 7/7/20.
//  Copyright © 2020 shaikha aljenaidel. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
//    let logo = UIImageView(image: UIImage(named: "launchScreen")!)
//    let splashView = UIView()
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        splashView.backgroundColor = UIColor(red: 117/255, green: 121/255, blue: 112/255, alpha: 1.0)
//        view.addSubview(splashView)
//        splashView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
//
//        logo.contentMode = .scaleAspectFit
//        splashView.addSubview(logo)
//        logo.frame = CGRect(x: splashView.frame.maxX - 50, y: splashView.frame.maxY - 50, width: 189, height: 174)
    }
//    override func viewDidAppear(_ animated: Bool) {
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
//            self.scaleDownAnimation()
//        }
//    }
//    func scaleDownAnimation() {
//        UIView.animate(withDuration: 0.5, animations: {
//            self.logo.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
//        }) { (success) in
//            self.scaleUpAnimation()
//        }
//    }
//
//    func scaleUpAnimation() {
//        UIView.animate(withDuration: 0.35, delay: 0.1, options: .curveEaseIn, animations: {
//            self.logo.transform = CGAffineTransform(scaleX: 5, y: 5)
//        }) { (success) in
//            self.removeSplashScreen()
//        }
//    }
//
//    func removeSplashScreen() {
//        splashView.removeFromSuperview()
//    }
}
