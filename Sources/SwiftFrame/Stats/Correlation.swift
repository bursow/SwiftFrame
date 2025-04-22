//
//  Correlation.swift
//  SwiftFrame
//
//

import Foundation

public extension DataFrame {
    func correlation() -> [String: [String: Double]] {
        let numericColumns = columns.filter { (_, series) in
            series.values.allSatisfy { $0.isNumeric || $0.isNull }
        }

        let names = Array(numericColumns.keys)
        var matrix: [String: [String: Double]] = [:]

        for i in 0..<names.count {
            let nameA = names[i]
            let valuesA = numericColumns[nameA]!.values.compactMap { $0.toDouble() }

            matrix[nameA] = [:]
            for j in 0..<names.count {
                let nameB = names[j]
                let valuesB = numericColumns[nameB]!.values.compactMap { $0.toDouble() }

                let corr = pearson(x: valuesA, y: valuesB)
                matrix[nameA]?[nameB] = corr
            }
        }

        return matrix
    }
}

// Yardımcı: Pearson Correlation
private func pearson(x: [Double], y: [Double]) -> Double {
    guard x.count == y.count, x.count > 1 else { return .nan }

    let meanX = x.reduce(0, +) / Double(x.count)
    let meanY = y.reduce(0, +) / Double(y.count)

    let numerator = zip(x, y).reduce(0.0) { $0 + ($1.0 - meanX) * ($1.1 - meanY) }
    let denominatorX = x.reduce(0.0) { $0 + pow($1 - meanX, 2) }
    let denominatorY = y.reduce(0.0) { $0 + pow($1 - meanY, 2) }

    let denominator = sqrt(denominatorX * denominatorY)
    return denominator == 0 ? .nan : numerator / denominator
}
