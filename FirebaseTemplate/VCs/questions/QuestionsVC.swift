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
        let catQuestionsM = [
            Question(question: "هل يعاني \(self.petInfo.petName!) من اسهال؟"),
            Question(question: "هل لاحظت على \(self.petInfo.petName!) تورم في جفنه؟"),
            Question(question: "هل توجد على عين \(self.petInfo.petName!) بعض الافرازات؟"),
        ]
        let dogQuestionsM = [
            Question(question: "هل يعاني \(self.petInfo.petName!) من الم واحمرار في كفوفه؟"),
            Question(question: "هل لاحظت على كفوف \(self.petInfo.petName!) التورم والتقرح؟"),
            Question(question: "هل لاحظت على \(self.petInfo.petName!) قلة حركة ملحوظه والم في المفاصل؟")
        ]
        
        // F for Female
        let catQuestionsF = [
            Question(question: "هل تعاني \(self.petInfo.petName!) من اسهال؟"),
            Question(question: "هل لاحظت على \(self.petInfo.petName!) تورم في جفنها؟"),
            Question(question: "هل توجد على عين \(self.petInfo.petName!) بعض الافرازات؟"),
        ]
        let dogQuestionsF = [
            Question(question: "هل تعاني \(self.petInfo.petName!) من الم واحمرار في كفوفها؟"),
            Question(question: "هل لاحظت على كفوف \(self.petInfo.petName!) التورم والتقرح؟"),
            Question(question: "هل لاحظت على \(self.petInfo.petName!) قلة حركة ملحوظه والم في المفاصل؟")
        ]
        let packageNumber = checkAnswer(answer: answers)
        if i == catQuestionsM.count && self.petInfo.petType == "قطه" && self.petInfo.petGender == "ذكر"{
            switch packageNumber {
            case 1:
                choosePackage1(show: false, titleLabel: "بحاجه لتدخل طبي للاسهال !", btnTxt: "", petName: self.petInfo.petName!, title1: "")
            case 2:
                choosePackage2(pText: " فقط قم باتباع هذه الخطوات لحل مشكلة الاسهال", tips: catTipsP2, title: "عالج \(self.petInfo.petName!) في المنزل! ")
            case 3:
                choosePackage1(show: true, titleLabel: "بحاجه لتدخل طبي للاسهال !", btnTxt: "اضغط لحل مشكلة العين", petName: self.petInfo.petName!, title1: "عالج \(self.petInfo.petName!) في المنزل! ")
            case 4:
                choosePackage2(pText: "فقط قم باتباع هذه الخطوات لحل مشكلة العين و الاسهال", tips: catTipsP4, title: "عالج \(self.petInfo.petName!) في المنزل! ")
            case 5:
                choosePackage2(pText: "فقط قم باتباع هذه الخطوات لحل مشكلة العين", tips: catTipsP5, title: "عالج \(self.petInfo.petName!) في المنزل!")
            case 6:
                choosePackage1(show: false, titleLabel: "يمكن ان يكون بحاجه لتدخل طبي لشيء لا يعرفه iVet", btnTxt: "", petName: self.petInfo.petName!, title1: "")
            default:
                fatalError()
            }
        }else if self.petInfo.petType == "قطه" && i != catQuestionsM.count && self.petInfo.petGender == "ذكر"{
            questionLabel.text = "\(catQuestionsM[i].question)"
        }else if self.petInfo.petType == "قطه" && i == catQuestionsF.count && self.petInfo.petGender == "أنثى"{
            switch packageNumber {
            case 1:
                choosePackage1(show: false, titleLabel: "بحاجه لتدخل طبي للاسهال !", btnTxt: "", petName: (self.petInfo.petName)!, title1: "")
            case 2:
                choosePackage2(pText: "فقط قم باتباع هذه الخطوات لحل مشكلة الاسهال", tips: catTipsP2, title: "عالج \(self.petInfo.petName!) في المنزل! ")
            case 3:
                choosePackage1(show: true, titleLabel: "بحاجه لتدخل طبي للاسهال !", btnTxt: "اضغط لحل مشكلة العين", petName: (self.petInfo?.petName)!, title1: "عالج \(self.petInfo.petName!) في المنزل! ")
            case 4:
                choosePackage2(pText: "فقط قم باتباع هذه الخطوات لحل مشكلة العين و الاسهال", tips: catTipsP4, title: "عالج \(self.petInfo.petName!) في المنزل! ")
            case 5:
                choosePackage2(pText: "فقط قم باتباع هذه الخطوات لحل مشكلة العين", tips: catTipsP5, title: "عالج \(self.petInfo.petName!) في المنزل!")
            case 6:
                choosePackage1(show: false, titleLabel: "يمكن ان تكون بحاجه لتدخل طبي لشيء لا يعرفه iVet", btnTxt: "", petName: self.petInfo.petName!, title1: "")
            default:
                fatalError()
            }
        }else if self.petInfo.petType == "قطه" && i != catQuestionsF.count && self.petInfo.petGender == "أنثى" {
            questionLabel.text = "\(catQuestionsF[i].question)"
        }else if self.petInfo.petType == "كلب" && i == dogQuestionsM.count && self.petInfo.petGender == "ذكر" {
            switch packageNumber {
            case 7:
                choosePackage2(pText: "فقط قم باتباع هذه الخطوات لحل مشكلة الحروق", tips: dogTips7, title: "عالج \(self.petInfo.petName!) في المنزل!")
            case 8:
                choosePackage1(show: false, titleLabel: "بحاجه لتدخل طبي لامر غير طبيعي في مفاصله !", btnTxt: "", petName: self.petInfo.petName!, title1: "")
            case 9:
                choosePackage1(show: true, titleLabel: "بحاجه لتدخل طبي لامر غير طبيعي في مفاصله !", btnTxt: "اضغط لحل مشكلة الحروق", petName: self.petInfo.petName!, title1: "عالج \(self.petInfo.petName!) في المنزل! ")
            case 10:
                choosePackage1(show: false, titleLabel: "يمكن ان يكون بحاجه لتدخل طبي لشيء لا يعرفه iVet", btnTxt: "", petName: self.petInfo.petName!, title1: "")
            default:
                fatalError()
            }
        }else if i != dogQuestionsM.count && self.petInfo.petType == "كلب" && self.petInfo.petGender == "ذكر" {
            questionLabel.text = "\(dogQuestionsM[i].question)"
        }else if self.petInfo.petType == "كلب" && self.petInfo.petGender == "أنثى" && i == dogQuestionsF.count{
            switch packageNumber {
            case 7:
                choosePackage2(pText: "فقط قم باتباع هذه الخطوات لحل مشكلة الحروق", tips: dogTips7, title: "عالج \(petInfo.petName!) في المنزل! ")
            case 8:
                choosePackage1(show: false, titleLabel: "بحاجه لتدخل طبي لامر غير طبيعي في مفاصلها !", btnTxt: "", petName: self.petInfo.petName!, title1: "")
            case 9:
                choosePackage1(show: true, titleLabel: "بحاجه لتدخل طبي لامر غير طبيعي في مفاصلها !", btnTxt: "اضغط لحل مشكلة الحروق", petName: self.petInfo.petName!, title1: "عالج \(petInfo.petName!) في المنزل! ")
            case 10:
                choosePackage1(show: false, titleLabel: "يمكن ان تكون بحاجه لتدخل طبي لشيء لا يعرفه iVet", btnTxt: "", petName: self.petInfo.petName!, title1: "")
            default:
                fatalError()
            }
        }else if i != dogQuestionsF.count && self.petInfo.petType == "كلب" && self.petInfo.petGender == "أنثى"{
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
    func choosePackage1(show: Bool, titleLabel: String, btnTxt: String, petName: String, title1: String) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VetInfoVC") as! VetInfoVC
        vc.petInfo = self.petInfo
        vc.titleLabel = titleLabel
        vc.petName = petName
        vc.title1 = title1
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
    
    func choosePackage2(pText: String, tips: [String], title: String) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tips") as! tipsTableVC
        vc.tips = tips
        vc.subTitle! = pText
        vc.title1! = title
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

