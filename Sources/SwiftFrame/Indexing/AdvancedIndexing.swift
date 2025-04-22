//  AdvancedIndexing.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 02.04.2025.

// Sources/SwiftFrame/Indexing/AdvancedIndexing.swift

import Foundation

public extension DataFrame {

    /// Belirli bir satır ve kolon adı üzerinden değer döndürür
    func loc(row: Int, column: String) -> DataType? {
        return columns[column]?[row]
    }

    /// Belirli bir satır ve kolon indeksinden değer döndürür
    func iloc(row: Int, colIndex: Int) -> DataType? {
        let colName = Array(columns.keys)[safe: colIndex]
        return colName.flatMap { columns[$0]?[row] }
    }

    /// Belirli koşulu sağlayan satırları döndürür (pandas-style query)
    func query(_ condition: (Row) -> Bool) -> DataFrame {
        let rowCount = shape().rows
        var matchedIndices: [Int] = []

        for i in 0..<rowCount {
            let row = Row(index: i, data: columns.mapValues { $0[i] ?? .null })
            if condition(row) {
                matchedIndices.append(i)
            }
        }

        var resultColumns: [String: Series] = [:]
        for (key, series) in columns {
            resultColumns[key] = Series(name: key, values: matchedIndices.compactMap { series[$0] })
        }

        return DataFrame(columns: resultColumns)
    }
}

/// Tek satırlık veri için yardımcı yapı
public struct Row {
    public let index: Int
    public let data: [String: DataType]

    public subscript(_ column: String) -> DataType? {
        return data[column]
    }
}

