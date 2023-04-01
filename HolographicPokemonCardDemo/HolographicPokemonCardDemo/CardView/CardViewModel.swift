//
//  CardViewModel.swift
//  hoverdemo
//
//  Created by HIROKI IKEUCHI on 2023/04/01.
//

import SwiftUI

extension CardViewModel {
    static let imageSize = CGSize(width: 734, height: 1024)  // ポケモンカードの画像サイズ: 734*1024
    static var imageRatio: Double {
        imageSize.width / imageSize.height
    }
}

class CardViewModel: ObservableObject {
    
    @Published var isHovering = false
    @Published var hoverLocation: CGPoint = .zero
    @Published var actualSize: CGSize = .zero

    // MARK: - Computed Property
    
    var hoverLocationRatio: CGPoint {
        .init(x: hoverLocation.x / actualSize.width,
              y: hoverLocation.y / actualSize.height)
    }
    var lotationDegrees: CGPoint {
        let maxDegree: CGFloat = 20
        return CGPoint(x: -maxDegree * (hoverLocationRatio.x - 0.5),
                       y: maxDegree * (hoverLocationRatio.y - 0.5))
    }
    
    var defaultHoverLocation: CGPoint {
        CGPoint(x: actualSize.width / 2, y: actualSize.height / 2)
    }
    
    func handleOnContinuousHover(phase: HoverPhase) {
        switch phase {
        case .active(let location):
            hoverLocation = location
            isHovering = true
            print(location)
        case .ended:
            withAnimation {
                isHovering = false
                hoverLocation = defaultHoverLocation
            }
        }
    }
}
