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
    var selectedPet: Pet!
    var imageurl: URL?
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
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        petNameTextView.text = selectedPet.petName
        petTypeTextView.text = selectedPet.petType
        petGenderTextView.text = selectedPet.petGender
        petAgeTextView.text = selectedPet.petAge
        
        guard let userID = Auth.auth().currentUser?.uid else {
            fatalError("this user doesnt exist")
        }
        Networking.getSingleDocument("users/\(userID)", success: { (userInfo: Pet) in
            self.petInfo = userInfo
            self.displayingData()
        }) { (err) in
            print(err)
        }
        displayingData()
    }
    
    @IBAction func doYouNeedHelpButton(_ sender: Any) {
        performSegue(withIdentifier: "questions", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "questions" {
            let vc = segue.destination as! QuestionsVC
            vc.petInfo = selectedPet
            vc.year = year
            vc.month = month
        }else if segue.identifier == "addPet"{
            let vc = segue.destination as! AddVC
        }
    }
    func displayingData() {
        SDWebImageDownloader().downloadImage(with: URL(string: selectedPet.imageUrl ?? "https://img.huffingtonpost.com/asset/5b7fdeab1900001d035028dc.jpeg"), options: .progressiveLoad, progress: {  (receivedSize, expectedSize, url) in
            // image is being downloading and you can monitor progress here
        }) { (downloadedImage, data, error, success) in
            self.imageView.image = downloadedImage
        }
    }
    
    @IBAction func imageBtn(_ sender: Any) {
        let userID = Auth.auth().currentUser?.uid
        imagePicker.settings.selection.max = 1
        presentImagePicker(imagePicker, select: { (asset) in
            // User selected an asset. Do something with it. Perhaps begin processing/upload?
        }, deselect: { (asset : PHAsset) in
            // User deselected an asset. Cancel whatever you did when asset was selected.
        }, cancel: { (assets : [PHAsset]) in
            // User canceled selection.
        }, finish: { (assets : [PHAsset]) in
            self.imageView.image = UploadImage().getAssetThumbnail(asset: assets[0])
            let id = UUID()
            UploadImage.UploadImageAndGetUrl(path: "images", "\(id).png", ImageView: self.imageView.image!) { (url: URL) in
                self.imageurl = url
                print(url)
                var updatedPet = self.selectedPet
                updatedPet?.imageUrl = url.absoluteString
                Networking.createItem(updatedPet, inCollection: "users/\(userID!)/pets", withDocumentId: "\(updatedPet!.id!)") {
                    print("Image should be updated")
                }
            }
        })
    }
    
}

