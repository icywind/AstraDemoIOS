//
//  TranscriptionView.swift
//  AstraDemo
//
//  Created by Rick Cheng on 8/21/24.
//

import SwiftUI

struct ChatMessage: Identifiable {
    let id = UUID()
    let speaker: String
    let message: String
}

struct TranscriptionView: View {
    
    let messages: [ChatMessage]
    let speakerA: String
    let speakerB: String
    
    var body: some View {
        List(messages) { message in
            HStack {
                if message.speaker == speakerA {
                    VStack(alignment: .leading) {
                        Text(message.speaker)
                            .font(.headline)
                            .foregroundColor(.blue)
                        Text(message.message)
                            .font(.body)
                            .foregroundColor(.primary) // automatically adjusted to dark/light
                    }
                    Spacer()
                } else if message.speaker == speakerB {
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(message.speaker)
                            .font(.headline)
                            .foregroundColor(.green)
                        Text(message.message)
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                } else {
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(message.speaker)
                            .font(.headline)
                            .foregroundColor(.purple)
                        Text(message.message)
                            .font(.body)
                            .foregroundColor(.black)
                    }
                }
            }
            .padding(.vertical, 4)
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        TranscriptionView(
            messages: [
                ChatMessage(speaker: "Alice", message: "Hello! How are you?"),
                ChatMessage(speaker: "Bob", message: "I'm good, thanks! How about you?"),
                ChatMessage(speaker: "Alice", message: "I'm doing well, thank you!"),
                ChatMessage(speaker: "Bob", message: "Want to go karaoke?"),
                ChatMessage(speaker: "Alice", message: "Why not?"),
                ChatMessage(speaker: "Alice", message: "Actually I want to eat"),
            ],
            speakerA: "Alice",
            speakerB: "Bob"
        )
    }
}
//
//
//#Preview {
//    TranscriptionView()
//}
