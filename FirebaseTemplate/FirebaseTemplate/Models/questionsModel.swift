//
//  questionsModel.swift
//  iVetAR
//
//  Created by Huda on 7/7/20.
//  Copyright © 2020 shaikha aljenaidel. All rights reserved.
//

import Foundation

struct Question {
    var question: String
    
   
}

// M for male
//var catQuestionsM = [
//    Question(question: "هل يعاني \(myPet.petName) من اسهال؟"),
//    Question(question: "هل لاحظت على \(myPet.petName) تورم في جفنه؟"),
//    Question(question: "هل توجد على عين \(myPet.petName) بعض الافرازات؟"),
//]
//var dogQuestionsM = [
//    Question(question: "هل يعاني \(myPet.petName) من الم واحمرار في كفوفه؟"),
//    Question(question: "هل لاحظت على كفوف \(myPet.petName) التورم والتقرح؟"),
//    Question(question: "هل لاحظت على \(myPet.petName) قلة حركة ملحوظه والم في المفاصل؟")
//]

// F for Female
//var catQuestionsF = [
//    Question(question: "هل تعاني \(myPet.petName) من اسهال؟"),
//    Question(question: "هل لاحظت على \(myPet.petName) تورم في جفنها؟"),
//    Question(question: "هل توجد على عين \(myPet.petName) بعض الافرازات؟"),
//]
//var dogQuestionsF = [
//    Question(question: "هل تعاني \(myPet.petName) من الم واحمرار في كفوفها؟"),
//    Question(question: "هل لاحظت على كفوف \(myPet.petName) التورم والتقرح؟"),
//    Question(question: "هل لاحظت على \(myPet.petName) قلة حركة ملحوظه والم في المفاصل؟")
//]
//
//
//func checkAnswer(answer: [Int]) -> Int{
//    if myPet.petType == "قطه"{
//       if answer == [0,1,0,0] {
//           return 1
//       } else if answer == [1,1,0,0] {
//           return 2
//       } else if answer == [0,1,1,1] || answer == [0,1,1,0] || answer == [1,1,0,1] {
//           return 3
//       } else if answer == [1,1,1,1]  || answer == [1,1,1,0] || answer == [1,1,0,1]{
//           return 4
//       } else if answer == [1,0,1,1] || answer == [0,0,1,1] || answer == [0,0,1,0] || answer == [1,0,1,0] || answer == [0,0,0,1] || answer == [1,0,0,1] {
//           return 5
//       } else if answer == [1,0,0,0] || answer == [0,0,0,0]{
//           return 6
//       }
//    }else if myPet.petType == "كلب"{
//        if answer == [1,0,0] || answer == [1,1,0] || answer == [0,1,0] {
//            return 7
//        } else if answer == [0,0,1] {
//           return 8
//        }else if answer == [1,1,1] || answer == [1,0,1] || answer == [0,1,1] || answer == [0,0,1] {
//            return 9
//        }else if answer == [0,0,0] {
//            return 10
//        }
//    }
//    return 0
//}
//
//
