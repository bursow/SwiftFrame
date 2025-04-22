//
//  DataFrame+Combin.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 11.04.2025.
//

// Sources/SwiftFrame/DataFrame/DataFrame+Combine.swift

import Foundation

public extension DataFrame {
    /// İki DataFrame'i satır bazında birleştirir (column'lar aynı olmalı)
    func concatRows(with other: DataFrame) -> DataFrame {
        var newColumns: [String: [DataType]] = [:]

        // Tüm kolonları dolaş
        for key in Set(columns.keys).union(other.columns.keys) {
            let first = columns[key]?.values ?? Array(repeating: .null, count: shape().rows)
            let second = other.columns[key]?.values ?? Array(repeating: .null, count: other.shape().rows)
            newColumns[key] = first + second
        }

        let combined = newColumns.mapValues { Series(name: $0.first?.description ?? "", values: $0) }
        return DataFrame(columns: combined)
    }

    /// İki DataFrame'i kolon bazında birleştirir (satır sayısı eşit olmalı)
    func concatColumns(with other: DataFrame) -> DataFrame {
        guard shape().rows == other.shape().rows else {
            fatalError("Row count mismatch in concatColumns")
        }

        var newColumns = columns
        for (key, series) in other.columns {
            newColumns[key] = series
        }

        return DataFrame(columns: newColumns)
    }

    /// INNER JOIN benzeri: Belirli bir kolon değerine göre birleştirir
    func join(with other: DataFrame, on key: String) -> DataFrame {
        guard let leftCol = self.columns[key], let rightCol = other.columns[key] else {
            return self
        }

        var resultRows: [[String: DataType]] = []

        for (i, val) in leftCol.values.enumerated() {
            for (j, rVal) in rightCol.values.enumerated() {
                if val == rVal {
                    var row: [String: DataType] = [:]
                    for (colName, series) in self.columns {
                        row[colName] = series[i]
                    }
                    for (colName, series) in other.columns where colName != key {
                        row["\(colName)_right"] = series[j]
                    }
                    row[key] = val
                    resultRows.append(row)
                }
            }
        }

        // Satırları DataFrame'e dönüştür
        var result = DataFrame(columns: [:])
        for row in resultRows {
            result.insertRow(row)
        }

        return result
    }
}
