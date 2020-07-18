
import Foundation
import FirebaseFirestore
import class Firebase.User
typealias FirebaseUser = Firebase.User


struct User: Codable{
    var ownerName: String!
    var email: String!
//    var petName: String!
//    var petType: String!
//    var petGender: String!
//    var petAge: String!
//    var petMonth: String!
//    var petYear: String!
//    var imageUrl: String?
}

struct Pet: Codable{
    var petName: String!
    var petType: String!
    var petGender: String!
    var petAge: String!
    var petMonth: String!
    var petYear: String!
    var imageUrl: String?
}
var myPets: [Pet] = [Pet(petName: "", petType: "", petGender: "", petAge: "", petMonth: "", petYear: "")]


struct SignInCredentials: Encodable
{
    var email: String
    var password: String
}
