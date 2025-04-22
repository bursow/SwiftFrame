//
//  NDArray+Random.swift
//  SwiftFrame
//
//


import Foundation

public extension NDArray {

    /// Belirli shape’e sahip rastgele [0,1) dağılımında dizi
    static func random(shape: [Int]) -> NDArray {
        let count = shape.reduce(1, *)
        let values = (0..<count).map { _ in Double.random(in: 0..<1) }
        return NDArray(values, shape: shape)
    }

    /// Belirli shape’e sahip normal dağılımlı (Gauss) dizi
    static func randomNormal(shape: [Int], mean: Double = 0.0, std: Double = 1.0) -> NDArray {
        let count = shape.reduce(1, *)
        var result = [Double](repeating: 0.0, count: count)
        // var seed: UInt64 = UInt64(Date().timeIntervalSince1970)

        for i in 0..<count {
            // Box-Muller dönüşümü
            let u1 = Double.random(in: 0..<1)
            let u2 = Double.random(in: 0..<1)
            let z = sqrt(-2.0 * log(u1)) * cos(2.0 * .pi * u2)
            result[i] = z * std + mean
        }

        return NDArray(result, shape: shape)
    }

    /// Belirli shape’e sahip [low, high) aralığında uniform rastgele dizi
    static func randomUniform(shape: [Int], low: Double = 0.0, high: Double = 1.0) -> NDArray {
        let count = shape.reduce(1, *)
        let values = (0..<count).map { _ in Double.random(in: low..<high) }
        return NDArray(values, shape: shape)
    }
}
