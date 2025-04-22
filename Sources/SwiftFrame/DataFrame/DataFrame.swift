//
//  DataFrame.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 22.04.2025.
//

import Foundation

public struct DataFrame {
    public var columns: [String: Series]

    public init(columns: [String: Series]) {
        self.columns = columns
    }

    public func column(_ name: String) -> Series? {
        columns[name]
    }

    public subscript(_ name: String) -> Series? {
        columns[name]
    }

    public func shape() -> (rows: Int, columns: Int) {
        guard let first = columns.first else { return (0, 0) }
        return (first.value.count(), columns.count)
    }

    public func describe() -> [String: String] {
        var summary: [String: String] = [:]
        for (key, series) in columns {
            if let mean = series.mean() {
                summary[key] = "Mean: \(mean)"
            } else {
                summary[key] = "Non-numeric"
            }
        }
        return summary
    }
}


public extension DataFrame {
    
    /// Kolon isimleri
    var columnNames: [String] {
        Array(columns.keys)
    }

    /// DataFrame boş mu?
    var isEmpty: Bool {
        columns.isEmpty || columns.values.first?.isEmpty ?? true
    }
}
