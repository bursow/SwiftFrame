//
//  Statistics.swift
//  SwiftFrame
//
//

import Accelerate
import Foundation


extension Series {
    
    public func mean() -> Double? {
        let doubles = values.compactMap { $0.toDouble() }
        guard !doubles.isEmpty else { return nil }
        var result: Double = 0
        vDSP_meanvD(doubles, 1, &result, vDSP_Length(doubles.count))
        return result
    }
    
    public func sum() -> Double? {
        let doubles = values.compactMap { $0.toDouble() }
        return doubles.reduce(0, +)
    }
    
    public func min() -> Double? {
        let doubles = values.compactMap { $0.toDouble() }
        return doubles.min()
    }
    
    public func max() -> Double? {
        let doubles = values.compactMap { $0.toDouble() }
        return doubles.max()
    }
    
    public func median() -> Double? {
        let doubles = values.compactMap { $0.toDouble() }.sorted()
        guard !doubles.isEmpty else { return nil }
        let mid = doubles.count / 2
        if doubles.count % 2 == 0 {
            return (doubles[mid - 1] + doubles[mid]) / 2.0
        } else {
            return doubles[mid]
        }
    }
    
    public func standardDeviation() -> Double? {
        let doubles = values.compactMap { $0.toDouble() }
        guard !doubles.isEmpty else { return nil }

        var mean: Double = 0
        vDSP_meanvD(doubles, 1, &mean, vDSP_Length(doubles.count))

        var meanArray = [Double](repeating: mean, count: doubles.count)
        var deviations = [Double](repeating: 0.0, count: doubles.count)

        // x - mean
        vDSP_vsubD(meanArray, 1, doubles, 1, &deviations, 1, vDSP_Length(doubles.count))

        var squares = [Double](repeating: 0.0, count: doubles.count)
        vDSP_vsqD(deviations, 1, &squares, 1, vDSP_Length(doubles.count))

        var variance: Double = 0
        vDSP_meanvD(squares, 1, &variance, vDSP_Length(doubles.count))

        return sqrt(variance)
    }
}

