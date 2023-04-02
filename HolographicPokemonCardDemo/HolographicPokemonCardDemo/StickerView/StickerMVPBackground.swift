//
//  StickerMVPBackground.swift
//  HolographicPokemonCardDemo
//
//  Created by HIROKI IKEUCHI on 2023/04/02.
//

import SwiftUI

struct StickerMVPBackground: View {
    var body: some View {
        VStack(spacing: 12) {
            ForEach(0..<12) { row_i in
                HStack(spacing: 30) {
                    ForEach(0..<6) { _ in
                        Text("MVP")
                            .font(.title)
                            .foregroundColor(.purple)
                    }
                }
                .offset(x: (row_i % 2 == 0) ? 34 : 0)
            }
        }
    }
}

struct StickerMVPBackground_Previews: PreviewProvider {
    static var previews: some View {
        StickerMVPBackground()
    }
}
