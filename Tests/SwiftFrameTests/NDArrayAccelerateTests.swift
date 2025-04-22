// NDArrayAccelerateTests.swift
// SwiftNum – Accelerate performans testleri
// Created by Burhan Söğüt on 22.04.2025.

import XCTest
@testable import SwiftFrame

final class NDArrayAccelerateTests: XCTestCase {

    func testMeanFastMatchesManual() {
        let a = NDArray.arange(start: 0, end: 10)
        let meanFast = a.meanFast()
        let meanManual = a.data.reduce(0, +) / Double(a.data.count)

        XCTAssertEqual(meanFast, meanManual, accuracy: 1e-10)
    }

    func testStdFastMatchesManual() {
        let a = NDArray.arange(start: 1, end: 6) // [1,2,3,4,5]
        let stdFast = a.stdFast()

        let mean = a.data.reduce(0, +) / Double(a.data.count)
        let variance = a.data.map { pow($0 - mean, 2) }.reduce(0, +) / Double(a.data.count)
        let stdManual = sqrt(variance)

        XCTAssertEqual(stdFast, stdManual, accuracy: 1e-10)
    }

    func testDotFast() {
        let a = NDArray.arange(start: 0, end: 6).reshape([2, 3])
        let b = NDArray.ones(shape: [3, 2])

        let result = a.dotFast(b)
        let expected = NDArray([
            0.0 + 1.0 + 2.0, 0.0 + 1.0 + 2.0,
            3.0 + 4.0 + 5.0, 3.0 + 4.0 + 5.0
        ], shape: [2, 2])
        
        XCTAssertEqual(result.data, expected.data)
    }
}

