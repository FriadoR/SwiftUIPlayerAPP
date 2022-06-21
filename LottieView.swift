//
//  LottieView.swift
//  MusicLottieAPP
//
//  Created by Сергей Саченко on 21.06.2022.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    
    let loopMode: LottieLoopMode = .loop
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        
        let animationView = AnimationView()
        
        view.addSubview(animationView)
        let animation = Animation.named("24907-party-parrot")
        animationView.animation = animation
        animationView.loopMode = loopMode
        animationView.play()
        animationView.contentMode = .scaleAspectFit
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    
}

struct LottieView_Previews: PreviewProvider {
    static var previews: some View {
        LottieView()
    }
}
