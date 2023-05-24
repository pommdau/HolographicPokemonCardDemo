//
//  CardPlaygroundView.swift
//  hoverdemo
//
//  Created by HIROKI IKEUCHI on 2023/04/01.
//

import SwiftUI

struct CardPlaygroundView: View {
    
    @StateObject private var effectSettings = EffectSettings()
    @State private var selectedPokemonIndex = 0
    private let pokemons = Pokemon.sampleData
    
    var body: some View {
        HStack(alignment: .top, spacing: 100) {
            CardView(pokemon: pokemons[selectedPokemonIndex], effectSettings: effectSettings)
                .frame(width: 300)
                .padding(.leading, 80)
            settingsSection()
        }
        .padding()
    }
}

// MARK: - View Parts

private extension CardPlaygroundView {
    
    @ViewBuilder
    func settingsSection() -> some View {
        Grid(verticalSpacing: 8) {
            GridRow {
                Text("Card:")
                    .gridColumnAlignment(.trailing)
                Picker("", selection: $selectedPokemonIndex) {
                    ForEach(Array(pokemons.enumerated()), id: \.element.id) { index, pokemon in
                        Text(pokemon.imageURL.deletingPathExtension().lastPathComponent).tag(index)
                    }
                }
                .gridColumnAlignment(.leading)
            }
            .padding(.bottom, 12)
            
            GridRow(alignment: .top) {
                Text("Effect:")
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        checkAllButtons()
                        .padding(.bottom, 8)
                        effectSettingsToggleButtons()
                    }
                }
                .padding(.leading, 8)
            }
        }
    }
    
    @ViewBuilder
    func checkAllButtons() -> some View {
        HStack {
            Button("Check All") {
                effectSettings.updateAll(enable: true)
            }
            Button("Uncheck All") {
                effectSettings.updateAll(enable: false)
            }
        }
    }
    
    @ViewBuilder
    func effectSettingsToggleButtons() -> some View {
        Group {
            Toggle("showImage", isOn: $effectSettings.showImage.animation())
            Toggle("enableSparkleEffect", isOn: $effectSettings.enableSparkleEffect.animation())
            Toggle("enableHighlightEffect", isOn: $effectSettings.enableHighlightEffect.animation())
            Toggle("enableGradientHolographicEffect", isOn: $effectSettings.enableGradientHolographicEffect.animation())
            Toggle("enableRainbowHolographicEffect", isOn: $effectSettings.enableRainbowHolographicEffect.animation())
        }
    }
}

struct CardPlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        CardPlaygroundView()
    }
}
