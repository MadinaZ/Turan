//
//  Scroll.swift
//  Login
//
//  Created by Madina Sadirmekova on 7/14/20.
//  Copyright © 2020 Madina Sadirmekova. All rights reserved.
//
import FirebaseFirestore
import Foundation
import SwiftUI
import Firebase

struct ScrollItem : Identifiable{
    var id: String
    var title: String
    var pic: String
}

class getScrollItem : ObservableObject{
    
    @Published var datas = [ScrollItem]()
    
    init() {
        let db = Firestore.firestore()
        
        db.collection("Items").addSnapshotListener { (snap, err) in
            
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documentChanges{
                
                let id = i.document.documentID
                let title = i.document.get("name") as! String
                let pic = i.document.get("pic") as! String
                
                self.datas.append(ScrollItem(id: id, title: title, pic: pic))
            }
            
        }
    }
}
