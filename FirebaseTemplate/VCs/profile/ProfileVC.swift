//
//  ProfileVC.swift
//  iVetAR
//
//  Created by Huda on 7/6/20.
//  Copyright © 2020 shaikha aljenaidel. All rights reserved.
//
import Firebase
import UIKit
import SDWebImage
import Photos
import BSImagePicker

class ProfileVC: UIViewController {
    var imageurl: URL!
    let imagePicker = ImagePickerController()
    @IBOutlet var imageView: UIImageView!
    var year: String!
    var month: String!
    var petInfo: Pet!
    var petNameText: String!
    var petType: String!
    var petGender: String!
    var petAgeText: String!
    @IBOutlet weak var petNameTextView: UITextView!
    @IBOutlet weak var petTypeTextView: UITextView!
    @IBOutlet weak var petGenderTextView: UITextView!
    @IBOutlet weak var petAgeTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayingData()
        guard let userID = Auth.auth().currentUser?.uid else {
            fatalError("this user doesnt exist")
        }
        Networking.getSingleDocument("users/\(userID)", success: { (userInfo: Pet) in
            self.petInfo = userInfo
//            myPets.append(self.petInfo)
            self.displayingData()
        }) { (err) in
            print(err)
        }
//        Networking.getDocumentOfCollection(DOCUMENT_PATH: "pets/data/\(userID)/1") { (userInfo: Pet) in
//            self.petInfo = userInfo
//            self.reloadInputViews()
//            self.displayingData()
//            self.reloadInputViews()
//        }
    }
    
    @IBAction func doYouNeedHelpButton(_ sender: Any) {
        performSegue(withIdentifier: "questions", sender: self)
    }
    @IBAction func plusBtn(_ sender: Any) {
        performSegue(withIdentifier: "addPet", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "questions" {
            let vc = segue.destination as! QuestionsVC
            vc.petInfo = petInfo
            vc.year = year
            vc.month = month
        }else if segue.identifier == "addPet"{
            let vc = segue.destination as! AddVC
        }
    }
    func displayingData() {
        petNameTextView.text = petInfo.petName!
        petAgeTextView.text = petInfo.petAge!
        petTypeTextView.text = petInfo.petType!
        petGenderTextView.text = petInfo.petGender!
        SDWebImageDownloader().downloadImage(with: URL(string: petInfo.imageUrl ?? ""), options: .highPriority, progress: {  (receivedSize, expectedSize, url) in
            // image is being downloading and you can monitor progress here
        }) { (downloadedImage, data, error, success) in
            self.imageView.image = downloadedImage
        }
    }
    
    @IBAction func imageBtn(_ sender: Any) {
        imagePicker.settings.selection.max = 1

        presentImagePicker(imagePicker, select: { (asset) in
            // User selected an asset. Do something with it. Perhaps begin processing/upload?

        }, deselect: { (asset : PHAsset) in
            // User deselected an asset. Cancel whatever you did when asset was selected.
        }, cancel: { (assets : [PHAsset]) in
            // User canceled selection.
        }, finish: { (assets : [PHAsset]) in
            self.imageView.image = UploadImage().getAssetThumbnail(asset: assets[0])
            UploadImage.UploadImageAndGetUrl(path: "images", "saad.png", ImageView: self.imageView.image!) { (url: URL) in
                self.imageurl = url
                       print(url)
                   }

        })
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

