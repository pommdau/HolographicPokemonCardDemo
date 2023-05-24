//
//  SampleCardView.swift
//  HolographicPokemonCardDemo
//
//  Created by HIROKI IKEUCHI on 2023/05/24.
//

import SwiftUI



struct SampleCardView: View {
    
    private static let cardCornerRadius: CGFloat = 20
    private static let cardSize: CGSize = .init(width: 367, height: 512)
    
    @State private var isHovering = false
    @State private var hoverLocationRatio: CGPoint = .init(x: 0.5, y: 0.5)
    
    private var rotationDegrees: CGPoint {
        let maxRotationDegree: Double = 10
        return  CGPoint(x: -maxRotationDegree * ((hoverLocationRatio.x - 0.5) / 0.5),
                        y: maxRotationDegree  * ((hoverLocationRatio.y - 0.5) / 0.5))
    }
        
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Self.cardCornerRadius)
                .fill(.gray)
            RoundedRectangle(cornerRadius: Self.cardCornerRadius)
                .stroke(.white, lineWidth: 1)
        }
        .frame(width: Self.cardSize.width, height: Self.cardSize.height)
        .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 20)
        
        .brightness(isHovering ? 0.05 : 0)
        .contrast(isHovering ? 1.3 : 1.0)
        .onContinuousHover(coordinateSpace: .local) { phase in
            switch phase {
            case .active(let location):
                hoverLocationRatio = .init(x: location.x / Self.cardSize.width,
                                           y: location.y / Self.cardSize.height)
                print(hoverLocationRatio)
                isHovering = true
            case .ended:
                withAnimation {
                    isHovering = false
                    hoverLocationRatio = .init(x: 0.5, y: 0.5)
                }
            }
        }
        .rotation3DEffect(Angle(degrees: rotationDegrees.x),
                          axis: (x: 0, y: 1.0, z: 0),
                          anchorZ: 0,
                          perspective: 1.0)
        .rotation3DEffect(Angle(degrees: rotationDegrees.y),
                          axis: (x: 1.0, y: 0, z: 0),
                          anchorZ: 0,
                          perspective: 1.0)
        
        .padding(50)
    }
}

struct SampleCardView_Previews: PreviewProvider {
    static var previews: some View {
        SampleCardView()
    }
}
