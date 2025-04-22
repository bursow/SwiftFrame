//
//  Describe.swift
//  SwiftFrame
//
//

// Sources/SwiftFrame/Stats/Describe.swift

import Foundation

public extension DataFrame {

    /// Tüm sayısal kolonlar için özet istatistikleri döner
    func describe(detailed: Bool = false) -> [String: [String: DataType]] {
        var result: [String: [String: DataType]] = [:]

        for (colName, series) in columns {
            var stats: [String: DataType] = [:]
            if let mean = series.mean() { stats["mean"] = .double(mean) }
            if let min = series.min() { stats["min"] = .double(min) }
            if let max = series.max() { stats["max"] = .double(max) }
            if let std = series.standardDeviation() { stats["std"] = .double(std) }
            if let median = series.median() { stats["median"] = .double(median) }
            stats["count"] = .int(series.count())
            stats["nulls"] = .int(series.values.filter { $0.isNull }.count)
            stats["unique"] = .int(series.unique().count)

            if detailed {
                stats["first"] = series.first ?? .null
                stats["last"] = series.last ?? .null
            }

            result[colName] = stats
        }

        return result
    }
}
