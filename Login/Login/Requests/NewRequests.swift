//
//  NewRequests.swift
//  Login
//
//  Created by Madina Sadirmekova on 7/15/20.
//  Copyright © 2020 Madina Sadirmekova. All rights reserved.
//

import SwiftUI
import Foundation
import UIKit

struct NewRequests: View {
    
    //    @State var nodoList: [NoDo] = []
    
    @State var nodoList: [NoDo] = {
        guard var data = UserDefaults.standard.data(forKey: "nodos") else {
            return []
        }
        if let json = try? JSONDecoder().decode([NoDo].self, from: data) {
            return json
        }
        return []
    }()
    
    @State var showField: Bool = false
    @State var nodoItem = NoDo()
    
    var body: some View {
        
        VStack{
            HStack(spacing: 5) {
                TopView(nodoItem: self.$nodoItem, showField: self.$showField, nodoList: self.$nodoList)
            }
            
            List {
                ForEach(self.nodoList) { item in
                    
                    NoDoRow(noDoItem: item)
                    //Text(item.name)
                }.onDelete(perform: deleteItem)
            }
        }
    }
    
    func deleteItem(at offsets: IndexSet)  {
        guard let index = Array(offsets).first
            else {return}
        
        print("Removed \(self.nodoList[index])")
        
        self.nodoList.remove(at: index)
        
        save()// That's it!  this will remove the item from the UserDefaults
    }
    
    func save() {
        guard let data = try? JSONEncoder().encode(self.nodoList) else { return }
        UserDefaults.standard.set(data, forKey: "nodos")
    }
}

