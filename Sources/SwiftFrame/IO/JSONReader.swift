//
//  JSONReader.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 12.04.2025.
//

// Sources/SwiftFrame/IO/JSONReader.swift

import Foundation

extension DataFrame {
    /// JSON'dan DataFrame oluşturur ([String: [Any]])
    public static func fromJSON(_ json: [String: [Any]]) -> DataFrame {
        var result: [String: [DataType]] = [:]

        for (key, array) in json {
            result[key] = array.map { value in
                if let intVal = value as? Int { return .int(intVal) }
                if let doubleVal = value as? Double { return .double(doubleVal) }
                if let boolVal = value as? Bool { return .bool(boolVal) }
                if let stringVal = value as? String { return .string(stringVal) }
                return .null
            }
        }

        let seriesDict = result.mapValues { Series(name: $0.first?.description ?? "", values: $0) }
        return DataFrame(columns: seriesDict)
    }

    /// Bir URL'den JSON dosyası okuyarak DataFrame döner (local dosya veya bundle)
    public static func loadJSON(from url: URL) -> DataFrame? {
        do {
            let data = try Data(contentsOf: url)
            if let jsonObj = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [Any]] {
                return fromJSON(jsonObj)
            }
        } catch {
            print("[SwiftFrame] JSON read error: \(error)")
        }
        return nil
    }
}
