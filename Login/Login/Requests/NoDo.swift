//
//  ToDo.swift
//  Login
//
//  Created by Madina Sadirmekova on 6/22/20.
//  Copyright © 2020 Madina Sadirmekova. All rights reserved.
//

//import Foundation
//import SwiftUI
//
//let dataFormatter = DateFormatter()
//
//struct NoDo: Identifiable, Decodable, Encodable{
//    var id = UUID() //8sddzzyald
//    var name: String = "Hello Item"
//    var isDone: Bool = false
//    private let dateAdded = Date()
//    var dateText: String {
//         dateFormatter.dateFormat = "MMM d yyyy, h:mm a"
//
//        return dateFormatter.string(from: dateAdded)
//    }
//}
import Foundation
import SwiftUI

let dateFormatter = DateFormatter()

struct NoDo:Identifiable, Decodable, Encodable {
    var id = UUID() //8sddzzyald
    var name: String = "Hello Item"
    var isDone: Bool = false
    private let dateAdded = Date()
    var dateText: String {
         dateFormatter.dateFormat = "MMM d yyyy, h:mm a"
        
        return dateFormatter.string(from: dateAdded)
    }
}
