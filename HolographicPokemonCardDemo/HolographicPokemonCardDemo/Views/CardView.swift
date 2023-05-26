//
//  CardView.swift
//  hoverdemo
//
//  Created by HIROKI IKEUCHI on 2023/03/31.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardView: View {
    
    let pokemon: Pokemon
    @StateObject private var viewModel = CardViewModel()
    @ObservedObject var effectSettings: EffectSettings
        
    var body: some View {
        
        cardImage()
            .aspectRatio(CardViewModel.imageAspectRatio, contentMode: .fit)

            // hover時に常に有効にする効果
            .brightness(viewModel.isHovering ? 0.05 : 0)
            .contrast(viewModel.isHovering ? 1.3 : 1.0)
        
            .sparkleEffect(isOn: effectSettings.enableSparkleEffect)
            .highlightEffect(isOn: effectSettings.enableHighlightEffect && viewModel.isHovering,
                             hoverLocationRatio: viewModel.hoverLocationRatio)
            .gradientHolographicEffect(isOn: effectSettings.enableGradientHolographicEffect,
                                       pokemon: pokemon,
                                       locationRatioX: viewModel.hoverLocationRatio.x)
            .rainbowHolographicEffect(isOn: effectSettings.enableRainbowHolographicEffect,
                                      locationRatioX: viewModel.hoverLocationRatio.x)
            .clipShape(
                RoundedRectangle(cornerRadius: 20)
            )
        
            .onContinuousHover(coordinateSpace: .local) { phase in
                viewModel.handleOnContinuousHover(phase: phase)
            }
            .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 20)
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear() {
                            viewModel.actualSize = proxy.size
                        }
                }
            )
            .cardRotationEffect(locationRatioX: viewModel.hoverLocationRatio.x,
                                locationRatioY: viewModel.hoverLocationRatio.y)
    }
    
    @ViewBuilder
    private func cardImage() -> some View {
        if effectSettings.showImage {
            pokemon.image  // Assetsの画像を使用する場合
//            WebImage(url: pokemon.imageURL)
                .resizable()
                .scaledToFit()
        } else {
            RoundedRectangle(cornerRadius: 20)
                .fillAndStroke(.gray, strokeBorder: .white)
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(pokemon: .eevee, effectSettings: EffectSettings())
    }
}
