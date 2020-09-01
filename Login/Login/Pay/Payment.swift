//
//  Payment.swift
//  Login
//
//  Created by Madina Sadirmekova on 6/19/20.
//  Copyright © 2020 Madina Sadirmekova. All rights reserved.
//

import SwiftUI

struct Payments: View {
    
    @State var selected = 0
    
    var body: some View {

        VStack(spacing: 8)
        {
            TopBar(selected: self.$selected).padding(.top)
            
            if self.selected == 0
            {
                Payings()
            }
            else
            {
                History()
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct TopBar : View{
    
    @Binding var selected: Int
    
    var body: some View{
        
        HStack{
            Button(action: {
                 self.selected = 0
            })
            {
                Text("Payment")
                    .frame(width: 100, height: 25)
                    .padding(.vertical,12)
                    .padding(.horizontal,30)
                    .background(self.selected == 0 ? Color("Camel") : Color.clear)
                    
                .clipShape(Capsule())
                
            }.foregroundColor(self.selected == 0 ? .white : .gray)

            
            Button(action: {
                 self.selected = 1
            })
            {
                Text("History")
                    .frame(width: 100, height: 25)
                    .padding(.vertical,12)
                    .padding(.horizontal,30)
                    .background(self.selected == 1 ? Color("Camel") : Color.clear)
                    .clipShape(Capsule())
            }
            .foregroundColor(self.selected == 1 ? .white : .gray)

        }.padding(8)
        .background(Color("Gray"))
        .clipShape(Capsule())
        .animation(.default)
    }
}
