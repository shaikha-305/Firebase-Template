//
//  VetInfoModel.swift
//  iVetAR
//
//  Created by Huda on 7/11/20.
//  Copyright © 2020 shaikha aljenaidel. All rights reserved.
//

import Foundation

struct Vet {
    var name: String
    var phoneNumber: String
    
    func setPhoneLabel() -> String {
        return "رقم الهاتف: \(phoneNumber)"
    }
}

var vets = [
Vet(name: "د. محمود", phoneNumber: "60654845"),
Vet(name: "د. عادل", phoneNumber: "99838326"),
Vet(name: "د. بيطري", phoneNumber: "55279080"),
Vet(name: "د. احمد", phoneNumber: "66910025")
]
