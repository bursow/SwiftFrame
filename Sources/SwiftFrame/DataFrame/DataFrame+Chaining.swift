//
//  DataFrame+Chaining.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 16.04.2025.
//

// Sources/SwiftFrame/DataFrame/DataFrame+Chaining.swift

import Foundation

public extension DataFrame {

    /// Bir kolondaki her değere fonksiyon uygular (yerine yazar)
    mutating func apply(column: String, transform: (DataType) -> DataType) {
        guard var series = columns[column] else { return }
        for i in 0..<series.values.count {
            series.values[i] = transform(series.values[i])
        }
        columns[column] = series
    }

    /// DataFrame'i zincirleme işlemlerle işler
    func pipe(_ transform: (DataFrame) -> DataFrame) -> DataFrame {
        return transform(self)
    }
}
