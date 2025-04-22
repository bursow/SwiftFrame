// NDArray+Manipulation.swift
// SwiftNum – Tensor boyut dönüşümleri (permute, expandDims, squeeze)
// Created by Burhan Söğüt on 19.04.2025.

import Foundation

public extension NDArray {

    /// Boyut sırasını değiştirir (ör: [0,2,1])
    func permute(_ axes: [Int]) -> NDArray {
        precondition(axes.count == shape.count, "Tüm boyutlar belirtilmeli")

        let newShape = axes.map { shape[$0] }
        let newStrides = NDArray.computeStrides(newShape)

        var newData = [Double](repeating: 0.0, count: data.count)
        let indexCount = data.count

        for flatIndex in 0..<indexCount {
            let originalIndices = unravelIndex(flatIndex, shape: shape)
            let permutedIndices = axes.map { originalIndices[$0] }
            let newFlat = zip(permutedIndices, newStrides).map(*).reduce(0, +)
            newData[newFlat] = data[flatIndex]
        }

        return NDArray(newData, shape: newShape)
    }

    /// Yeni boyut ekler (ör: [2,3] -> [2,1,3])
    func expandDims(at axis: Int) -> NDArray {
        var newShape = shape
        newShape.insert(1, at: axis)
        return NDArray(data, shape: newShape)
    }

    /// 1 olan boyutları kaldırır (ör: [1,3,1,4] -> [3,4])
    func squeeze() -> NDArray {
        let newShape = shape.filter { $0 != 1 }
        return NDArray(data, shape: newShape)
    }

    /// Flat index → N boyutlu index
    private func unravelIndex(_ flatIndex: Int, shape: [Int]) -> [Int] {
        var result = [Int](repeating: 0, count: shape.count)
        var remainder = flatIndex
        for i in (0..<shape.count).reversed() {
            result[i] = remainder % shape[i]
            remainder /= shape[i]
        }
        return result
    }
}

