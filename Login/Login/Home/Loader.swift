//
//  Loader.swift
//  Login
//
//  Created by Madina Sadirmekova on 7/14/20.
//  Copyright © 2020 Madina Sadirmekova. All rights reserved.
//

import SwiftUI

struct Loader : UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<Loader>) -> UIActivityIndicatorView {
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
        
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Loader>) {
        
        
    }
}
