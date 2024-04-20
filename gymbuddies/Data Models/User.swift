//
//  User.swift
//  gymbuddies
//
//  Created by Vishaq Jayakumar on 4/17/24.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable{
    @DocumentID var id: String?
    var name: String
    var email: String
    var workout: String?


//    init(name: String, email: String, workout: String) {
//        self.name = name
//        self.email = email
//        self.workout = workout
//    }
}
