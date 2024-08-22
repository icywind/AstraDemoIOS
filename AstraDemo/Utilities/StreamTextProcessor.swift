//
//  StreamTextProcessor.swift
//  AstraDemo
//
//  Created by Rick Cheng on 8/21/24.
//

import Foundation

struct IChatItem {
    let userId : Int64
    let text : String
    let time : Int64
    let isFinal : Bool
    let isAgent : Bool
}

struct StreamTextProcessor {
    let agoraManager : AgoraManager
    var sttWords : [IChatItem] = []
    mutating func addChatItem(item:IChatItem) {
        let lastFinal = sttWords.lastIndex(where: {item.userId == $0.userId && $0.isFinal} )
        let lastNonFinal = sttWords.lastIndex(where: {item.userId == $0.userId && !$0.isFinal} )
        if (lastFinal != nil) {
            // has last final item
            if (item.time <= sttWords[lastFinal!].time) {
                // discard
                print("addChatItem, time < last final item, discard!:" + item.text)
                return;
            } else {
                // newer time stamp
                if (lastNonFinal != nil) {
                    // this is a longer version of the last non final words, update last item(none final)
                    sttWords[lastNonFinal!] = item
                } else {
                    // add new item
                    sttWords.append(item)
                }
            }
        } else {
            // no last final Item
            if (lastNonFinal != nil) {
              // update last item(none final)
              sttWords[lastNonFinal!] = item
            } else {
              // add new item
              sttWords.append(item)
            }
        }
        sttWords.sort(by: {$0.time < $1.time})
        agoraManager.messages = sttWords.map({ ChatMessage(speaker: $0.isAgent ? "Agent":"You", message: $0.text)})
    }
}
