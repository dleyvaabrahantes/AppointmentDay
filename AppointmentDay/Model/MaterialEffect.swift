//
//  MaterialEffect.swift
//  elToque
//
//  Created by David on 9/15/22.
//

import Foundation
import SwiftUI


struct MaterialEffect: UIViewRepresentable  {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        
        return view
        
    }
    
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}
