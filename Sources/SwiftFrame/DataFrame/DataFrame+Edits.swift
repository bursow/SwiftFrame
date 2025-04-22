//
//  DataFrame+Edits.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 22.04.2025.
//

// Sources/SwiftFrame/DataFrame/DataFrame+EditingRows.swift

import Foundation

public extension DataFrame {

    /// Yeni bir satır ekler
    mutating func insertRow(_ row: [String: DataType]) {
        for (col, value) in row {
            if columns[col] == nil {
                columns[col] = Series(name: col, values: [])
            }
            columns[col]?.values.append(value)
        }

        // Eksik sütunlar varsa null ile doldur
        for key in columns.keys {
            if row[key] == nil {
                columns[key]?.values.append(.null)
            }
        }
    }

    /// Belirli bir satırı siler
    mutating func deleteRow(at index: Int) {
        for (key, var series) in columns {
            if index < series.values.count {
                series.values.remove(at: index)
                columns[key] = series
            }
        }
    }

    /// Hücre değerini günceller
    mutating func updateCell(row: Int, column: String, value: DataType) {
        guard var series = columns[column], row < series.values.count else { return }
        series.values[row] = value
        columns[column] = series
    }
}
