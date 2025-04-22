//
//  GroupBy.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 21.04.2025.
//

// Sources/SwiftFrame/Analysis/GroupBy.swift

import Foundation

public extension DataFrame {

    /// Belirli bir kolona göre gruplama yapar ve istatistik döner
    func groupBy(_ column: String, aggregations: [String: (Series) -> DataType]) -> DataFrame {
        guard let groupColumn = columns[column] else { return self }

        var groupedValues: [DataType: [Int]] = [:]

        for (i, value) in groupColumn.values.enumerated() {
            groupedValues[value, default: []].append(i)
        }

        var resultColumns: [String: [DataType]] = [:]
        resultColumns[column] = Array(groupedValues.keys)

        for (aggCol, aggFunc) in aggregations {
            var values: [DataType] = []

            for indices in groupedValues.values {
                let series = Series(name: aggCol, values: indices.compactMap { columns[aggCol]?.values[$0] })
                values.append(aggFunc(series))
            }

            resultColumns[aggCol] = values
        }

        let final = resultColumns.mapValues { Series(name: $0.first?.description ?? "", values: $0) }
        return DataFrame(columns: final)
    }
}
