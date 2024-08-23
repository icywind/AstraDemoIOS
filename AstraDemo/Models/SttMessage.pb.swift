// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: SttMessage.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct Agora_SpeechToText_Text: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var vendor: Int32 = 0

  var version: Int32 = 0

  var seqnum: Int32 = 0

  var uid: Int64 = 0

  var flag: Int32 = 0

  var time: Int64 = 0

  var lang: Int32 = 0

  var starttime: Int32 = 0

  var offtime: Int32 = 0

  var words: [Agora_SpeechToText_Word] = []

  var endOfSegment: Bool = false

  var durationMs: Int32 = 0

  /// transcribe ,translate
  var dataType: String = String()

  var trans: [Agora_SpeechToText_Translation] = []

  var culture: String = String()

  /// pkg timestamp
  var texttime: Int64 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Agora_SpeechToText_Word: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var text: String = String()

  var startMs: Int32 = 0

  var durationMs: Int32 = 0

  var isFinal: Bool = false

  var confidence: Double = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Agora_SpeechToText_Translation: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var isFinal: Bool = false

  /// 翻译语言
  var lang: String = String()

  var texts: [String] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "Agora.SpeechToText"

extension Agora_SpeechToText_Text: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Text"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "vendor"),
    2: .same(proto: "version"),
    3: .same(proto: "seqnum"),
    4: .same(proto: "uid"),
    5: .same(proto: "flag"),
    6: .same(proto: "time"),
    7: .same(proto: "lang"),
    8: .same(proto: "starttime"),
    9: .same(proto: "offtime"),
    10: .same(proto: "words"),
    11: .standard(proto: "end_of_segment"),
    12: .standard(proto: "duration_ms"),
    13: .standard(proto: "data_type"),
    14: .same(proto: "trans"),
    15: .same(proto: "culture"),
    16: .same(proto: "texttime"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt32Field(value: &self.vendor) }()
      case 2: try { try decoder.decodeSingularInt32Field(value: &self.version) }()
      case 3: try { try decoder.decodeSingularInt32Field(value: &self.seqnum) }()
      case 4: try { try decoder.decodeSingularInt64Field(value: &self.uid) }()
      case 5: try { try decoder.decodeSingularInt32Field(value: &self.flag) }()
      case 6: try { try decoder.decodeSingularInt64Field(value: &self.time) }()
      case 7: try { try decoder.decodeSingularInt32Field(value: &self.lang) }()
      case 8: try { try decoder.decodeSingularInt32Field(value: &self.starttime) }()
      case 9: try { try decoder.decodeSingularInt32Field(value: &self.offtime) }()
      case 10: try { try decoder.decodeRepeatedMessageField(value: &self.words) }()
      case 11: try { try decoder.decodeSingularBoolField(value: &self.endOfSegment) }()
      case 12: try { try decoder.decodeSingularInt32Field(value: &self.durationMs) }()
      case 13: try { try decoder.decodeSingularStringField(value: &self.dataType) }()
      case 14: try { try decoder.decodeRepeatedMessageField(value: &self.trans) }()
      case 15: try { try decoder.decodeSingularStringField(value: &self.culture) }()
      case 16: try { try decoder.decodeSingularInt64Field(value: &self.texttime) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.vendor != 0 {
      try visitor.visitSingularInt32Field(value: self.vendor, fieldNumber: 1)
    }
    if self.version != 0 {
      try visitor.visitSingularInt32Field(value: self.version, fieldNumber: 2)
    }
    if self.seqnum != 0 {
      try visitor.visitSingularInt32Field(value: self.seqnum, fieldNumber: 3)
    }
    if self.uid != 0 {
      try visitor.visitSingularInt64Field(value: self.uid, fieldNumber: 4)
    }
    if self.flag != 0 {
      try visitor.visitSingularInt32Field(value: self.flag, fieldNumber: 5)
    }
    if self.time != 0 {
      try visitor.visitSingularInt64Field(value: self.time, fieldNumber: 6)
    }
    if self.lang != 0 {
      try visitor.visitSingularInt32Field(value: self.lang, fieldNumber: 7)
    }
    if self.starttime != 0 {
      try visitor.visitSingularInt32Field(value: self.starttime, fieldNumber: 8)
    }
    if self.offtime != 0 {
      try visitor.visitSingularInt32Field(value: self.offtime, fieldNumber: 9)
    }
    if !self.words.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.words, fieldNumber: 10)
    }
    if self.endOfSegment != false {
      try visitor.visitSingularBoolField(value: self.endOfSegment, fieldNumber: 11)
    }
    if self.durationMs != 0 {
      try visitor.visitSingularInt32Field(value: self.durationMs, fieldNumber: 12)
    }
    if !self.dataType.isEmpty {
      try visitor.visitSingularStringField(value: self.dataType, fieldNumber: 13)
    }
    if !self.trans.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.trans, fieldNumber: 14)
    }
    if !self.culture.isEmpty {
      try visitor.visitSingularStringField(value: self.culture, fieldNumber: 15)
    }
    if self.texttime != 0 {
      try visitor.visitSingularInt64Field(value: self.texttime, fieldNumber: 16)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Agora_SpeechToText_Text, rhs: Agora_SpeechToText_Text) -> Bool {
    if lhs.vendor != rhs.vendor {return false}
    if lhs.version != rhs.version {return false}
    if lhs.seqnum != rhs.seqnum {return false}
    if lhs.uid != rhs.uid {return false}
    if lhs.flag != rhs.flag {return false}
    if lhs.time != rhs.time {return false}
    if lhs.lang != rhs.lang {return false}
    if lhs.starttime != rhs.starttime {return false}
    if lhs.offtime != rhs.offtime {return false}
    if lhs.words != rhs.words {return false}
    if lhs.endOfSegment != rhs.endOfSegment {return false}
    if lhs.durationMs != rhs.durationMs {return false}
    if lhs.dataType != rhs.dataType {return false}
    if lhs.trans != rhs.trans {return false}
    if lhs.culture != rhs.culture {return false}
    if lhs.texttime != rhs.texttime {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Agora_SpeechToText_Word: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Word"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "text"),
    2: .standard(proto: "start_ms"),
    3: .standard(proto: "duration_ms"),
    4: .standard(proto: "is_final"),
    5: .same(proto: "confidence"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.text) }()
      case 2: try { try decoder.decodeSingularInt32Field(value: &self.startMs) }()
      case 3: try { try decoder.decodeSingularInt32Field(value: &self.durationMs) }()
      case 4: try { try decoder.decodeSingularBoolField(value: &self.isFinal) }()
      case 5: try { try decoder.decodeSingularDoubleField(value: &self.confidence) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.text.isEmpty {
      try visitor.visitSingularStringField(value: self.text, fieldNumber: 1)
    }
    if self.startMs != 0 {
      try visitor.visitSingularInt32Field(value: self.startMs, fieldNumber: 2)
    }
    if self.durationMs != 0 {
      try visitor.visitSingularInt32Field(value: self.durationMs, fieldNumber: 3)
    }
    if self.isFinal != false {
      try visitor.visitSingularBoolField(value: self.isFinal, fieldNumber: 4)
    }
    if self.confidence.bitPattern != 0 {
      try visitor.visitSingularDoubleField(value: self.confidence, fieldNumber: 5)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Agora_SpeechToText_Word, rhs: Agora_SpeechToText_Word) -> Bool {
    if lhs.text != rhs.text {return false}
    if lhs.startMs != rhs.startMs {return false}
    if lhs.durationMs != rhs.durationMs {return false}
    if lhs.isFinal != rhs.isFinal {return false}
    if lhs.confidence != rhs.confidence {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Agora_SpeechToText_Translation: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Translation"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "is_final"),
    2: .same(proto: "lang"),
    3: .same(proto: "texts"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularBoolField(value: &self.isFinal) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.lang) }()
      case 3: try { try decoder.decodeRepeatedStringField(value: &self.texts) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.isFinal != false {
      try visitor.visitSingularBoolField(value: self.isFinal, fieldNumber: 1)
    }
    if !self.lang.isEmpty {
      try visitor.visitSingularStringField(value: self.lang, fieldNumber: 2)
    }
    if !self.texts.isEmpty {
      try visitor.visitRepeatedStringField(value: self.texts, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Agora_SpeechToText_Translation, rhs: Agora_SpeechToText_Translation) -> Bool {
    if lhs.isFinal != rhs.isFinal {return false}
    if lhs.lang != rhs.lang {return false}
    if lhs.texts != rhs.texts {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
