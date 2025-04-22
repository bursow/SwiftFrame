

// NDArrayCreatorsTests.swift
// SwiftNum – Oluşturucu fonksiyon testleri
// Created by Burhan Söğüt on 22.04.2025.

import XCTest
@testable import SwiftFrame

final class NDArrayCreatorsTests: XCTestCase {

    func testZeros() {
        let z = NDArray.zeros(shape: [2, 2])
        XCTAssertEqual(z.shape, [2, 2])
        XCTAssertEqual(z.flatten(), [0, 0, 0, 0])
    }

    func testOnes() {
        let o = NDArray.ones(shape: [3])
        XCTAssertEqual(o.shape, [3])
        XCTAssertEqual(o.flatten(), [1, 1, 1])
    }

    func testArange() {
        let r = NDArray.arange(start: 0, end: 5)
        XCTAssertEqual(r.shape, [5])
        XCTAssertEqual(r.flatten(), [0, 1, 2, 3, 4])

        let s = NDArray.arange(start: 1, end: 5, step: 2)
        XCTAssertEqual(s.flatten(), [1, 3])
    }
}
