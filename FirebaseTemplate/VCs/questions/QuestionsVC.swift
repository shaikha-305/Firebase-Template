//
//  QuestionsVC.swift
//  iVetAR
//
//  Created by Huda on 7/6/20.
//  Copyright © 2020 shaikha aljenaidel. All rights reserved.
//

import UIKit

class QuestionsVC: UIViewController {
    var petInfo: Pet!
    var year: String?
    var month: String?
    var answers: [Int] = []
    var i = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var petTypeImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        petTypeImg.image = UIImage(named: (self.petInfo?.petType)!)
        if self.petInfo?.petType == "قطه" {
            checkCatAge()
        }
        setQuestionLabel()
        questionLabel.numberOfLines = 0
        // Do any additional setup after loading the view.
    }
    
    @IBAction func yesBtn(_ sender: Any) {
        answers.append(1)
        i += 1
        setQuestionLabel()
    }
    @IBAction func noBtn(_ sender: Any) {
        answers.append(0)
        i += 1
        setQuestionLabel()
    }
    
    func setQuestionLabel() {
        // M for male
        var catQuestionsM = [
            Question(question: "هل يعاني \(self.petInfo.petName!) من اسهال؟"),
            Question(question: "هل لاحظت على \(self.petInfo.petName!) تورم في جفنه؟"),
            Question(question: "هل توجد على عين \(self.petInfo.petName!) بعض الافرازات؟"),
        ]
        var dogQuestionsM = [
            Question(question: "هل يعاني \(self.petInfo.petName!) من الم واحمرار في كفوفه؟"),
            Question(question: "هل لاحظت على كفوف \(self.petInfo.petName!) التورم والتقرح؟"),
            Question(question: "هل لاحظت على \(self.petInfo.petName!) قلة حركة ملحوظه والم في المفاصل؟")
        ]
        
        // F for Female
        var catQuestionsF = [
            Question(question: "هل تعاني \(self.petInfo.petName!) من اسهال؟"),
            Question(question: "هل لاحظت على \(self.petInfo.petName!) تورم في جفنها؟"),
            Question(question: "هل توجد على عين \(self.petInfo.petName!) بعض الافرازات؟"),
        ]
        var dogQuestionsF = [
            Question(question: "هل تعاني \(self.petInfo.petName!) من الم واحمرار في كفوفها؟"),
            Question(question: "هل لاحظت على كفوف \(self.petInfo.petName!) التورم والتقرح؟"),
            Question(question: "هل لاحظت على \(self.petInfo.petName!) قلة حركة ملحوظه والم في المفاصل؟")
        ]
        let packageNumber = checkAnswer(answer: answers)
        if i == catQuestionsM.count && self.petInfo.petType == "قطه" && self.petInfo.petGender == "Male"{
            switch packageNumber {
            case 1:
                choosePackage1(show: false, titleLabel: "بحاجه لتدخل طبي للاسهال !", btnTxt: "", petName: self.petInfo.petName)
            case 2:
                choosePackage2(pText: " فقط قم باتباع هذه الخطوات لحل مشكلة الاسهال عند \(self.petInfo.petName)", tips: catTipsP2)
            case 3:
                choosePackage1(show: true, titleLabel: "بحاجه لتدخل طبي للاسهال !", btnTxt: "اضغط لحل مشكلة العين", petName: self.petInfo.petName)
            case 4:
                choosePackage2(pText: "فقط قم باتباع هذه الخطوات لحل مشكلة العين و الاسهال عند \(self.petInfo.petName)", tips: catTipsP4)
            case 5:
                choosePackage2(pText: "فقط قم باتباع هذه الخطوات لحل مشكلة العين عند \(self.petInfo.petName)", tips: catTipsP5)
            case 6:
                choosePackage1(show: false, titleLabel: "يمكن ان يكون بحاجه لتدخل طبي لشيء لا يعرفه iVet", btnTxt: "", petName: self.petInfo.petName)
            default:
                fatalError()
            }
        }else if self.petInfo.petType == "قطه" && i != catQuestionsM.count && self.petInfo.petGender == "Male"{
            questionLabel.text = "\(catQuestionsM[i].question)"
        }else if self.petInfo.petType == "قطه" && i == catQuestionsF.count && self.petInfo.petGender == "Female"{
            switch packageNumber {
            case 1:
                choosePackage1(show: false, titleLabel: "بحاجه لتدخل طبي للاسهال !", btnTxt: "", petName: (self.petInfo.petName)!)
            case 2:
                choosePackage2(pText: " فقط قم باتباع هذه الخطوات لحل مشكلة الاسهال عند \(self.petInfo.petName)", tips: catTipsP2)
            case 3:
                choosePackage1(show: true, titleLabel: "بحاجه لتدخل طبي للاسهال !", btnTxt: "اضغط لحل مشكلة العين", petName: (self.petInfo?.petName)!)
            case 4:
                choosePackage2(pText: "فقط قم باتباع هذه الخطوات لحل مشكلة العين و الاسهال عند \(self.petInfo.petName)", tips: catTipsP4)
            case 5:
                choosePackage2(pText: "فقط قم باتباع هذه الخطوات لحل مشكلة العين عند \(self.petInfo.petName)", tips: catTipsP5)
            case 6:
                choosePackage1(show: false, titleLabel: "يمكن ان تكون بحاجه لتدخل طبي لشيء لا يعرفه iVet", btnTxt: "", petName: self.petInfo.petName)
            default:
                fatalError()
            }
        }else if self.petInfo.petType == "قطه" && i != catQuestionsF.count && self.petInfo.petGender == "Female" {
            questionLabel.text = "\(catQuestionsF[i].question)"
        }else if self.petInfo.petType == "كلب" && i == dogQuestionsM.count && self.petInfo.petGender == "Male" {
            switch packageNumber {
            case 7:
                choosePackage2(pText: "فقط قم باتباع هذه الخطوات لحل مشكلة الحروق عند \(self.petInfo.petName)", tips: dogTips7)
            case 8:
                choosePackage1(show: false, titleLabel: "بحاجه لتدخل طبي لامر غير طبيعي في مفاصله !", btnTxt: "", petName: self.petInfo.petName)
            case 9:
                choosePackage1(show: true, titleLabel: "بحاجه لتدخل طبي لامر غير طبيعي في مفاصله !", btnTxt: "اضغط لحل مشكلة الحروق", petName: self.petInfo.petName)
            case 10:
                choosePackage1(show: false, titleLabel: "يمكن ان يكون بحاجه لتدخل طبي لشيء لا يعرفه iVet", btnTxt: "", petName: self.petInfo.petName)
            default:
                fatalError()
            }
        }else if i != dogQuestionsM.count && self.petInfo.petType == "كلب" && self.petInfo.petGender == "Male" {
            questionLabel.text = "\(dogQuestionsM[i].question)"
        }else if self.petInfo.petType == "كلب" && self.petInfo.petGender == "Female" && i == dogQuestionsF.count{
            switch packageNumber {
            case 7:
                choosePackage2(pText: "فقط قم باتباع هذه الخطوات لحل مشكلة الحروق عند \(self.petInfo.petName)", tips: dogTips7)
            case 8:
                choosePackage1(show: false, titleLabel: "بحاجه لتدخل طبي لامر غير طبيعي في مفاصلها !", btnTxt: "", petName: self.petInfo.petName)
            case 9:
                choosePackage1(show: true, titleLabel: "بحاجه لتدخل طبي لامر غير طبيعي في مفاصلها !", btnTxt: "اضغط لحل مشكلة الحروق", petName: self.petInfo.petName)
            case 10:
                choosePackage1(show: false, titleLabel: "يمكن ان تكون بحاجه لتدخل طبي لشيء لا يعرفه iVet", btnTxt: "", petName: self.petInfo.petName)
            default:
                fatalError()
            }
        }else if i != dogQuestionsF.count && self.petInfo.petType == "كلب" && self.petInfo.petGender == "Female"{
            questionLabel.text = "\(dogQuestionsF[i].question)"
        }
    }
    
    func checkAnswer(answer: [Int]) -> Int{
        if self.petInfo.petType == "قطه"{
            if answer == [0,1,0,0] {
                return 1
            } else if answer == [1,1,0,0] {
                return 2
            } else if answer == [0,1,1,1] || answer == [0,1,1,0] || answer == [1,1,0,1] {
                return 3
            } else if answer == [1,1,1,1]  || answer == [1,1,1,0] || answer == [1,1,0,1]{
                return 4
            } else if answer == [1,0,1,1] || answer == [0,0,1,1] || answer == [0,0,1,0] || answer == [1,0,1,0] || answer == [0,0,0,1] || answer == [1,0,0,1] {
                return 5
            } else if answer == [1,0,0,0] || answer == [0,0,0,0]{
                return 6
            }
        }else if self.petInfo.petType == "كلب"{
            if answer == [1,0,0] || answer == [1,1,0] || answer == [0,1,0] {
                return 7
            } else if answer == [0,0,1] {
                return 8
            }else if answer == [1,1,1] || answer == [1,0,1] || answer == [0,1,1] || answer == [0,0,1] {
                return 9
            }else if answer == [0,0,0] {
                return 10
            }
        }
        return 0
    }
    func choosePackage1(show: Bool, titleLabel: String, btnTxt: String, petName: String) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VetInfoVC") as! VetInfoVC
        vc.petInfo = self.petInfo
        vc.titleLabel = titleLabel
        vc.petName = petName
        if show == false {
            vc.showButton = false
            vc.btnText = btnTxt
        } else {
            vc.showButton = true
            vc.btnText = btnTxt
        }
        self.navigationController?.pushViewController(vc, animated: true)
        view.window?.rootViewController = vc
        view.window?.makeKeyAndVisible()
    }
    
    func choosePackage2(pText: String, tips: [String]) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tips") as! tipsTableVC
        vc.tips = tips
        vc.subTitle = pText
        self.navigationController?.pushViewController(vc, animated: true)
        view.window?.rootViewController = vc
        view.window?.makeKeyAndVisible()
    }
    func calculateAge() -> Int{
        let result = (Int(petInfo.petYear)! * 12) + Int(petInfo.petMonth)!
        return result
    }
    func checkCatAge() {
        let ageInMonths = calculateAge()
        if  ageInMonths >= 4{
            answers.append(1)
        }else {
            answers.append(0)
        }
    }
}

