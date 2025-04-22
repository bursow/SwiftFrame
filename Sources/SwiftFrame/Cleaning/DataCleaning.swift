//
//  DataCleaning.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 22.04.2025.
//

// Sources/SwiftFrame/Cleaning/DataCleaning.swift


import Foundation

public extension DataFrame {

    /// Tüm duplicate satırları kaldırır
    mutating func dropDuplicates() {
        let rowCount = shape().rows
        var seen: Set<String> = []
        var keep: [Bool] = Array(repeating: true, count: rowCount)

        for i in 0..<rowCount {
            var rowStr = ""
            for col in columns.values {
                rowStr += (col[i]?.description ?? "null") + "|"
            }
            if seen.contains(rowStr) {
                keep[i] = false
            } else {
                seen.insert(rowStr)
            }
        }

        for (key, var series) in columns {
            series.values = series.values.enumerated().compactMap { keep[$0.offset] ? $0.element : nil }
            columns[key] = series
        }
    }

    /// Belirli kolonları normalize eder (min-max)
    mutating func normalize(columns targetCols: [String]) {
        for colName in targetCols {
            guard var series = columns[colName] else { continue }
            let nums = series.values.compactMap { $0.toDouble() }
            guard let min = nums.min(), let max = nums.max(), max != min else { continue }

            for i in 0..<series.values.count {
                if let val = series.values[i].toDouble() {
                    let norm = (val - min) / (max - min)
                    series.values[i] = .double(norm)
                }
            }
            columns[colName] = series
        }
    }

    /// Belirli kolonlardan outlier (aykırı değer) temizler (Z-score > threshold)
    mutating func dropOutliers(from column: String, threshold: Double = 3.0) {
        guard let series = columns[column] else { return }
        let values = series.values
        let numeric = values.compactMap { $0.toDouble() }
        guard let mean = numeric.average(), let std = numeric.standardDeviation(), std > 0 else { return }

        var keep: [Bool] = []
        for val in values {
            if let v = val.toDouble() {
                let z = abs((v - mean) / std)
                keep.append(z <= threshold)
            } else {
                keep.append(true)
            }
        }

        for (key, var s) in columns {
            s.values = s.values.enumerated().compactMap { keep[$0.offset] ? $0.element : nil }
            columns[key] = s
        }
    }

    /// Tüm temizlik adımlarını tek seferde yapar
    mutating func clean(dropNA: Bool = false, dropOutliers: [String] = [], normalize: [String] = [], dropDuplicates: Bool = false, zThreshold: Double = 3.0) {
        if dropNA {
            self.dropna()
        }
        for col in dropOutliers {
            self.dropOutliers(from: col, threshold: zThreshold)
        }
        self.normalize(columns: normalize)
        if dropDuplicates {
            self.dropDuplicates()
        }
    }
}

// Ek: Yardımcı istatistik uzantıları
extension Array where Element == Double {
    func average() -> Double? {
        guard !self.isEmpty else { return nil }
        return self.reduce(0, +) / Double(self.count)
    }

    func standardDeviation() -> Double? {
        guard let mean = self.average(), self.count > 1 else { return nil }
        let variance = self.reduce(0) { $0 + pow($1 - mean, 2) } / Double(self.count)
        return sqrt(variance)
    }
}

