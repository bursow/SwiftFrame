// NDArray.swift
// SwiftFrame → SwiftNum Modülü (N-Dimensional Support)

import Foundation

public enum DType: String {
    case float64
    case float32
    case int32
    case int64
    case bool
}

public struct NDArray {
    public var data: [Double]
    public var shape: [Int]
    public var strides: [Int]
    public var dtype: DType

    public init(_ data: [Double], shape: [Int], dtype: DType = .float64) {
        precondition(shape.reduce(1, *) == data.count, "Veri ile boyut eşleşmiyor")
        self.data = data
        self.shape = shape
        self.strides = NDArray.computeStrides(shape)
        self.dtype = dtype
    }

    /// Eleman sayısı
    public var count: Int {
        return data.count
    }

    /// N-dimensional subscript
    public subscript(_ indices: Int...) -> Double {
        get { self[indices] }
        set { self[indices] = newValue }
    }

    /// Ana erişim noktası
    public subscript(_ indices: [Int]) -> Double {
        get {
            let flatIndex = linearIndex(indices)
            return data[flatIndex]
        }
        set {
            let flatIndex = linearIndex(indices)
            data[flatIndex] = newValue
        }
    }

    /// Flat index hesaplayıcı
    private func linearIndex(_ indices: [Int]) -> Int {
        precondition(indices.count == shape.count, "Boyut sayısı eşleşmiyor")
        return zip(indices, strides).map(*).reduce(0, +)
    }

    /// Yeni shape ile yeniden boyutlandır (reshape)
    public func reshape(_ newShape: [Int]) -> NDArray {
        precondition(newShape.reduce(1, *) == count, "Yeni boyutlar veriyle eşleşmiyor")
        return NDArray(data, shape: newShape, dtype: dtype)
    }

    /// NDArray -> 1D array
    public func flatten() -> [Double] {
        return data
    }

    /// Transpose: sadece 2D matris için (ileride genel versiyonu yazılabilir)
    public func transpose() -> NDArray {
        precondition(shape.count == 2, "Transpose sadece 2D destekli")
        let rows = shape[0], cols = shape[1]
        var transposed = [Double](repeating: 0.0, count: data.count)

        for i in 0..<rows {
            for j in 0..<cols {
                transposed[j * rows + i] = self[[i, j]]
            }
        }

        return NDArray(transposed, shape: [cols, rows], dtype: dtype)
    }

    /// 2D özel erişim
    public subscript(row: Int, col: Int) -> Double {
        get { self[[row, col]] }
        set { self[[row, col]] = newValue }
    }

    /// Yardımcı: shape -> strides
    public static func computeStrides(_ shape: [Int]) -> [Int] {
        var strides = [Int](repeating: 1, count: shape.count)
        for i in (0..<(shape.count - 1)).reversed() {
            strides[i] = strides[i + 1] * shape[i + 1]
        }
        return strides
    }

    /// Dönüştür: farklı dtype'a çevir
    public func astype(_ dtype: DType) -> NDArray {
        let newData: [Double]
        switch dtype {
        case .float64:
            newData = data
        case .float32:
            newData = data.map { Double(Float($0)) }
        case .int32:
            newData = data.map { Double(Int32($0)) }
        case .int64:
            newData = data.map { Double(Int64($0)) }
        case .bool:
            newData = data.map { $0 != 0 ? 1.0 : 0.0 }
        }
        return NDArray(newData, shape: shape, dtype: dtype)
    }

    /// Gerçek tipli array olarak dön
    public func toTypedArray<T>() -> [T] {
        switch dtype {
        case .float64:
            return data as? [T] ?? []
        case .float32:
            return data.map { Float($0) } as? [T] ?? []
        case .int32:
            return data.map { Int32($0) } as? [T] ?? []
        case .int64:
            return data.map { Int64($0) } as? [T] ?? []
        case .bool:
            return data.map { $0 != 0 } as? [T] ?? []
        }
    }
}

