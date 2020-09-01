//
//  ScrollContentsHor.swift
//  Login
//
//  Created by Madina Sadirmekova on 7/17/20.
//  Copyright © 2020 Madina Sadirmekova. All rights reserved.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI


struct ScrollContentsHor : View{
    
    var data: ScrollItem
//    @State var imageURL = ""
    
    var body: some View{
        
        VStack{
            //Place for image
            AnimatedImage(url: URL(string: data.pic)!)
                .resizable()
                .frame(width: 350, height: 270)
                .cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color("Gray"), lineWidth: 5))
            
        }
    }
}

