//
//  Requests.swift
//  Login
//
//  Created by Madina Sadirmekova on 6/5/20.
//  Copyright © 2020 Madina Sadirmekova. All rights reserved.
//

import SwiftUI
import Foundation
import UIKit

extension UIColor{
    static let myColor = UIColor(red: 0.138, green: 0.153, blue: 0.168, alpha: 1)
    static let myCamel = UIColor(red: 0.650, green: 0.579, blue: 0.447, alpha: 1)
}
struct Requests: View {
    @State var select = 0

    init() {

        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.myCamel]
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = UIColor.myColor
        UITableView.appearance().backgroundColor = UIColor.myColor
    }
    
    var body: some View {
        
        NavigationView {
            
            ZStack{
                BackSplash()
                VStack {
                    
                    VStack(spacing: 8){
                        TopBarRequests(select: self.$select).padding(.top)
                        
                        if self.select == 0
                        {
                            NewRequests()
                        }
                        else
                        {
                            FinishedRequests()
                        }
                    }
                    
                }.navigationBarTitle(Text("Requests"))

            }//end of ZStack
        }
        
    }
    
}


struct TopBarRequests : View{
    
    @Binding var select: Int
    
    var body: some View{
        
        HStack{
            Button(action: {
                 self.select = 0
            })
            {
                Text("My Requests")
                    .frame(width: 120, height: 15)
                    .padding(.vertical,12)
                    .padding(.horizontal,30)
                    .background(self.select == 0 ? Color("Camel") : Color.clear)
                    
                .clipShape(Capsule())
                
            }.foregroundColor(self.select == 0 ? .white : .gray)

            
            Button(action: {
                 self.select = 1
            })
            {
                Text("History")
                    .frame(width: 120, height: 20)
                    .padding(.vertical,12)
                    .padding(.horizontal,30)
                    .background(self.select == 1 ? Color("Camel") : Color.clear)
                    .clipShape(Capsule())
            }
            .foregroundColor(self.select == 1 ? .white : .gray)

        }.padding(8)
        .background(Color("Gray"))
        .clipShape(Capsule())
        .animation(.default)
    }
}


//#if DEBUG
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        Requests()
//    }
//}
//#endif
