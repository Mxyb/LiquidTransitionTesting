//
//  Home.swift
//  LiquidTransitionTesting
//
//  Created by Max Baker on 21/03/2022.
//

import SwiftUI
import Lottie

struct Home: View {
    // MARK: Animation Properties
    @State var expandCard: Bool = false
    @State var bottomLiquidView: AnimationView = AnimationView(name: "LiquidWave", bundle: .main)
    @State var topLiquidView: AnimationView = AnimationView(name: "LiquidWave", bundle: .main)
    
    // Avoiding Multitapping
    @State var isfinished: Bool = false
    
    var body: some View {
        
        NavigationView {
        
        ScrollView {
        
        VStack(spacing: 200){
           
            
            // MARK: Animated Liquid Transition Cards
            LiquidCard(title: "What is Hello in French?", subTitle: "", detail: "Hello in French is...", description: "Bonjour"){
                if isfinished{return}
                isfinished = true
                // Animating Lottie View with little Delay
                DispatchQueue.main.asyncAfter(deadline: .now() + (expandCard ? 0 : 0.2)) {
                    // So that it will finish soon...
                    // You can play with your custom options here
                    bottomLiquidView.play(fromProgress: expandCard ? 0 : 0.45, toProgress: expandCard ? 0.6 : 0)
                    topLiquidView.play(fromProgress: expandCard ? 0 : 0.45, toProgress: expandCard ? 0.6 : 0){status in
                        isfinished = false
                    }
                }
                // Toggle Card
                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)){
                    expandCard.toggle()
                }
            }
            .frame(maxHeight: .infinity)
            
            //SECOND CARD
            LiquidCard(title: "What is 2 + 2?", subTitle: "", detail: "2 + 2 is...", description: "4"){
                if isfinished{return}
                isfinished = true
                // Animating Lottie View with little Delay
                DispatchQueue.main.asyncAfter(deadline: .now() + (expandCard ? 0 : 0.2)) {
                    // So that it will finish soon...
                    // You can play with your custom options here
                    bottomLiquidView.play(fromProgress: expandCard ? 0 : 0.45, toProgress: expandCard ? 0.6 : 0)
                    topLiquidView.play(fromProgress: expandCard ? 0 : 0.45, toProgress: expandCard ? 0.6 : 0){status in
                        isfinished = false
                    }
                }
                // Toggle Card
                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)){
                    expandCard.toggle()
                }
            }
            .frame(maxHeight: .infinity)
            
            
        }
        .padding()
        .frame(maxHeight: .infinity,alignment: .top)
        }
        }
    }
    
    @ViewBuilder
    func LiquidCard(title: String,subTitle: String,detail: String,description: String,color: SwiftUI.Color = Color("Blue"),onExpand: @escaping ()->())->some View{
        ZStack{
            VStack(spacing: 20){
                Text(title)
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                HStack(spacing: 10){
                    //Image(systemName: "speaker.wave.3")
                       // .foregroundColor(.gray)
                    
                    Text(subTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: expandCard ? 250 : 350)
            .background{
                GeometryReader{proxy in
                    let size = proxy.size
                    let scale = size.width / 1000
                    
                    RoundedRectangle(cornerRadius: 35, style: .continuous)
                        .fill(color)
                    
                    // To get Custom Color simply use Mask Technique
                    RoundedRectangle(cornerRadius: 35, style: .continuous)
                        .fill(color)
                        .mask {
                            ResizableLottieView(lottieView: $bottomLiquidView)
                            // Scaling it to current Size
                                .scaleEffect(x: scale, y: scale, anchor: .leading)
                        }
                        .rotationEffect(.init(degrees: 180))
                        .offset(y: expandCard ? size.height / 1.43 : 0)
                }
            }
            // MARK: Expand Button
            .overlay(alignment: .bottom) {
                Button {
                    onExpand()
                } label: {
                 
                    Image(systemName: "chevron.down")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 30.0, height: 30.0)
                        .font(.title3.bold())
                        .foregroundColor(color)
                        .padding(30)
                        .background(.white,in: RoundedRectangle(cornerRadius: 20, style: .continuous))
                    // Shadows
                        .shadow(color: .black.opacity(0.15), radius: 5, x: 5, y: 5)
                        .shadow(color: .black.opacity(0.15), radius: 5, x: -5, y: -5)
                }
                .padding(.bottom,-25)
            }
            .zIndex(1)
            
            // MARK: Expanded Card
            VStack(spacing: 20){
                Text(detail)
                    .font(.largeTitle.bold())
                
                Text(description)
                    .font(.title3)
                    .lineLimit(3)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
            }
            .foregroundColor(.white)
            .padding(.vertical,40)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .background{
                GeometryReader{proxy in
                    let size = proxy.size
                    let scale = size.width / 1000
                    RoundedRectangle(cornerRadius: 35, style: .continuous)
                        .fill(color)
                    
                    // To get Custom Color simply use Mask Technique
                    RoundedRectangle(cornerRadius: 35, style: .continuous)
                        .fill(color)
                        .mask {
                            ResizableLottieView(lottieView: $topLiquidView)
                            // Scaling it to current Size
                                .scaleEffect(x: scale, y: scale, anchor: .leading)
                        }
                        .offset(y: expandCard ? -size.height / 1.2 : -size.height / 1.4)
                }
            }
            .zIndex(0)
            .offset(y: expandCard ? 280 : 0)
        }
        .offset(y: expandCard ? -120 : 0)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
