//
//  BackSplash.swift
//  Login
//
//  Created by Madina Sadirmekova on 6/22/20.
//  Copyright © 2020 Madina Sadirmekova. All rights reserved.
//

import SwiftUI

struct BackSplash: View {
    var body: some View {
        //23282C
        Rectangle()
            .fill(LinearGradient(gradient: Gradient(colors: [Color("Back"), Color("Back")]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
}

