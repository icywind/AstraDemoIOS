//
//  UtilFunctions.swift
//  AstraDemo
//
//  Created by Rick Cheng on 8/13/24.
//

import Foundation

func genRandomString(length: Int = 10) -> String {
    let characters = "abcdefghijklmnopqrstuvwxyz0123456789"
    var result = ""

    for _ in 0..<length {
        let randomIndex = Int.random(in: 0..<characters.count)
        let randomCharacter = characters[characters.index(characters.startIndex, offsetBy: randomIndex)]
        result += String(randomCharacter)
    }

    return result
}

func getRandomUserId() -> Int {
    return Int.random(in: 100000..<200000)
}

func getRandomChannel(number: Int = 6) -> String {
    return "agora_" + genRandomString(length: number)
}

func sleep(ms: Int) {
    usleep(UInt32(ms * 1000)) // usleep operates on microseconds
}

func normalizeFrequencies(frequencies: [Float]) -> [Float] {
    func normalizeDb(value: Float) -> Float {
        let minDb: Float = -100
        let maxDb: Float = -10
        var db = 1 - max(minDb, min(maxDb, value)) * -1 / 100
        db = sqrt(db)

        return db
    }

    return frequencies.map { value in
        if value == -Float.infinity {
            return 0
        }
        return normalizeDb(value: value)
    }
}

func genUUID() -> String {
    return UUID().uuidString
}
