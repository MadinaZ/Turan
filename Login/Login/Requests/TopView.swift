//
//  TopView.swift
//  Login
//
//  Created by Madina Sadirmekova on 6/22/20.
//  Copyright © 2020 Madina Sadirmekova. All rights reserved.
//

import SwiftUI

struct TopView: View {
    @Binding var nodoItem: NoDo
    @State var placeHolder = "Add Something"
    @Binding var showField: Bool
    @Binding var nodoList: [NoDo]
    
    var body: some View {
        
        ZStack {
            ZStack(alignment: .leading) {
                
                TextField(self.placeHolder, text: self.$nodoItem.name, onCommit: {
                    self.nodoList.insert(NoDo( name: self.nodoItem.name, isDone: false), at: 0)
                    self.nodoItem.name = ""
                    
                    self.save()
                }).padding(.all, 10)
                    .frame(width: UIScreen.main.bounds.width - 50, height: 50)
                    .background(Color("Camel"))
                    .cornerRadius(30)
                    .foregroundColor(.white)
                    .offset(x: self.showField ?
                        0 : (-UIScreen.main.bounds.width / 2 - 180))
                    .animation(.spring())
                
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color("Gray"))
                    .offset(x: self.showField ? (UIScreen.main.bounds.width - 90) : -30)
                    .animation(.spring())
                    .onTapGesture{
                        self.showField.toggle()
                }
                
            }.padding(.bottom, 20)
                .padding(.leading, 3)
        }
    }
    
    func save() {
        guard let data = try? JSONEncoder().encode(self.nodoList)
            else {return}
        UserDefaults.standard.set(data, forKey: "nodos")
    }
}

//#if DEBUG
//struct TopView_Previews: PreviewProvider {
//    static var previews: some View {
//        TopView()
//    }
//}
//#endif
