//
//  ContentView.swift
//  Login
//
//  Created by Madina Sadirmekova on 6/1/20.
//  Copyright © 2020 Madina Sadirmekova. All rights reserved.
//

import SwiftUI
import Firebase
import Combine
import FirebaseFirestore

extension UIColor{
    static let myColor2 = UIColor(red: 0.138, green: 0.153, blue: 0.168, alpha: 1)
    static let myCamel2 = UIColor(red: 0.650, green: 0.579, blue: 0.447, alpha: 1)
}

struct ContentView: View {

    init() {

        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.myCamel2]
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor.myColor2
        UITableView.appearance().backgroundColor = UIColor.myColor2
    }

    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false

    var body: some View {

            VStack{
                if self.status{
                    Homescreen()
                }
                else{
                    NavigationView{
                        FirstPage()
                    }
                }
            }

        .onAppear() {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false

                self.status = status
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Homescreen : View {
    
    @State var index = 0
    @State var curvePos : CGFloat = 0

//    @Binding var show: Bool
        
    var body: some View{
        
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {

                VStack{
                    if self.index == 0{
                        ZStack{
                            Color("Back")
                            Main()
                        }//.edgesIgnoringSafeArea(.all)
                    }
                        
                    else if self.index == 1{
                        Requests()
                    }
                        
                    else if self.index == 2{
                        ZStack{
                            Color("Back")
                            Payments()
                        }.edgesIgnoringSafeArea(.all)
                    }
                    else{
                        ZStack{
                            Color("Back")
//                            UserAcc(show: self.$show)
                        UserAcc()
                            .environmentObject(MainObservable())

                        }.edgesIgnoringSafeArea(.all)
                    }
                }
                TabView(index: $index)
            }).edgesIgnoringSafeArea(.bottom)
    }
}

struct FirstPage : View {
    
    @EnvironmentObject var user: User
    
    @State var ccode = ""
    @State var phone = ""
    @State var show = false
    @State var msg = ""
    @State var alert = false
    @State var ID = ""

    var body: some View{

        ZStack{
            
            ZStack(alignment: .topLeading){
            BackSplash()
            Image("Turan")
                .resizable()
                .scaledToFit()
                .frame(width:350, height: 350)
                .offset(x: 25, y:50)
            }

            
            VStack{

//                Text("Verify Your Number")
//                    .font(.custom("Times New Roman", size: 25))
//                    .foregroundColor(Color("Camel"))
                
                HStack{
//                    if ccode.isEmpty{ Text("7").foregroundColor(Color("Camel"))}
                    TextField("+7", text: $ccode)
                    .accentColor(Color("Camel"))
                    .foregroundColor(Color("Camel"))
                        .keyboardType(.numberPad)
                        .frame(width: 40, height: 20)
                        .padding()
                        .background(Color("Gray"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))

                    
                    TextField("Number", text: $phone)
                        .foregroundColor(Color("Camel"))
                        .accentColor(Color("Camel"))
                        .keyboardType(.numberPad)
                        .frame(width: 200, height: 20)
                        .padding()
                        .background(Color("Gray"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.top, 150)

                
                NavigationLink(destination: SecondPage(show: $show, ID: $ID), isActive: $show)
                {
                    Button(action: {
                        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
                        PhoneAuthProvider.provider().verifyPhoneNumber("+"+self.ccode+self.phone, uiDelegate: nil) { (ID, err) in
                            
                            if err != nil{
                                
                                self.msg = (err?.localizedDescription)!
                                self.alert.toggle()
                                return
                            }
                            
                            self.ID = ID!
                            self.show.toggle()
                        }
                    })
                    {
                        Text("Send")
                            .foregroundColor(.white)
                            .frame(width: 220, height: 60)
                    }
                    .background(Color("Camel"))
                    .cornerRadius(40)
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)

            } //end  of VStack
            .padding()
            .alert(isPresented: $alert) {
                    
                Alert(title: Text("Error"), message: Text(self.msg), dismissButton: .default(Text("Ok")))
            }

        } //end of the outer ZStack
    } //end of body:View
}


struct SecondPage : View
{
    @State var code = ""
    @Binding var show : Bool
    @Binding var ID : String
    @State var msg = ""
    @State var alert = false
    @State var creation = false
    @State var loading = false
    @State var staff = false
    @State var staffId = ""
    
    @EnvironmentObject var user: User
    
    var body: some View{
        ZStack(alignment: .topLeading) {
            BackSplash()
            .edgesIgnoringSafeArea(.all)
            
            GeometryReader{ _ in
            VStack(alignment: .center){

                
                Text("Please Enter The Verification Code")
                    .foregroundColor(Color("Camel"))
                    .font(.custom("Times New Roman", size: 20))
                
                TextField("Code", text: self.$code)
                    .frame(width: 230, height: 20)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color("Gray"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.top, 15)
                    
                
                if self.loading{
                    
                    HStack{
                        
                        Spacer()
                        
                        Indicator()
                        
                        Spacer()
                    }
                }
                    
                else{
                    
                    Button(action: {
                        
                        self.loading.toggle()
                        
                        let credential =  PhoneAuthProvider.provider().credential(withVerificationID: self.ID, verificationCode: self.code)
                        
                        Auth.auth().signIn(with: credential) { (res, err) in
                            
                            if err != nil{
                                
                                self.msg = (err?.localizedDescription)!
                                self.alert.toggle()
                                self.loading.toggle()
                                return
                            }
                            checkUser { (exists, user, uid) in
                                
                                if exists{
                                    
                                    UserDefaults.standard.set(true, forKey: "status")
                                    
                                    UserDefaults.standard.set(user, forKey: "UserName")
                                    
                                    UserDefaults.standard.set(uid, forKey: "UID")
                                                                        
                                    NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                                }
                                    
                                else{
                                    
                                    self.loading.toggle()
                                    self.creation.toggle()
                                }
                            }
                        }
                        
                    }) {
                        
                        Text("Verify").frame(width: UIScreen.main.bounds.width - 150,height: 50)
                    }.foregroundColor(Color("Camel"))
                        .background(Color("Gray"))
                        .cornerRadius(40)
                }
                
            }//end of VStack
            }//end of GR
            
            Button(action: {
                self.show.toggle()
            })
            {
                Image(systemName: "chevron.left").font(.title)
            }.foregroundColor(Color("Camel"))
            
        } //end of Zstack
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            
            .alert(isPresented: $alert) {
                
                Alert(title: Text("Error"), message: Text(self.msg), dismissButton: .default(Text("Ok")))
        }
        .sheet(isPresented: self.$creation) {

            AccountCreation(show: self.$creation)
        }
        
    }//end of View
}//end of struct


struct Pay : View {
    var body: some View {
        NavigationView {
            Text("Pay")
        }
    }
}


struct Announcement : View {
    var body: some View {
        NavigationView {
            Text("News")
        }
    }
}


struct AddressList : View {
    
    @State var color = Color.black.opacity(0.7)
    
    var residences = ["Rixos Khan Shatyr Residences", "X", "No Name", "No Name"]
    @State private var selectedResidence = 0 //selection chosen from the picker
    
    @Binding var show : Bool
    
    @EnvironmentObject var user: User
    
    var body: some View
    {
        ZStack{
//            VStack{
            
                NavigationView {
                    ZStack{
//                    BackSplash()
                    VStack{
                            Picker(selection: $selectedResidence, label: Text("Your Residence")) {
                                ForEach(0 ..< residences.count) {
                                    Text(self.residences[$0])
                        }
                    }
                    
                    TextField("Enter your address", text: self.$user.address)
                        .autocapitalization(.none)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.user.email != "" ? Color("Color") : self.color,lineWidth: 2))
                        .padding(.top, 25)
                    
                    TextField("Enter your floor", text: self.$user.floor)
                        .autocapitalization(.none)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.user.email != "" ? Color("Color") : self.color,lineWidth: 2))
                        .padding(.top, 25)
                    
                    TextField("Enter your apartment number", text: self.$user.apartment)
                        .autocapitalization(.none)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.user.email != "" ? Color("Color") : self.color,lineWidth: 2))
                        .padding(.top, 25)

                    }//end of V
                    }//end of Z
            }//end of Nav
        }//end of Z
    }//} var body
}

struct CircleImage: View{
    
    var imageName: String
    
    var body: some View
    {
            Image(imageName)
                .resizable()
                .clipShape(Circle())
            .overlay(Circle()
                .stroke(Color.gray, lineWidth: 2))
            .shadow(radius: 10)
            .frame(width: 100, height: 100)
        
    }
}


 struct TabView : View {
     
    @Binding var index: Int
     @State var curvePos : CGFloat = 0
     
     var body: some View{
             
             HStack{
                 GeometryReader{g in
                     
                     VStack{
                         
                         Button(action: {
                             
                             withAnimation(.spring()){
                                
                                
                                self.index = 0
                                self.curvePos = g.frame(in: .global).midX
                             }
                             
                         }, label: {
                             
                            Image("home").foregroundColor(Color("Back"))
                                 .frame(width: 28, height: 28)
                                 .padding(.all, 15)
                             // animating View...
                                .background(Color("Gray").opacity(self.index == 0 ? 1 : 0).clipShape(Circle()))
                                .offset(y: self.index == 0 ? -35 : 0)
                         })
                     }
                     // 28 + padding 15 = 43....
                     .frame(width: 43, height: 43)
                     .onAppear {
                         // getting initial index position...
                         DispatchQueue.main.async {

                             self.curvePos = g.frame(in: .global).midX
                         }
                     }
                 }
                 .frame(width: 43, height: 43)
                 
                 Spacer(minLength: 0)

                
                 GeometryReader{g in
                     
                     VStack{
                         
                         Button(action: {
                             
                             withAnimation(.spring()){
                                 
                                self.index = 1
                                 // assigning it whenever its button is clicked...
                                 
                                 self.curvePos = g.frame(in: .global).midX
                             }
                             
                         }, label: {
                             
                            Image(systemName: "wrench").font(Font.title.bold())
                                .foregroundColor(Color("Back"))
                                 .frame(width: 28, height: 28)
                                 .padding(.all, 15)
                                .background(Color("Gray").opacity(self.index == 1 ? 1 : 0).clipShape(Circle()))
                                .offset(y: self.index == 1 ? -35 : 0)
                         })
                     }
                     // 28 + padding 15 = 43....
                     .frame(width: 43, height: 43)
                 }
                 .frame(width: 43, height: 43)
                 
                 Spacer(minLength: 0)
                 
                 GeometryReader{g in
                     
                     VStack{
                         Button(action: {
                             
                             withAnimation(.spring()){
                                 
                                self.index = 2
                                 self.curvePos = g.frame(in: .global).midX
                             }
                             
                         }, label: {
                             
                             Image("payment").foregroundColor(Color("Back"))
                                 .frame(width: 28, height: 28)
                                 .padding(.all, 15)
                                .background(Color("Gray").opacity(self.index == 2 ? 1 : 0).clipShape(Circle()))
                                .offset(y: self.index == 2 ? -35 : 0)
                         })
                     }
                     // 28 + padding 15 = 43....
                     .frame(width: 43, height: 43)
                 }
                 .frame(width: 43, height: 43)
                 
                 Spacer(minLength: 0)
                 
                 GeometryReader{g in
                     VStack{
                         Button(action: {
                             withAnimation(.spring()){
                                 
                                self.index = 3
                                 self.curvePos = g.frame(in: .global).midX
                             }
                             
                         }, label: {
                             
                            Image(systemName: "person").font(Font.title.bold())
                                .foregroundColor(Color("Back"))
                                 .frame(width: 28, height: 28)
                                 .padding(.all, 15)
                                .background(Color("Gray").opacity(self.index == 3 ? 1 : 0).clipShape(Circle()))
                                .offset(y: self.index == 3 ? -35 : 0)
                         })
                     }
                     // 28 + padding 15 = 43....
                     .frame(width: 43, height: 43)
                 }
                 .frame(width: 43, height: 43)
             }
             .padding(.horizontal, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 25 : 35)
             .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 8 : UIApplication.shared.windows.first?.safeAreaInsets.bottom)
             .padding(.top, 8)
             .background(Color("Camel").clipShape(CShape(curvePos: curvePos)))
     }
 }






struct CShape : Shape {

    // You can also use dispatchQueue in set but its simple....
    
    var curvePos : CGFloat
    
    
    // animating Path....
    
    
    var animatableData: CGFloat{
        
        get{return curvePos}
        set{curvePos = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
     
        return Path{path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
            // adding Curve...
            
            path.move(to: CGPoint(x: curvePos + 40, y: 0))
            
            path.addQuadCurve(to: CGPoint(x: curvePos - 40, y: 0), control: CGPoint(x: curvePos, y: 70))
            // using this we can control curve length....
        }
        
    }
}


// END OF YOUR REAL PRG
//
//
//END END END
