//
//  DataType.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 22.04.2025.
//

public enum DataType: Equatable, Hashable {
    case int(Int)
    case double(Double)
    case string(String)
    case bool(Bool)
    case null

    public var description: String {
        switch self {
        case .int(let v): return "\(v)"
        case .double(let v): return "\(v)"
        case .string(let v): return v
        case .bool(let v): return "\(v)"
        case .null: return "null"
        }
    }

    public func toDouble() -> Double? {
        switch self {
        case .int(let v): return Double(v)
        case .double(let v): return v
        case .string(let v): return Double(v)
        default: return nil
        }
    }
}
