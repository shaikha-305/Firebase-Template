//
//  SignUpVC.swift
//  iVetAR
//
//  Created by Huda on 7/6/20.
//  Copyright © 2020 shaikha aljenaidel. All rights reserved.
//
import Firebase
import UIKit
import BSImagePicker
import Photos

class SignUpVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    var year: String!
    var month: String!
    var imageurl: URL?
    @IBOutlet var petImageView: UIImageView!
    let imagePicker = ImagePickerController()
    var petInfo: Pet!
    var userInfo: User!
    @IBOutlet weak var petTypeField: UITextField!
    var currentTextField: UITextField!
    let types = ["","قطه", "كلب"]
    @IBOutlet weak var genderField: UITextField!
    let gender = ["","أنثى", "ذكر"]
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var monthLabel: UILabel!
    let months = (0...11).map{"\($0)"}
    let years = (0...20).map{"\($0)"}
    var pickerView = UIPickerView()
    @IBOutlet weak var petNameTextField: UITextField!
    @IBOutlet weak var ownerNameTextField: UITextField!
    var flag = 0
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        petImageView.layer.cornerRadius = petImageView.frame.size.width/2
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButton(_ sender: Any) {
      
        let error = validateTheFields()
        if error != nil{
            errorMessage(message: " املاأ جميع الفراغات😅")
        }else{
            let email = emailTextField.text!
            let password = passwordTextField.text!
            let conformPassword = confirmPasswordField.text!
            let ownerName = ownerNameTextField.text!
            let petName = petNameTextField.text!
            let petType = petTypeField.text!
            let petAge = ageField.text!
            let petGender = genderField.text!
            let petMonth = month
            let petYear = year
            let petId = UUID()
            let uid = Auth.auth().currentUser?.uid
            let user = User(ownerName: ownerName,
                            email: email)
            let pet = Pet(petName: petName, petType: petType, petGender: petGender, petAge: petAge, petMonth: petMonth, petYear: petYear, imageUrl: self.imageurl?.absoluteString, id: "\(petId)")
            if validatePassword(password: password, conformPassword: conformPassword){
                Networking.signUp(user: user, password: password, success:  { uid in
                    // ✅ Success
                    Networking.createItem(pet, inCollection: "users/\(uid)/pets", withDocumentId: "\(petId)") {
                        print("🚀")
                    }
                    self.getData()
                }){
                    // ❌ Failed
                    self.errorMessage(message: "لا يمكننا تسجيل الدخول الرجاء التأكد من البريد الالكتروني وكلمة المرور!")
                }
            }
            else{
                errorMessage(message: "كلمة المرور لا تتطابق😅")
            }
        }
        
    }
    func validatePassword(password: String, conformPassword: String) -> Bool{
        return password == conformPassword
    }
    
    func errorMessage(message: String){
        let alertController = UIAlertController(title: "Opps🙈", message: message , preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signUp" {
            let vc = segue.destination as! MultiPetsCollectionVC
            
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
            let imageId = UUID()
            self.petImageView.image = UploadImage().getAssetThumbnail(asset: assets[0])
            
            UploadImage.UploadImageAndGetUrl(path: "images", "\(imageId).png", ImageView: self.petImageView.image!) { (url: URL) in
                self.imageurl = url
                print(url)
            }
        })
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
            let year = "\(pickerView.selectedRow(inComponent: 0)) سنه و "
            let month = "\(pickerView.selectedRow(inComponent: 1)) شهور"
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
        }else if currentTextField == genderField {
            currentTextField.inputView = pickerView
        }else if currentTextField == ageField {
            currentTextField.inputView = pickerView
        }
    }
    
    func validateTheFields() -> String? {
        if  confirmPasswordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            petTypeField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""     ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            genderField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            ageField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            petNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            ownerNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "املأ جميع الفراغات"
        }
        return nil
    }
    func getData() {
        guard let userID = Auth.auth().currentUser?.uid else {
            fatalError("this user doesnt exist")
        }
        Networking.getSingleDocument("users/\(userID)", success: { (userInfo: Pet) in
            DispatchQueue.main.async {
                self.petInfo = userInfo
                self.performSegue(withIdentifier: "signUp", sender: self)
            }
            
        }) { (err) in
            print(err)
        }
    }
}



