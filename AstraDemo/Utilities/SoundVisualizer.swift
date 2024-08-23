//
//  SoundVisualizer.swift
//  AstraDemo
//
//  Created by Rick Cheng on 8/23/24.
//

import SwiftUI
let VisualizerSamples = 5

struct SoundVisualizer: View {
    @ObservedObject var agoraManager : AgoraManager
    let MinHeight : CGFloat = 10
    let MaxHeight : CGFloat = 100

    init(agora : AgoraManager) {
        agoraManager = agora
    }
    
    private func normalizeSoundLevel(level: Float) -> CGFloat {
        var norm = 4 * min(25, CGFloat(level) * 3/2) + MinHeight // between 5 and 100
        norm = norm > MaxHeight ? MaxHeight : norm
        return norm
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 4) {
                ForEach(agoraManager.soundSamples.indices, id: \.self) { index in
                    BarView(value: self.normalizeSoundLevel(level: agoraManager.soundSamples[index]))
                    //BarView(value: CGFloat(agoraManager.soundSamples[index]))
                }
            }
        }
        .padding()
    }
}

#Preview {
    SoundVisualizer(agora: AgoraManager(appId: AppConfig.shared.appId, role: .broadcaster))
}

struct BarView: View {
    var value: CGFloat = 0

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(LinearGradient(gradient: Gradient(colors: [.green, .blue]),
                                     startPoint: .top,
                                     endPoint: .bottom))
                .frame(
                    width: 20,
                    height: value
                )
        }
    }
}

