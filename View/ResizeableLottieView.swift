//
//  ResizeableLottieView.swift
//  LiquidTransitionTesting
//
//  Created by Max Baker on 21/03/2022.
//

import SwiftUI
import Lottie

// Resizable Lottie View
// Which will adopt Animation for the given Size
struct ResizableLottieView: UIViewRepresentable {

    @Binding var lottieView: AnimationView
    
    func makeUIView(context: Context) -> UIView {
        
        let view = UIView()
        view.backgroundColor = .clear
        addLottieView(to: view)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    func addLottieView(to rootView: UIView){
        lottieView.backgroundColor = .clear
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        // Intially setting to Finished View
        lottieView.currentProgress = 1
        
        let constraints = [
        
            lottieView.widthAnchor.constraint(equalTo: rootView.widthAnchor),
            lottieView.heightAnchor.constraint(equalTo: rootView.heightAnchor),
        ]
        
        rootView.addSubview(lottieView)
        rootView.addConstraints(constraints)
    }
}
