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
        if value == -Float.infinity || value.isNaN || value.isZero {
            return 0
        }
        return normalizeDb(value: value)
    }
}

func mapBufferToFloatArray(buffer: UnsafeRawPointer, bufferSize: Int) -> [Float32] {
    // Step 1: Cast the void* pointer to an UnsafePointer<Float32>
    let floatPointer = buffer.assumingMemoryBound(to: Float32.self)
    
    // Step 2: Create an UnsafeBufferPointer
    let floatBuffer = UnsafeBufferPointer(start: floatPointer, count: bufferSize)
    
    // Step 3: Convert to a Swift array
    return Array(floatBuffer)
}

func printFloat(floatArray: [Float], total: Int) {
    for i in 0..<min(total, floatArray.count) {
        if i % 8 == 0 && i != 0 {
            print() // New line after every 8 elements
        }
        print(String(format: "%.2f", floatArray[i]), terminator: " ")
    }
    print() // Final new line
}

func genUUID() -> String {
    return UUID().uuidString
}

struct Environment {
    func isRunningOnSimulator() -> Bool {
        #if targetEnvironment(simulator)
           return true
        #else
           return false
        #endif
    }
}
