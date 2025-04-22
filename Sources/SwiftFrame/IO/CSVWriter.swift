//
//  CSVWriter.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 22.04.2025.
//

import Foundation

extension DataFrame {
    /// DataFrame'i CSV formatında string olarak döner
    public func toCSV(delimiter: String = ",") -> String {
        // Header
        let headers = Array(columns.keys)
        var csv = headers.joined(separator: delimiter) + "\n"

        // Satır sayısını belirle
        let rowCount = columns.values.first?.values.count ?? 0

        for i in 0..<rowCount {
            let row = headers.map { col in
                if let value = columns[col]?.values[safe: i] {
                    return value.description.replacingOccurrences(of: delimiter, with: " ")
                } else {
                    return ""
                }
            }
            csv += row.joined(separator: delimiter) + "\n"
        }

        return csv
    }
}
