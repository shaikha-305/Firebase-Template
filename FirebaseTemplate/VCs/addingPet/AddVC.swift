//
//  AddVC.swift
//  iVetAR
//
//  Created by Huda on 7/12/20.
//  Copyright © 2020 shaikha aljenaidel. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase
import SDWebImage
import Photos
import BSImagePicker

class AddVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    let toolBar = UIToolbar()
    let imagePicker = ImagePickerController()
    var year: String!
    var month: String!
    var imageurl: URL!
    @IBOutlet var newPetImageView: UIImageView!
    var newPet: Pet = Pet(petName: "", petType: "", petGender: "", petAge: "", petMonth: "", petYear: "")
    @IBOutlet  var petTypeField: UITextField!
    var currentTextField: UITextField!
    let types = ["","قطه","كلب"]
    @IBOutlet  var genderField: UITextField!
    let gender = ["","أنثى","ذكر"]
    @IBOutlet  var ageField: UITextField!
    let months = (0...11).map{"\($0)"}
    let years = (0...20).map{"\($0)"}
    var pickerView = UIPickerView()
    @IBOutlet  var petNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        newPetImageView.layer.cornerRadius = newPetImageView.frame.size.width/2
        
        pickerView.showsSelectionIndicator = true
        toolBar.barStyle = UIBarStyle.black
        toolBar.isTranslucent = true
        toolBar.tintColor = .white
        toolBar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePressed2))
        toolBar.setItems([cancelButton], animated: true)
        toolBar.isUserInteractionEnabled = true
    }
    
    @objc func donePressed() {
        petTypeField.resignFirstResponder()
        genderField.resignFirstResponder()
        ageField.resignFirstResponder()
        petNameTextField.resignFirstResponder()
    }
    @objc func donePressed2() {
        self.view.endEditing(true)
    }
    @IBAction func addNewPet(_ sender: Any) {
        let uid = Auth.auth().currentUser!.uid
        let collectionName = "users/\(uid)/pets"
        let petId = UUID()
//        Networking.createItem(newPet, inCollection: collectionName, withDocumentId: "\(petId)") {
//            print("   🚀🚀🚀🚀🚀🚀   ")
//        }
        let petName = petNameTextField.text!
        let petType = petTypeField.text!
        let petAge = ageField.text!
        let petGender = genderField.text!
        let petYear = year
        let petMonth = month
        
        
        let pet = Pet(petName: petName, petType: petType, petGender: petGender, petAge: petAge, petMonth: petMonth, petYear: petYear, imageUrl: self.imageurl?.absoluteString, id: "\(petId)")
        newPet.petName = petNameTextField.text!
        newPet.petAge = ageField.text!
        newPet.petType = petTypeField.text!
        newPet.petGender = genderField.text!
        let encodablePet = [try! FirebaseEncoder().encode(newPet)]
        Networking.createItem(pet, inCollection: collectionName, withDocumentId: "\(petId)") {
            print("New pet is added")
//            self.performSegue(withIdentifier: "add", sender: self)
        }
    }
    
    @IBAction func insertImageBtn(_ sender: Any) {
          let imageId = UUID()
        imagePicker.settings.selection.max = 1
        
        presentImagePicker(imagePicker, select: { (asset) in
            // User selected an asset. Do something with it. Perhaps begin processing/upload?
        }, deselect: { (asset : PHAsset) in
            // User deselected an asset. Cancel whatever you did when asset was selected.
        }, cancel: { (assets : [PHAsset]) in
            // User canceled selection.
        }, finish: { (assets : [PHAsset]) in
            self.newPetImageView.image = UploadImage().getAssetThumbnail(asset: assets[0])
            UploadImage.UploadImageAndGetUrl(path: "images", "\(imageId).png", ImageView: self.newPetImageView.image!) { (url: URL) in
                self.imageurl = url
                print(url)
            }
            
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "add" {
            let vc = segue.destination as! MultiPetsCollectionVC
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        if currentTextField == ageField {
            return 2
        }else {
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if currentTextField == petTypeField {
            return types.count
        }else if currentTextField == genderField {
            return gender.count
        }else if currentTextField == ageField {
            if component == 0 {
                return years.count
            }else if component == 1{
                return months.count
            }
        }
        return 0
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == petTypeField {
            return types[row]
        }else if currentTextField == genderField {
            return gender[row]
        }else if currentTextField == ageField {
            if component == 0 {
                return years[row]
            }else if component == 1{
                return months[row]
            }
        }
        return ""
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == petTypeField {
            currentTextField.text =  types[row]
            currentTextField.resignFirstResponder()
        }else if currentTextField == genderField {
            currentTextField.text = gender[row]
            currentTextField.resignFirstResponder()
        }else if currentTextField == ageField {
            let year = "\(pickerView.selectedRow(inComponent: 0)) سنه"
            let month = "\(pickerView.selectedRow(inComponent: 1)) شهر"
            currentTextField.text = year + month
            self.year = "\(pickerView.selectedRow(inComponent: 0))"
            self.month = "\(pickerView.selectedRow(inComponent: 1))"
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        currentTextField = textField
        if currentTextField == petTypeField {
            currentTextField.inputView = pickerView
            currentTextField.inputAccessoryView = toolBar
        }else if currentTextField == genderField {
            currentTextField.inputView = pickerView
            currentTextField.inputAccessoryView = toolBar
        }else if currentTextField == ageField {
            currentTextField.inputView = pickerView
            currentTextField.inputAccessoryView = toolBar
        }
    }
}

