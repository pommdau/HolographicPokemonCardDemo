//
//  StickerView.swift
//  HolographicPokemonCardDemo
//
//  Created by HIROKI IKEUCHI on 2023/04/02.
//

// refs: [【SwiftUI】Viewの切り取りとマスク](https://capibara1969.com/1939/)

import SwiftUI

struct StickerView: View {
    
    @State private var isHovering = false
    @State private var hoverLocation: CGPoint = .zero
    @State private var actualSize: CGSize = .zero
    
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
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0, style: .continuous)
//                .fillAndStroke(Color(hex: "B2A4FF"), strokeBorder: .clear)
                .fillAndStroke(.green, strokeBorder: .clear)
                .brightness(0.01)
//                .overlay() {
//                    StickerMVPBackground()
//                        .fixedSize()
//                        .rotationEffect(Angle(degrees: 20))
//                }
                .indigoEffect(locationRatioX: hoverLocationRatio.x, locationRatioY: hoverLocationRatio.y)
            
//                .rainbowStickerHolographicEffect(locationRatioX: hoverLocationRatio.x)

//            VStack(alignment: .center) {
//
//                RoundedRectangle(cornerRadius: actualSize.height * 0.07, style: .continuous)
//                    .frame(width: actualSize.width * 0.56, height: actualSize.height * 0.14)
//                    .foregroundColor(.black.opacity(0.6))
//                    .reverseMask {
//                        Text("GENUINE MVP")
//                            .font(.title).fontWeight(.semibold)
//                    }
//                    .padding(.top, 10)
//
//                Spacer()
//
//
//
//                HStack(alignment: .bottom, spacing: -20) {
//                    Group {
//                        Circle().fillAndStroke(.black.opacity(0.2), strokeBorder: .orange, lineWidth: 4)
//                        Circle().fillAndStroke(.black.opacity(0.2), strokeBorder: .orange, lineWidth: 4)
//                        Circle().fillAndStroke(.black.opacity(0.2), strokeBorder: .orange, lineWidth: 4)
//                    }
//                    .frame(width: 100, height: 100)
//                }
//
//                Spacer()
//
//                RoundedRectangle(cornerRadius: actualSize.height * 0.07, style: .continuous)
//                    .frame(width: actualSize.width * 0.56, height: actualSize.height * 0.14)
//                    .foregroundColor(.black.opacity(0.6))
//                    .reverseMask {
//                        Text("COMPONENT")
//                            .font(.title).fontWeight(.semibold)
//                    }
//                    .padding(.bottom, 10)
//            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onContinuousHover(coordinateSpace: .local) { phase in
            handleOnContinuousHover(phase: phase)
        }
        .background(
            GeometryReader { proxy in
                Color.clear
                    .onAppear() {
                        actualSize = proxy.size
                    }
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 20)
        .cardRorationEffect(locationRatioX: hoverLocationRatio.x, locationRatioY: hoverLocationRatio.y)

    }
    
    func handleOnContinuousHover(phase: HoverPhase) {
        switch phase {
        case .active(let location):
            hoverLocation = location
            isHovering = true
        case .ended:
            withAnimation {
                isHovering = false
                hoverLocation = defaultHoverLocation
            }
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.closeSubpath()
        }
    }
}


struct StickerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue.opacity(0.2)
                .zIndex(-1)
            StickerView()
                .frame(width: 300)
        }
        .frame(width: 500, height: 500)
    }
}

extension View {
        
    func rainbowStickerHolographicEffect(isOn: Bool = true, locationRatioX gradientLocationCenter: Double) -> some View {
                
        var gradientStops: [Gradient.Stop] = []
        var currentRainbowColor = RainbowColor.center
        let step: Double = 0.2
        for i in 0...Int(1.0 / step) {
            gradientStops.append(.init(color: currentRainbowColor.color, location: step * Double(i)))
            currentRainbowColor = currentRainbowColor.next()
        }
        let offsetX = 300 * ((gradientLocationCenter - 0.5) / 0.5)
        
        return self
            .overlay() {
                if isOn && !gradientLocationCenter.isNaN {
                    LinearGradient(gradient: Gradient(stops: gradientStops),
                                   startPoint: .leading,
                                   endPoint: .trailing)
                    .padding(-400)
                    .offset(x: offsetX)
                    .opacity(1.0)
                    .rotationEffect(Angle(degrees: 50))
                    .blendMode(.overlay)
                }
            }
    }
    
    func indigoEffect(isOn: Bool = true, locationRatioX: Double, locationRatioY: Double) -> some View {
        // 0,  0.5, 1
        // -1, 0,   1
        let opacity1 = locationRatioX
        let opacity2 = locationRatioY
//        opacity = max(0.1, min(opacity, 0.5))
        let blendMode: BlendMode = .colorDodge
        let image = Image("dot_2_1")
        
        return self
            .overlay() {
                if isOn && !locationRatioX.isNaN && !locationRatioY.isNaN {
                    ZStack {
                        image
                            .resizable()
                            .padding(-10)
                            .opacity(1 - opacity1)
                            .blendMode(blendMode)

                        image
                            .resizable()
                            .padding(-10)
                            .rotationEffect(Angle(degrees: 180))
                            .opacity(opacity1)
                            .blendMode(blendMode)

                        image
                            .resizable()
                            .padding(-10)
                            .rotationEffect(Angle(degrees: 90))
                            .opacity(opacity2)
                            .blendMode(blendMode)

                        image
                            .resizable()
                            .padding(-10)
                            .rotationEffect(Angle(degrees: 270))
                            .opacity(1 - opacity2)
                            .blendMode(blendMode)
                        
//                        Image("dot_2_1")
//                            .resizable()
//                            .padding(-10)
//                            .opacity(1 - opacity)
//                            .blendMode(.overlay)
//
//                        Image("dot_3_1")
//                            .resizable()
//                            .padding(-10)
//                            .opacity(1 - opacity)
//                            .blendMode(.overlay)
//
//                        Image("dot_1_1")
//                            .resizable()
//                            .padding(-10)
//                            .opacity(1 - opacity)
//                            .blendMode(.overlay)
                    }
                }
            }
    }
}

/// refs: [How to get next case of enum\(i\.e\. write a circulating method\) in Swift 4\.2](https://stackoverflow.com/questions/51103795/how-to-get-next-case-of-enumi-e-write-a-circulating-method-in-swift-4-2)
enum RainbowColor: String, CaseIterable {
    
    case red = "#ff0000"
    case orange = "#ffa500"
    case yellow = "#ffff00"
    case green = "#008000"
    case blue = "#0000ff"
    case indigo = "#4b0082"
    case violet = "#ee82ee"
    
    static var center: RainbowColor {
        return RainbowColor.red
    }
    
    var color: Color {
        return Color(hex: self.rawValue)
    }
    
    func previous() -> RainbowColor {
        let all = type(of: self).allCases // 1
        if self == all.first! {
            return all.last!
        } else {
            let index = all.firstIndex(of: self)!
            return all[index - 1]
        }
    }
    
    func next() -> RainbowColor {
        let all = type(of: self).allCases // 1
        if self == all.last! {
            return all.first!
        } else {
            let index = all.firstIndex(of: self)!
            return all[index + 1]
        }
    }
}
