//
//  JSONWriter.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 15.04.2025.
//

// Sources/SwiftFrame/IO/JSONWriter.swift

import Foundation

public extension DataFrame {

    /// DataFrame'i JSON string'e dönüştürür
    func toJSON(pretty: Bool = true) -> String? {
        var jsonArray: [[String: Any]] = []
        let rowCount = shape().rows

        for i in 0..<rowCount {
            var row: [String: Any] = [:]
            for (key, series) in columns {
                let value = series[i] ?? .null
                switch value {
                case .int(let v): row[key] = v
                case .double(let v): row[key] = v
                case .string(let v): row[key] = v
                case .bool(let v): row[key] = v
                case .null: row[key] = NSNull()
                }
            }
            jsonArray.append(row)
        }

        let options: JSONSerialization.WritingOptions = pretty ? [.prettyPrinted] : []
        if let data = try? JSONSerialization.data(withJSONObject: jsonArray, options: options) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }

    /// DataFrame'i JSON dosyasına yazar
    func writeJSON(to url: URL, pretty: Bool = true) throws {
        guard let jsonString = toJSON(pretty: pretty) else {
            throw NSError(domain: "SwiftFrame.JSONWriter", code: 1, userInfo: [NSLocalizedDescriptionKey: "Veri JSON'a dönüştürülemedi."])
        }
        try jsonString.write(to: url, atomically: true, encoding: .utf8)
    }
}
