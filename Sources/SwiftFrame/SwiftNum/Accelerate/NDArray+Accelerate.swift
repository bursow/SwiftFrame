// NDArray+Accelerate.swift
// SwiftNum – Apple Silicon Hızlandırmalı

import Foundation
import Accelerate

public extension NDArray {

    /// Accelerate ile hızlı matris çarpımı (dot)
    func dotFast(_ other: NDArray) -> NDArray {
        precondition(shape.count == 2 && other.shape.count == 2, "Sadece 2D matrisler destekleniyor")
        precondition(shape[1] == other.shape[0], "İç boyutlar eşleşmeli")

        let m = shape[0]
        let n = shape[1]
        let p = other.shape[1]
        var result = [Double](repeating: 0.0, count: m * p)

        cblas_dgemm(
            CblasRowMajor,
            CblasNoTrans,
            CblasNoTrans,
            Int32(m), Int32(p), Int32(n),
            1.0,
            self.data, Int32(n),
            other.data, Int32(p),
            0.0,
            &result, Int32(p)
        )

        return NDArray(result, shape: [m, p])
    }

    /// Accelerate ile ortalama (mean)
    func meanFast() -> Double {
        var mean = 0.0
        vDSP_meanvD(data, 1, &mean, vDSP_Length(data.count))
        return mean
    }

    /// Accelerate ile standart sapma (std)
    func stdFast() -> Double {
        var mean = 0.0
        var std = 0.0
        var mutableData = data // vDSP istemiyor: immutable + nil

        vDSP_normalizeD(
            &mutableData,
            1,
            nil,
            1,
            &mean,
            &std,
            vDSP_Length(mutableData.count)
        )

        return std
    }
}

