//
//  MainObservable.swift
//  Login
//
//  Created by Madina Sadirmekova on 7/22/20.
//  Copyright © 2020 Madina Sadirmekova. All rights reserved.
//

import SwiftUI
import Firebase

//this class is fetching data from Firebase
class MainObservable : ObservableObject{
    @Published var recents = [Recent]()
    @Published var norecetns = false
    
    init() {
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        
        if let uid = uid{
            
            db.collection("users").document(uid).collection("recents").order(by: "date", descending: true).addSnapshotListener { (snap, err) in
                
                if err != nil{
                    print((err?.localizedDescription)!)
                    self.norecetns = true
                    return
                }
                
                if snap!.isEmpty{
                    self.norecetns = true
                }
                
                for i in snap!.documentChanges{
                    
                    if i.type == .added{
                        
                        let id = i.document.documentID
                        let name = i.document.get("name") as? String ?? ""
                        let email = i.document.get("email") as? String ?? ""
                        let address = i.document.get("address") as? String ?? ""
                        let floor = i.document.get("floor") as? String ?? ""
                        let apartment = i.document.get("apartment") as? String ?? ""
                        let lastmsg = i.document.get("lastmsg") as? String ?? ""
                        let stamp = i.document.get("date") as! Timestamp
                        
                        let formatter = DateFormatter()
                        formatter.dateFormat = "dd/MM/yy"
                        let date = formatter.string(from: stamp.dateValue())
                        
                        formatter.dateFormat = "hh:mm a"
                        let time = formatter.string(from: stamp.dateValue())
                        
                        self.recents.append(Recent(id: id, name: name, time: time, date: date, stamp: stamp.dateValue(), lastmsg: lastmsg, address: address, floor: floor, apartment: apartment, email: email))
                    }
                    
                    if i.type == .modified{
                        let id = i.document.documentID
                        let lastmsg = i.document.get("lastmsg") as! String
                        let stamp = i.document.get("date") as! Timestamp
                        
                        let formatter = DateFormatter()
                        formatter.dateFormat = "dd/MM/yy"
                        let date = formatter.string(from: stamp.dateValue())
                        
                        formatter.dateFormat = "hh:mm a"
                        let time = formatter.string(from: stamp.dateValue())
                        
                        for j in 0..<self.recents.count{
                            
                            if self.recents[j].id == id{
                                
                                self.recents[j].lastmsg = lastmsg
                                self.recents[j].time = time
                                self.recents[j].date = date
                                self.recents[j].stamp = stamp.dateValue()
                            }
                        }
                    }
                }
            }
        }
        else{
            print("error")
        }
        
    }
}
