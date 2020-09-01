//
//  ToDoRow.swift
//  Login
//
//  Created by Madina Sadirmekova on 6/22/20.
//  Copyright © 2020 Madina Sadirmekova. All rights reserved.
//

import SwiftUI

struct NoDoRow: View {
    @State var noDoItem: NoDo
    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            Group {
                HStack {
                    Text(self.noDoItem.name)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    
                    Spacer()
                    
                    Image(systemName: self.noDoItem.isDone ? "checkmark" :
                    "square")
                        .padding()
                }
                HStack(alignment: .center, spacing: 3) {
                     Spacer()
                    
                    Text("Added: \(self.noDoItem.dateText)")
                        .foregroundColor(.white)
                        .italic()
                        .padding(.all, 5)
                }.padding(.bottom, 5)
            }.padding(.all, 4)
            
        }.blur(radius: self.noDoItem.isDone ? 1 : 0)
//        .listRowBackground(Color("Back"))

       
            
        .opacity(self.noDoItem.isDone ? 0.7 : 1)
        .background(self.noDoItem.isDone ? Color.gray : Color("Camel"))
        .clipShape(RoundedRectangle(cornerRadius: 5))
            .onTapGesture{
                self.noDoItem.isDone.toggle()
        }
        .animation(.spring())
        .offset(x: self.noDoItem.isDone ? -34: 0)
    }
}

#if DEBUG
struct NoDoRow_Previews: PreviewProvider {
    static var previews: some View {
        NoDoRow(noDoItem: NoDo( name: "one", isDone: false))
    }
}
#endif
