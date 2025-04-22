//  DataFrame+Transform.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 06.04.2025.

// Sources/SwiftFrame/DataFrame/DataFrame+Transform.swift


import Foundation

public extension DataFrame {

    /// Belirli kolonları farklı DataType'a dönüştürür
    mutating func astype(_ column: String, to type: String) {
        guard let series = columns[column] else { return }

        let converted = series.values.map { value -> DataType in
            switch type.lowercased() {
            case "int": return .int(value.toInt() ?? 0)
            case "double": return .double(value.toDouble() ?? 0.0)
            case "bool": return .bool(value.toBool() ?? false)
            case "string": return .string(value.asString)
            default: return value
            }
        }

        columns[column] = Series(name: column, values: converted)
    }

    /// Null (boş) verileri verilen değerle doldurur
    mutating func fillna(column: String, with value: DataType) {
        guard let series = columns[column] else { return }

        let filled = series.values.map { $0.isNull ? value : $0 }
        columns[column] = Series(name: column, values: filled)
    }

    /// Null (boş) değer içeren satırları siler
    mutating func dropna() {
        let rowCount = shape().rows
        var toKeep = [Bool](repeating: true, count: rowCount)

        for series in columns.values {
            for (i, val) in series.values.enumerated() {
                if val.isNull { toKeep[i] = false }
            }
        }

        for (col, var series) in columns {
            series.values = series.values.enumerated().compactMap { toKeep[$0.offset] ? $0.element : nil }
            columns[col] = series
        }
    }

    /// Belirli kolonlarda eşleşen değerleri değiştirir
    mutating func replace(column: String, old: DataType, new: DataType) {
        guard let series = columns[column] else { return }

        let replaced = series.values.map { $0 == old ? new : $0 }
        columns[column] = Series(name: column, values: replaced)
    }
}

