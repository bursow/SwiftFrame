//
//  DataType+Extensions.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 22.04.2025.
//

public extension DataType {
    
    /// Null olup olmadığını döner
    var isNull: Bool {
        if case .null = self { return true }
        return false
    }

    /// Sayısal veri mi (int veya double)?
    var isNumeric: Bool {
        toDouble() != nil
    }

    /// String temsili
    var asString: String {
        description
    }

    /// Int'e çevirir
    func toInt() -> Int? {
        switch self {
        case .int(let i): return i
        case .double(let d): return Int(d)
        case .string(let s): return Int(s)
        default: return nil
        }
    }

    /// Bool'a çevirir
    func toBool() -> Bool? {
        switch self {
        case .bool(let b): return b
        case .string(let s): return ["true", "yes", "1"].contains(s.lowercased())
        default: return nil
        }
    }
}
