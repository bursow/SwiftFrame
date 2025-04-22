

// NDArray+Operators.swift
// SwiftNum – Temel işlemler + oluşturucu fonksiyonlar

import Foundation

public extension NDArray {

    // MARK: - Operatörler

    static func +(lhs: NDArray, rhs: NDArray) -> NDArray {
        precondition(lhs.shape == rhs.shape, "Boyutlar eşleşmeli")
        let data = zip(lhs.data, rhs.data).map(+)
        return NDArray(data, shape: lhs.shape)
    }

    static func -(lhs: NDArray, rhs: NDArray) -> NDArray {
        precondition(lhs.shape == rhs.shape, "Boyutlar eşleşmeli")
        let data = zip(lhs.data, rhs.data).map(-)
        return NDArray(data, shape: lhs.shape)
    }

    static func *(lhs: NDArray, rhs: NDArray) -> NDArray {
        precondition(lhs.shape == rhs.shape, "Boyutlar eşleşmeli")
        let data = zip(lhs.data, rhs.data).map(*)
        return NDArray(data, shape: lhs.shape)
    }

    static func /(lhs: NDArray, rhs: NDArray) -> NDArray {
        precondition(lhs.shape == rhs.shape, "Boyutlar eşleşmeli")
        let data = zip(lhs.data, rhs.data).map(/)
        return NDArray(data, shape: lhs.shape)
    }

    static func +(lhs: NDArray, scalar: Double) -> NDArray {
        let data = lhs.data.map { $0 + scalar }
        return NDArray(data, shape: lhs.shape)
    }

    static func *(lhs: NDArray, scalar: Double) -> NDArray {
        let data = lhs.data.map { $0 * scalar }
        return NDArray(data, shape: lhs.shape)
    }

    // MARK: - Oluşturucular

    static func zeros(shape: [Int]) -> NDArray {
        let count = shape.reduce(1, *)
        return NDArray(Array(repeating: 0.0, count: count), shape: shape)
    }

    static func ones(shape: [Int]) -> NDArray {
        let count = shape.reduce(1, *)
        return NDArray(Array(repeating: 1.0, count: count), shape: shape)
    }

    static func arange(start: Double, end: Double, step: Double = 1.0) -> NDArray {
        let values = stride(from: start, to: end, by: step).map { $0 }
        return NDArray(values, shape: [values.count])
    }
}
