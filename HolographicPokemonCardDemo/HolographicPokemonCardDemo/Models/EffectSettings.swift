//
//  EffectSettings.swift
//  hoverdemo
//
//  Created by HIROKI IKEUCHI on 2023/04/01.
//

import Foundation

class EffectSettings: ObservableObject {
    @Published var showImage = true
    @Published var enableSparkleEffect = true
    @Published var enableHighlightEffect = false
    
    // 以下はどちらかを選んで使用すると良い
    @Published var enableGradientHolographicEffect = true
    @Published var enableRainbowHolographicEffect = false
    
    func updateAll(enable: Bool) {
        showImage = enable
        enableSparkleEffect = enable
        enableHighlightEffect = enable
        enableGradientHolographicEffect = enable
        enableRainbowHolographicEffect = enable
    }
}
