//  AccountCreation.swift
//  Login
//
//  Created by Madina Sadirmekova on 7/26/20.
//  Copyright © 2020 Madina Sadirmekova. All rights reserved.
//

import SwiftUI
import Firebase

struct AccountCreation : View{
    
    @Binding var show : Bool
    @State var picker = false
    @State var loading = false
    @State var alert = false
    
    @State var name = ""
    @State var email = ""
    @State var address = ""
    @State var floor = ""
    @State var apartment = ""
    @State var staff = false
    @State var staffId = ""
    @State var color = Color.black.opacity(0.7)

    
    
    var residences = ["Rixos Khan Shatyr Residences", "Orion", "No Name", "No Name"]
    @State private var selectedResidence = 0 //selection chosen from the picker
    
    var body : some View{
        
        ZStack{
            BackSplash()
                
            VStack(alignment: .leading, spacing: 15){
                
//                Image("Horse2")
//                    .resizable()
//                    .frame(width: 200, height: 150)
//                    .scaledToFill()
                
                TextField("Email", text: $email)
                    .foregroundColor(Color("Camel"))
                    .autocapitalization(.none)
                    .frame(width: 350, height: 20)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(Color("Camel"),lineWidth: 2))
                    .padding(.top, 25)
                
                TextField("Name", text: $name)
                    .foregroundColor(Color("Camel"))
                    .autocapitalization(.none)
                    .frame(width: 350, height: 20)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(Color("Camel"),lineWidth: 2))
                    .padding(.top, 25)
                
                Toggle(isOn: self.$staff)
                {
                    Text("Staff")
                        .foregroundColor(Color("Camel"))
                }
                .autocapitalization(.none)
                .frame(width: 350, height: 20)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(Color("Camel"),lineWidth: 2))
                .padding(.top, 25)
                
                if self.staff {
                    TextField("Enter your ID: ", text: self.$staffId)
                        .autocapitalization(.none)
                        .frame(width: 350, height: 20)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(Color("Camel"),lineWidth: 2))
                        .padding(.top, 25)
                }
                
                Picker(selection: $selectedResidence, label: Text("Your Residence")) {
                    ForEach(0 ..< residences.count) {
                        Text(self.residences[$0])
                    }
                }
                
                TextField("Enter your address", text: $address)
                    .frame(width: 350, height: 20)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(Color("Camel"),lineWidth: 2))
                    .padding(.top, 25)
                
                TextField("Enter your floor", text: $floor)
                    .frame(width: 350, height: 20)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(Color("Camel"),lineWidth: 2))
                    .padding(.top, 25)
                
                TextField("Enter your apartment number", text: $apartment)
                    .frame(width: 350, height: 20)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(Color("Camel"),lineWidth: 2))
                    .padding(.top, 25)
                
                if self.loading{
                    
                    HStack{
                        
                        Spacer()
                        
                        Indicator()
                        
                        Spacer()
                    }
                }
                    
                else{
                    
                    Button(action: {
                        
                        if self.name != "" {
                            
                            self.loading.toggle()
                            CreateUser(name: self.name, email: self.email, address: self.address, residence: self.selectedResidence, floor: self.floor, apartment: self.apartment) { (status) in
                                
                                if status{
                                    self.show.toggle()
                                }
                            }
                        }
                        else{
                            self.alert.toggle()
                        }
                        
                    }) {
                        
                        Text("Create").frame(width: UIScreen.main.bounds.width - 30,height: 50)
                        
                    }.foregroundColor(.white)
                        .background(Color.orange)
                        .cornerRadius(10)
                    
                }
                
            }
        }
        .alert(isPresented: self.$alert) {
            
            Alert(title: Text("Message"), message: Text("Please Fill The Contents"), dismissButton: .default(Text("Ok")))
        }
    }
}
