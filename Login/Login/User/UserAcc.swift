//  UserAcc.swift
//  Login
//
//  Created by Madina Sadirmekova on 6/19/20.
//  Copyright © 2020 Madina Sadirmekova. All rights reserved.
//

import SwiftUI
import Firebase

struct Recent: Identifiable //used for Firebase
{
    //    var id = UUID()
    var id: String
    var name: String
    var time : String
    var date :  String
    var stamp: Date
    var lastmsg : String
    
    var address: String
    var floor: String
    var apartment: String
    var email: String
}

class User : ObservableObject //used to take up values from user
{
    //    var didChange = PassthroughSubject<Void, Never>()
    var id = ""
    @Published var name = ""
    @Published var email = ""
    @Published var address = ""
    @Published var floor = ""
    @Published var apartment = ""
    @Published var Card = ""
    @Published var selectedResidence = 0 //selection chosen from the picker
}

struct UserAcc: View {
    
    var color = Color("Camel")
    @State var users: [UserS] = []
    @EnvironmentObject var user: User
    @EnvironmentObject var datas : MainObservable
    
    
    var body: some View {
        VStack{
            ForEach(datas.recents) { i in
                Text("Name: \(i.name)")
                    .frame(width: 350, height: 20)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.user.email != "" ? Color("ColorWhite") : self.color,lineWidth: 2))
                    .padding(.top, 10)

                //            HStack{
                //                Text("Email: \(user.name)")
                //                TextField("Email", text: $user.email)
                //                .frame(width: 350, height: 20)
                //                .padding()
                //                .background(RoundedRectangle(cornerRadius: 4).stroke(self.user.email != "" ? Color("ColorWhite") : self.color,lineWidth: 2))
                //                .padding(.top, 10)
                //            }

                Text("Address: \(i.address)")
                    .frame(width: 350, height: 20)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.user.email != "" ? Color("ColorWhite") : self.color,lineWidth: 2))
                    .padding(.top, 10)
                Text("Floor: \(i.floor)")
                    .frame(width: 350, height: 20)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.user.email != "" ? Color("ColorWhite") : self.color,lineWidth: 2))
                    .padding(.top, 10)
                Text("Apartment: \(i.apartment)")
                    .frame(width: 350, height: 20)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.user.email != "" ? Color("ColorWhite") : self.color,lineWidth: 2))
                    .padding(.top, 10)

            }//end of For Loop
            
        Button(action: {
            
            try! Auth.auth().signOut()
            UserDefaults.standard.set(false, forKey: "status")
            NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
            
        }) {
            Text("Log out")
                .frame(width: 320, height: 40)
                .background(RoundedRectangle(cornerRadius: 4).stroke(Color("Camel"),lineWidth: 2))
                .foregroundColor(Color("Camel"))
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width - 50)
            }
        }//end of VStack
    }
}
