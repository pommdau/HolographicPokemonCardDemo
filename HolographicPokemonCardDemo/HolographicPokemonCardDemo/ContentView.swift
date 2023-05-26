//
//  ContentView.swift
//  HolographicPokemonCardDemo
//
//  Created by HIROKI IKEUCHI on 2023/04/01.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CardPlaygroundView()
            .frame(minWidth: 800, minHeight: 600)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
