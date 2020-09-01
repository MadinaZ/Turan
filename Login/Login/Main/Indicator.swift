//
//  Indicator.swift
//  Login
//
//  Created by Madina Sadirmekova on 7/26/20.
//  Copyright © 2020 Madina Sadirmekova. All rights reserved.


import SwiftUI
struct Indicator : UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<Indicator>) -> UIActivityIndicatorView {
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Indicator>) {
        
        
    }
}

