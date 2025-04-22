//
//  DataFrame+Edit.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 09.04.2025.
//

import Foundation

extension DataFrame {
    
    /// Yeni bir sütun ekler
    public mutating func addColumn(name: String, values: [DataType]) {
        columns[name] = Series(name: name, values: values)
    }

    /// Mevcut bir sütunu siler
    public mutating func dropColumn(name: String) {
        columns.removeValue(forKey: name)
    }

    /// Sütunun adını değiştirir
    public mutating func renameColumn(from oldName: String, to newName: String) {
        guard let series = columns[oldName] else { return }
        columns[newName] = Series(name: newName, values: series.values)
        columns.removeValue(forKey: oldName)
    }

    /// Belirli bir satırı döndürür
    public func row(at index: Int) -> [String: DataType]? {
        var result: [String: DataType] = [:]
        for (key, series) in columns {
            if let value = series[index] {
                result[key] = value
            }
        }
        return result.isEmpty ? nil : result
    }

    /// Tüm satırları bir dizi olarak döndürür
    public var rows: [[String: DataType]] {
        let rowCount = shape().rows
        return (0..<rowCount).compactMap { row(at: $0) }
    }
}
