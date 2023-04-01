//
//  View+Effect.swift
//  hoverdemo
//
//  Created by HIROKI IKEUCHI on 2023/04/01.
//

import SwiftUI
import SDWebImageSwiftUI

// MARK: - View + Effect

extension View {
    
    func sparkleEffect(isOn: Bool = true) -> some View {
        self
            .overlay() {
                if isOn {
                    Image("holo")  // Assetsを使用する場合
//                    WebImage(url: URL(string: "https://assets.codepen.io/13471/holo.png"))
                        .resizable()
                        .blendMode(.colorDodge)
                        .opacity(0.3)
                }
            }
            .overlay() {
                if isOn {
                    AnimatedImage(name: "sparkles.gif", isAnimating: .constant(true))  // Resourceの画像を使用する場合
//                    AnimatedImage(url: URL(string: "https://assets.codepen.io/13471/sparkles.gif"))
                        .resizable()
                        .blendMode(.colorDodge)
                        .opacity(0.3)
                }
            }
    }
    
    func highlightEffect(isOn: Bool = true, hoverLocationRatio: CGPoint) -> some View {
        self
            .overlay() {
                if isOn {
                    RadialGradient(gradient: Gradient(colors: [.white.opacity(0.5), .clear]),
                                   center: .init(x: hoverLocationRatio.x, y: hoverLocationRatio.y),
                                   startRadius: 0,
                                   endRadius: 200)
                }
            }
    }
    
    func rainbowHolographicEffect(isOn: Bool = true, locationXRatio: Double) -> some View {
        let gradientLocationCenter = min(max(locationXRatio, 0.21), 0.79)  // 0.21 ~ 0.79
        let gradient = Gradient(stops: [
            .init(color: .clear, location: 0),
            .init(color: Color(hex: "#ec9bb6"), location: gradientLocationCenter - 0.2),
            .init(color: Color(hex: "#ccac6f"), location: gradientLocationCenter - 0.1),
            .init(color: Color(hex: "#69e4a5"), location: gradientLocationCenter),
            .init(color: Color(hex: "#8ec5d6"), location: gradientLocationCenter + 0.1),
            .init(color: Color(hex: "#b98cce"), location: gradientLocationCenter + 0.2),
            .init(color: .clear, location: 1.0)
        ])
        
        return self
            .overlay() {
                if isOn {
                    LinearGradient(gradient: gradient,
                                   startPoint: .leading,
                                   endPoint: .trailing)
                    .padding(-60)
                    .opacity(1.0)
                    .rotationEffect(Angle(degrees: 20))
                    .blendMode(.overlay)
                }
            }
    }
    
    func gradientHolographicEffect(isOn: Bool = true, pokemon: Pokemon, locationXRatio: Double) -> some View {

        let gradientLocationCenter = min(max(locationXRatio, 0.11), 0.89)  // 0.11 ~ 0.89
        let gradient = Gradient(stops: [
            .init(color: .clear, location: 0),
            .init(color: pokemon.gradientColor1, location: gradientLocationCenter - 0.1),
            .init(color: pokemon.gradientColor2, location: gradientLocationCenter),
            .init(color: pokemon.gradientColor3, location: gradientLocationCenter + 0.1),
            .init(color: .clear, location: 1.0)
        ])
        
        return self
            .overlay() {
                if isOn {
                    LinearGradient(gradient: gradient,
                                   startPoint: .leading,
                                   endPoint: .trailing)
                    .padding(-60)  // カード全体を覆えるように大きめのマージンをとる
                    .opacity(1.0)
                    .rotationEffect(Angle(degrees: 20))
                    .blendMode(.overlay)
                }
            }
    }
    
    func cardRorationEffect(locationRatioX: Double,
                            locationRatioY: Double,
                            maxRotarionXDegree: Double = 10,
                            maxRotarionYDegree: Double = 10) -> some View {
        let lotationDegrees = CGPoint(x: -maxRotarionXDegree * ((locationRatioX - 0.5) / 0.5),
                                      y: maxRotarionYDegree  * ((locationRatioY - 0.5) / 0.5))

        /* rotation3DEffectを1つにまとめる方法ある…？ */
        return self
            .rotation3DEffect(Angle(degrees: lotationDegrees.x),
                              axis: (x: 0, y: 1.0, z: 0),
                              anchorZ: 0,
                              perspective: 1.0)
            .rotation3DEffect(Angle(degrees: lotationDegrees.y),
                              axis: (x: 1.0, y: 0, z: 0),
                              anchorZ: 0,
                              perspective: 1.0)
    }
}

