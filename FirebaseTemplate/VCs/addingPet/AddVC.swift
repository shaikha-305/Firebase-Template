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

class AddVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    var year: String!
    var month: String!
    var imageurl: URL!
    var newPet: Pet = Pet(petName: "", petType: "", petGender: "", petAge: "", petMonth: "", petYear: "")
    @IBOutlet  var petTypeField: UITextField!
    var currentTextField: UITextField!
    let types = ["قطه", "كلب"]
    @IBOutlet  var genderField: UITextField!
    let gender = ["Female", "Male"]
    @IBOutlet  var ageField: UITextField!
    let months = (0...12).map{"\($0)"}
    let years = (0...20).map{"\($0)"}
    var pickerView = UIPickerView()
    @IBOutlet  var petNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addNewPet(_ sender: Any) {
        let uid = Auth.auth().currentUser!.uid
        let collectionName = "pets/\(uid)/data"
        Networking.createItem(newPet, inCollection: collectionName) {
            print("   🚀🚀🚀🚀🚀🚀   ")
        }
        let petName = petNameTextField.text!
        let petType = petTypeField.text!
        let petAge = ageField.text!
        let petGender = genderField.text!
        let petYear = year
        let petMonth = month
        let pet = Pet(petName: petName, petType: petType, petGender: petGender, petAge: petAge, petMonth: petMonth, petYear: petYear, imageUrl: self.imageurl)
        newPet.petName = petNameTextField.text!
        newPet.petAge = ageField.text!
        newPet.petType = petTypeField.text!
        newPet.petGender = genderField.text!
        let encodablePet = [try! FirebaseEncoder().encode(newPet)]
        Networking.createItem(pet, inCollection: "users/\(uid)/pets") {
            print("New pet is added")
            self.performSegue(withIdentifier: "add", sender: self)
        }
//        Networking.myFuncForUploadItem(pet, inCollection: "pets", nameDocmount: "data", nameCollection: uid!, name2Docmount: "1", success: {
//                print("your pet has been added successfully✅")
//
//        })
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "add" {
            let vc = segue.destination as! MultiPetsCollectionVC
            
//            vc.temporary = newPet
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
//            yearLabel.text = "\(pickerView.selectedRow(inComponent: 0))"
//            monthLabel.text = "\(pickerView.selectedRow(inComponent: 1))"
           }
        }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        currentTextField = textField
        if currentTextField == petTypeField {
            currentTextField.inputView = pickerView
        }else if currentTextField == genderField {
            currentTextField.inputView = pickerView
        }else if currentTextField == ageField {
            currentTextField.inputView = pickerView
        }
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
