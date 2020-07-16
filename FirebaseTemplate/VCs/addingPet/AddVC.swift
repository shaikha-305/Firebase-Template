//
//  AddVC.swift
//  iVetAR
//
//  Created by Huda on 7/12/20.
//  Copyright © 2020 shaikha aljenaidel. All rights reserved.
//

import UIKit

class AddVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    
    var newPet: Profile = Profile(petName: "", petType: "", petGender: "", petAge: "")
    @IBOutlet  var petTypeField: UITextField!
    var currentTextField: UITextField!
    let types = ["قطه", "كلب"]
    @IBOutlet  var genderField: UITextField!
    let gender = ["Female", "Male"]
    @IBOutlet  var ageField: UITextField!
    let age = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30"]
    var pickerView = UIPickerView()
    @IBOutlet  var petNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addNewPet(_ sender: Any) {
        newPet.petName = petNameTextField.text!
        newPet.petAge = ageField.text!
        newPet.petType = petTypeField.text!
        newPet.petGender = genderField.text!
//        myPets.append(newPet)
        performSegue(withIdentifier: "multiPets", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "multiPets" {
            let vc = segue.destination as! MultiPetsVC
            vc.temporary = newPet
    }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if currentTextField == petTypeField {
        return types.count
        }else if currentTextField == genderField {
            return gender.count
        }else if currentTextField == ageField {
            return age.count
        }else {
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == petTypeField {
        return types[row]
        }else if currentTextField == genderField {
            return gender[row]
        }else if currentTextField == ageField {
            return age[row]
        }else {
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == petTypeField {
               currentTextField.text =  types[row]
               currentTextField.resignFirstResponder()
              }else if currentTextField == genderField {
               currentTextField.text = gender[row]
               currentTextField.resignFirstResponder()
              }else if currentTextField == ageField {
               currentTextField.text = age[row]
               currentTextField.resignFirstResponder()

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
