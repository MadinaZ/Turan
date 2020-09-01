//
//  CreateUser.swift
//  Login
//
//  Created by Madina Sadirmekova on 7/22/20.
//  Copyright © 2020 Madina Sadirmekova. All rights reserved.
//

import Foundation
import Firebase

//this func sets data to Firebase
func CreateUser(name: String, email: String, address : String, residence: Int, floor: String, apartment: String, completion: @escaping (Bool)-> Void){

    let db = Firestore.firestore()
    let uid = Auth.auth().currentUser?.uid

    let residences = ["Rixos Khan Shatyr Residences", "Orion", "No Name", "No Name"]

    if let uid = uid {

        db.collection("users").document(uid).setData(["name": name, "email": email, "address": address, "residence": residences[residence], "floor": floor, "apartment": apartment, "uid":uid]) { (err) in

            if err != nil{

                print((err?.localizedDescription)!)
                return
            }

            completion(true)

            UserDefaults.standard.set(true, forKey: "status")

            UserDefaults.standard.set(name, forKey: "UserName")

            UserDefaults.standard.set(uid, forKey: "UID")

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {

                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
            }
        }
    }
    else{
        print("error")
    }

}


func checkUser(completion: @escaping (Bool,String,String)->Void){
     
    let db = Firestore.firestore()
    
    db.collection("users").getDocuments { (snap, err) in
        
        if err != nil{
            
            print((err?.localizedDescription)!)
            return
        }
        
        for i in snap!.documents{
            
            if i.documentID == Auth.auth().currentUser?.uid{
                
                completion(true,i.get("name") as! String,i.documentID)
                return
            }
        }
        
        completion(false,"","")
    }
    
}
