//
//  View+reverseMask.swift
//  HolographicPokemonCardDemo
//
//  Created by HIROKI IKEUCHI on 2023/04/02.
//

import SwiftUI


/// refs: https://www.fivestars.blog/articles/reverse-masks-how-to/
extension View {
    @inlinable
    public func reverseMask<Mask: View>(
        alignment: Alignment = .center,
        @ViewBuilder _ mask: () -> Mask
    ) -> some View {
        self.mask {
            Rectangle()
                .overlay(alignment: alignment) {
                    mask()
                        .blendMode(.destinationOut)
                }
        }
    }
}
