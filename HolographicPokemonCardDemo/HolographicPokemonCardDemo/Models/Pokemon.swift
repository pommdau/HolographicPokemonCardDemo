//
//  Pokemon.swift
//  hoverdemo
//
//  Created by HIROKI IKEUCHI on 2023/03/31.
//

import SwiftUI

struct Pokemon {
    let uuid = UUID()
    let gradientColor1: Color
    let gradientColor2: Color
    let gradientColor3: Color
    let image: Image
    let imageURL: URL
    let cardbackImage = Image("cardback")  // Assetsに画像登録して使う場合
    let cardbackImageURL = URL(string: "https://cdn2.bulbagarden.net/upload/1/17/Cardback.jpg")
    
    init(gradientColor1: Color = Color(red: 0, green: 231/255, blue: 1),
         gradientColor2: Color = .blue,
         gradientColor3: Color = Color(red: 1, green: 0, blue: 231/255),
         image: Image,
         imageURL: URL) {
        self.gradientColor1 = gradientColor1
        self.gradientColor2 = gradientColor2
        self.gradientColor3 = gradientColor3
        self.image = image
        self.imageURL = imageURL
    }
}

// MARK: - Identifiable

extension Pokemon: Identifiable {
    var id: UUID { uuid }
}

// MARK: - Sample Data

// refs:
// https://codepen.io/simeydotme/pen/PrQKgo
// gradientColor2の作成: [Color Blender](https://meyerweb.com/eric/tools/color-blend/#:::hex)
// gradientColor2に適した色をつけるともっとわかりやすい効果になるかもしれない
extension Pokemon {
    
    static let sampleData: [Pokemon] = [.charizard, .pikachu, .eevee, .mewtwo]
    
    static let charizard = Pokemon(gradientColor1: Color(hex: "ffaacc"),
                                   gradientColor2: Color(hex: "EEBBBB"),
                                   gradientColor3: Color(hex: "ddccaa"),
                                   image: Image("charizard-gx"),
                                   imageURL: URL(string: "https://assets.codepen.io/13471/charizard-gx.webp")!)
    
    static let pikachu = Pokemon(gradientColor1: Color(hex: "54a29e"),
                                 gradientColor2: Color(hex: "7EA082"),
                                 gradientColor3: Color(hex: "a79d66"),
                                 image: Image("pikachu-gx"),
                                 imageURL: URL(string: "https://assets.codepen.io/13471/pikachu-gx.webp")!)
        
    static let eevee = Pokemon(gradientColor1: Color(red: 0, green: 231/255, blue: 1),
                               gradientColor2: .blue,
                               gradientColor3: Color(red: 1, green: 0, blue: 231/255),
                               image: Image("eevee-gx"),
                               imageURL: URL(string: "https://assets.codepen.io/13471/eevee-gx.webp")!)
    
    static let mewtwo = Pokemon(gradientColor1: Color(hex: "efb2fb"),
                                gradientColor2: Color(hex: "CEBCFA"),
                                gradientColor3: Color(hex: "acc6f8"),
                                image: Image("mewtwo-gx"),
                                imageURL: URL(string: "https://assets.codepen.io/13471/mewtwo-gx.webp")!)
    
}
