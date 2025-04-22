//
//  Pivot.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 22.04.2025.
//

// Sources/SwiftFrame/Analysis/Pivot.swift

import Foundation

public extension DataFrame {

    /// Pivot işlemi: index değerine göre, belirli bir kolonu sütuna çevirir
    func pivot(index: String, columns: String, values: String, agg: (Series) -> DataType) -> DataFrame {
        guard let indexSeries = self[index],
              let colSeries = self[columns],
              let valSeries = self[values] else {
            return self
        }

        // Benzersiz index ve kolon değerlerini al
        let uniqueIndex = indexSeries.unique()
        let uniqueCols = colSeries.unique()

        var pivotDict: [DataType: [DataType: [DataType]]] = [:] // index → column → [values]

        for i in 0..<indexSeries.count() {
            let idxVal = indexSeries[i] ?? .null
            let colVal = colSeries[i] ?? .null
            let val = valSeries[i] ?? .null
            pivotDict[idxVal, default: [:]][colVal, default: []].append(val)
        }

        var finalColumns: [String: Series] = [:]
        finalColumns[index] = Series(name: index, values: uniqueIndex)

        for col in uniqueCols {
            var seriesData: [DataType] = []
            for idx in uniqueIndex {
                let values = pivotDict[idx]?[col] ?? []
                let s = Series(name: "temp", values: values)
                seriesData.append(agg(s))
            }
            finalColumns[col.asString] = Series(name: col.asString, values: seriesData)
        }

        return DataFrame(columns: finalColumns)
    }
}
