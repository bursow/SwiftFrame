//
//  TransformOperations.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt
//

// Sources/SwiftFrame/Transform/TransformOperations.swift

import Foundation

public extension DataFrame {

    /// Kolon adlarını yeniden adlandırır
    mutating func rename(columns newNames: [String: String]) {
        for (old, new) in newNames {
            if let series = columns.removeValue(forKey: old) {
                columns[new] = Series(name: new, values: series.values)
            }
        }
    }

    /// Belirli bir kolonu sıralar (ascending=true: artan)
    mutating func sort(by column: String, ascending: Bool = true) {
        guard let sortSeries = columns[column] else { return }
        let sortedIndices = sortSeries.values.enumerated()
            .sorted(by: { ascending ? ($0.element.toDouble() ?? 0) < ($1.element.toDouble() ?? 0) : ($0.element.toDouble() ?? 0) > ($1.element.toDouble() ?? 0) })
            .map { $0.offset }

        for (key, var series) in columns {
            series.values = sortedIndices.map { series.values[$0] }
            columns[key] = series
        }
    }

    /// Belirli bir kolona göre filtreleme yapar
    func filter(where column: String, is condition: (DataType) -> Bool) -> DataFrame {
        guard let series = columns[column] else { return self }
        let indices = series.values.enumerated().compactMap { condition($0.element) ? $0.offset : nil }

        var filteredCols: [String: Series] = [:]
        for (key, colSeries) in columns {
            let filteredValues = indices.compactMap { colSeries.values[$0] }
            filteredCols[key] = Series(name: key, values: filteredValues)
        }

        return DataFrame(columns: filteredCols)
    }

    /// Bir kolondaki tüm değerleri fonksiyona göre dönüştürür
    mutating func map(column: String, transform: (DataType) -> DataType) {
        guard var series = columns[column] else { return }
        for i in 0..<series.values.count {
            series.values[i] = transform(series.values[i])
        }
        columns[column] = series
    }
}
