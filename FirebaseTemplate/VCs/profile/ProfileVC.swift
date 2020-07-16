//
//  ProfileVC.swift
//  iVetAR
//
//  Created by Huda on 7/6/20.
//  Copyright © 2020 shaikha aljenaidel. All rights reserved.
//
import Firebase
import UIKit

class ProfileVC: UIViewController {
    var year: String!
    var month: String!
    var petInfo: User!
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
        Networking.getSingleDocument("users/\(userID)", success: { (userInfo: User) in
            self.petInfo = userInfo
            myPets.append(self.petInfo)
            self.displayingData()
        }) { (err) in
            print(err)
        }
                Networking.getDocumentOfCollection(DOCUMENT_PATH: "users/\(userID)") { (userInfo: User) in
                    self.petInfo = userInfo
                    self.reloadInputViews()
                    self.displayingData()
                    self.reloadInputViews()
                }
    }
    
    @IBAction func doYouNeedHelpButton(_ sender: Any) {
        performSegue(withIdentifier: "questions", sender: self)
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
        petNameTextView.text = petInfo?.petName ?? ""
        petAgeTextView.text = petInfo?.petAge ?? ""
        petTypeTextView.text = petInfo?.petType ?? ""
        petGenderTextView.text = petInfo?.petGender ?? ""
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

