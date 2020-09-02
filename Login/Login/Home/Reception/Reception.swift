//  Reception.swift
//  Login
//
//  Created by Madina Sadirmekova on 7/18/20.
//  Copyright © 2020 Madina Sadirmekova. All rights reserved.
//

import SwiftUI
import Firebase

struct Reception : View {
    
    @State var myuid = UserDefaults.standard.value(forKey: "UserName") as! String
    @EnvironmentObject var datas : MainObservable
    @State var show = false
    @State var chat = false
    @State var uid = ""
    @State var name = ""
    @State var residences = ["Rixos Khan Shatyr Residences", "Orion", "No Name", "No Name"]
    
    
    var body : some View{
//        Text("Reception")
//        if selectedResidence ==
        NavigationView{
        ZStack{
            NavigationLink(destination: ChatView(name: self.name, uid: self.uid, chat: self.$chat), isActive: self.$chat) {

                Text("")
            }
            BackSplash()

            VStack{

                if self.datas.recents.count == 0{

                    if self.datas.norecetns{

                        Text("No Chat History")
                    }
                    else{
                        Indicator()
                    }

                }
                else{

                    ScrollView(.vertical, showsIndicators: false) {

                        VStack(spacing: 12){

                            ForEach(datas.recents.sorted(by: {$0.stamp > $1.stamp})){i in

                                Button(action: {

                                    self.uid = i.id
                                    self.name = i.name
                                    self.chat.toggle()

                                }) {
                                    RecentCellView(name: i.name, time: i.time, date: i.date, lastmsg: i.lastmsg)
                                }

                            }

                        }.padding()

                    }
                }
            }.navigationBarTitle("Home",displayMode: .inline)
              .navigationBarItems(trailing:

                  Button(action: {

                    self.show.toggle()

                  }, label: {
                      Image(systemName: "square.and.pencil").resizable().frame(width: 25, height: 25)
                  }
              )

            )
        }
    }
        .sheet(isPresented: self.$show) {

            newChatView(name: self.$name, uid: self.$uid, show: self.$show, chat: self.$chat)
        }
    }
}

struct RecentCellView : View {
    
//    var url : String
    var name : String
    var time : String
    var date : String
    var lastmsg : String
    
    var body : some View{
        
        HStack{
            
//            AnimatedImage(url: URL(string: url)!).resizable().renderingMode(.original).frame(width: 55, height: 55).clipShape(Circle())
            
            VStack{
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text(name).foregroundColor(.black)
                        Text(lastmsg).foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                         Text(date).foregroundColor(.gray)
                         Text(time).foregroundColor(.gray)
                    }
                }
                
                Divider()
            }
        }
    }
}

struct newChatView : View {

    @ObservedObject var datas = getAllUsers()
    @Binding var name : String
    @Binding var uid : String
    @Binding var show : Bool
    @Binding var chat : Bool


    var body : some View{

        VStack(alignment: .leading){

                if self.datas.users.count == 0{

                    if self.datas.empty{

                        Text("No Users Found")
                    }
                    else{

                        Indicator()
                    }

                }
                else{

                    Text("Select To Chat").font(.title).foregroundColor(Color.black.opacity(0.5))

                    ScrollView(.vertical, showsIndicators: false) {

                        VStack(spacing: 12){

                            ForEach(datas.users){i in

                                Button(action: {

                                    self.uid = i.id
                                    self.name = i.name
                                    self.show.toggle()
                                    self.chat.toggle()

                                }) {

                                    UserCellView(name: i.name)
                                }


                            }

                        }

                    }
              }
        }.padding()
    }
}

class getAllUsers : ObservableObject{
    
    @Published var users = [UserS]()
    @Published var empty = false
    
    init() {
        
        let db = Firestore.firestore()
        
        
        db.collection("users").getDocuments { (snap, err) in

            if err != nil{
                
                print((err?.localizedDescription)!)
                self.empty = true
                return
            }
            
            if (snap?.documents.isEmpty)!{
                
                self.empty = true
                return
            }
            
            for i in snap!.documents{
                
                let id = i.documentID
                let name = i.get("name") as! String
                let email = i.get("email") as! String
                let address = i.get("address") as? String ?? ""
                let apartment = i.get("apartment") as? String ?? ""
                let floor = i.get("floor") as? String ?? ""
                let residence = i.get("residence") as? String ?? ""
                if id != UserDefaults.standard.value(forKey: "UID") as! String{
                    
                    self.users.append(UserS(id: id, name: name, email: email, address: address, apartment: apartment, floor: floor, residence: residence))

                }
                
            }
            
            if self.users.isEmpty{
                
                self.empty = true
            }
        }
    }
}

struct UserS : Identifiable {
    
    var id : String
    var name : String
    var email: String
    var address: String
    var apartment: String
    var floor: String
    var residence: String
}

struct UserCellView : View {
    
    var name : String
    
    var body : some View{
        
        HStack{
            
//            AnimatedImage(url: URL(string: url)!).resizable().renderingMode(.original).frame(width: 55, height: 55).clipShape(Circle())
            
            VStack{
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Text(name).foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                }
                
                Divider()
            }
        }
    }
}

struct ChatView : View {
    
    var name : String
//    var pic : String
    var uid : String
    @Binding var chat : Bool
    @State var msgs = [Msg]()
    @State var txt = ""
    @State var nomsgs = false
    
    var body : some View{
        
        VStack{
            
            
            if msgs.count == 0{
                
                if self.nomsgs{
                    
                    Text("Start New Conversation").foregroundColor(Color.black.opacity(0.5)).padding(.top)
                    
                    Spacer()
                }
                else{
                    
                    Spacer()
                    Indicator()
                    Spacer()
                }

                
            }
            else{
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 8){
                        
                        ForEach(self.msgs){i in
                            
                            
                            HStack{
                                
                                if i.user == UserDefaults.standard.value(forKey: "UID") as! String{
                                    
                                    Spacer()
                                    
                                    Text(i.msg)
                                        .padding()
                                        .background(Color.blue)
                                        .clipShape(ChatBubble(mymsg: true))
                                        .foregroundColor(.white)
                                }
                                else{
                                    
                                    Text(i.msg).padding().background(Color.green).clipShape(ChatBubble(mymsg: false)).foregroundColor(.white)
                                    
                                    Spacer()
                                }
                            }

                        }
                    }
                }
            }
            
            HStack{
                
                TextField("Enter Message", text: self.$txt).textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    
                    sendMsg(user: self.name, uid: self.uid, date: Date(), msg: self.txt)
                    
                    self.txt = ""
                    
                }) {
                    
                    Text("Send")
                }
            }
            
                .navigationBarTitle("\(name)",displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action: {
                    
                    self.chat.toggle()
                    
                }, label: {
                
                    Image(systemName: "arrow.left").resizable().frame(width: 20, height: 15)
                    
                }))
            
        }.padding()
        .onAppear {
        
            self.getMsgs()
                
        }
    }
    
    func getMsgs(){
        
        let db = Firestore.firestore()
        
        let uid = Auth.auth().currentUser?.uid
        
        db.collection("msgs").document(uid!).collection(self.uid).order(by: "date", descending: false).addSnapshotListener { (snap, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                self.nomsgs = true
                return
            }
            
            if snap!.isEmpty{
                
                self.nomsgs = true
            }
            
            for i in snap!.documentChanges{
                
                if i.type == .added{
                    
                    
                    let id = i.document.documentID
                    let msg = i.document.get("msg") as! String
                    let user = i.document.get("user") as! String
                    
                    self.msgs.append(Msg(id: id, msg: msg, user: user))
                }

            }
        }
    }
}

struct Msg : Identifiable {
    
    var id : String
    var msg : String
    var user : String
}

struct ChatBubble : Shape {
    
    var mymsg : Bool
    
    func path(in rect: CGRect) -> Path {
            
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight,mymsg ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 16, height: 16))
        
        return Path(path.cgPath)
    }
}

func sendMsg(user: String,uid: String, date: Date,msg: String){
    
    let db = Firestore.firestore()
    
    let myuid = Auth.auth().currentUser?.uid
    
    db.collection("users").document(uid).collection("recents").document(myuid!).getDocument { (snap, err) in
        
        if err != nil{
            
            print((err?.localizedDescription)!)
            // if there is no recents records....
            
            setRecents(user: user, uid: uid, msg: msg, date: date)
            return
        }
        
        if !snap!.exists{
            
            setRecents(user: user, uid: uid, msg: msg, date: date)
        }
        else{
            
            updateRecents(uid: uid, lastmsg: msg, date: date)
        }
    }
    
    updateDB(uid: uid, msg: msg, date: date)
}

func setRecents(user: String,uid: String, msg: String,date: Date){
    
    let db = Firestore.firestore()
    
    let myuid = Auth.auth().currentUser?.uid
    
    let myname = UserDefaults.standard.value(forKey: "UserName") as! String
    
//    let mypic = UserDefaults.standard.value(forKey: "pic") as! String
    
    db.collection("users").document(uid).collection("recents").document(myuid!).setData(["name":myname,"lastmsg":msg,"date":date]) { (err) in
        
        if err != nil{
            
            print((err?.localizedDescription)!)
            return
        }
    }
    
    db.collection("users").document(myuid!).collection("recents").document(uid).setData(["name":user, "lastmsg":msg,"date":date]) { (err) in
        
        if err != nil{
            
            print((err?.localizedDescription)!)
            return
        }
    }
}

func updateRecents(uid: String,lastmsg: String,date: Date){
    
    let db = Firestore.firestore()
    
    let myuid = Auth.auth().currentUser?.uid
    
    db.collection("users").document(uid).collection("recents").document(myuid!).updateData(["lastmsg":lastmsg,"date":date])
    
     db.collection("users").document(myuid!).collection("recents").document(uid).updateData(["lastmsg":lastmsg,"date":date])
}

func updateDB(uid: String,msg: String,date: Date){
    
    let db = Firestore.firestore()
    
    let myuid = Auth.auth().currentUser?.uid
    
    db.collection("msgs").document(uid).collection(myuid!).document().setData(["msg":msg,"user":myuid!,"date":date]) { (err) in
        
        if err != nil{
            
            print((err?.localizedDescription)!)
            return
        }
    }
    
    db.collection("msgs").document(myuid!).collection(uid).document().setData(["msg":msg,"user":myuid!,"date":date]) { (err) in
        
        if err != nil{
            
            print((err?.localizedDescription)!)
            return
        }
    }
}
