//
//  GroupAggregate.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 09.04.2025.
//

// Sources/SwiftFrame/Operators/GroupAggregate.swift

import Foundation

extension DataFrame {
    /// Belirli bir sütuna göre gruplandırma işlemi yapar
    public func groupBy(column columnName: String) -> [DataType: [String: Series]] {
        guard let groupColumn = columns[columnName] else { return [:] }

        var grouped: [DataType: [String: [DataType]]] = [:]
        let rowCount = groupColumn.count()

        for i in 0..<rowCount {
            guard let key = groupColumn[i] else { continue }
            for (colName, series) in columns {
                guard let value = series[i] else { continue }
                grouped[key, default: [:]][colName, default: []].append(value)
            }
        }

        // Dönüştür: [DataType: [String: [DataType]]] → [DataType: [String: Series]]
        var result: [DataType: [String: Series]] = [:]
        for (key, data) in grouped {
            var groupedSeries: [String: Series] = [:]
            for (col, values) in data {
                groupedSeries[col] = Series(name: col, values: values)
            }
            result[key] = groupedSeries
        }

        return result
    }

    /// Grup bazında aggregate işlemi uygular (örnek: mean, sum)
    public func aggregate(
        by groupColumn: String,
        targetColumn: String,
        using aggregation: (Series) -> Double?
    ) -> Series {
        let grouped = groupBy(column: groupColumn)
        var result: [DataType] = []
        var labels: [String] = []

        for (group, seriesMap) in grouped {
            if let targetSeries = seriesMap[targetColumn], let value = aggregation(targetSeries) {
                result.append(.double(value))
                labels.append(group.description)
            }
        }

        return Series(name: "\(targetColumn)_agg_by_\(groupColumn)", values: result)
    }
}
