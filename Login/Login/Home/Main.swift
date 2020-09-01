//
//  Main.swift
//  Login
//
//  Created by Madina Sadirmekova on 6/19/20.
//  Copyright © 2020 Madina Sadirmekova. All rights reserved.
//


import SwiftUI

struct Main: View {
    
    let colors: [Color] = [Color("A"), Color("B"), Color("C"), Color("D")]
    @State private var action: Int? = 0
    @State var reception = false
    @State var atHome = false
    @State var smartHome = false
    @State var suggestions = false
    
    @EnvironmentObject var categories: getScrollItem
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("Back").edgesIgnoringSafeArea(.all)
                VStack{
                    
                    HStack{
                        Image("Horse2")
                            .resizable()
                            .frame(width: 70, height: 60)
                            .offset(x: -100)
                        Text("TuranClients")
                            .foregroundColor(Color("Camel"))
                            .font(.custom("Didot", size: 21))
                            .offset(x: -108, y: 3)
                    }.padding(.top, 30)
                    
                    
                    if self.categories.datas.count != 0 {
                        ScrollView(.horizontal, showsIndicators: false)
                        {
                            HStack(spacing: 15)
                            {
                                ForEach(self.categories.datas){i in
                                    ScrollContentsHor(data: i)
                                }
                            }
                        }
                    }
                    
                    
                    ScrollView(.vertical, showsIndicators: false){
                        VStack{
                            NavigationLink(destination: Reception()
                            .environmentObject(MainObservable())){
                                Text("Reception")
                                    .font(.custom("Didot", size: 18))
                                    .frame(width: 300, height: 60)
                                    .foregroundColor(Color("Back"))
                            }
                            .background(Color("A"))
                            }.cornerRadius(25)

                        Spacer()
                        
                        VStack{
                            NavigationLink(destination: AtHome()){
                                Text("At Home")
                                    .font(.custom("Didot", size: 18))
                                    .frame(width: 300, height: 60)
                                    .foregroundColor(Color("Back"))
                            }.navigationBarTitle(Text("At Home"), displayMode: .inline)
                                .background(Color("B"))
                        }.cornerRadius(25)
                            
                        Spacer()

                        VStack{
                            NavigationLink(destination: SmartHome()){
                                Text("Smart Home")
                                    .font(.custom("Didot", size: 18))
                                    .frame(width: 300, height: 60)
                                    .foregroundColor(Color("Back"))
                            }
                            .background(Color("C"))
                        }.cornerRadius(25)
                          
                        Spacer()

                        VStack{
                            NavigationLink(destination: Suggestions()){
                                Text("Suggestions")
                                    .font(.custom("Didot", size: 18))
                                    .frame(width: 300, height: 60)
                                    .foregroundColor(Color("Back"))
                            }
                            .background(Color("D"))
                        }.cornerRadius(25)
                            
                    }//scroll
                    
                    
                }//endVSTACK//.environmentObject(categories)
            }
        }
        
    }
}
