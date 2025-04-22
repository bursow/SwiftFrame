// NDArrayOperatorTests.swift
// SwiftNum – Operatör testleri
// Created by Burhan Söğüt on 22.04.2025.

import XCTest
@testable import SwiftFrame

final class NDArrayOperatorsTests: XCTestCase {

    func testElementwiseAddSubMulDiv() {
        let a = NDArray.ones(shape: [2, 2])
        let b = NDArray.ones(shape: [2, 2]) * 2.0

        let sum = a + b
        let diff = b - a
        let prod = a * b
        let div = b / a

        XCTAssertEqual(sum.flatten(), [3,3,3,3])
        XCTAssertEqual(diff.flatten(), [1,1,1,1])
        XCTAssertEqual(prod.flatten(), [2,2,2,2])
        XCTAssertEqual(div.flatten(), [2,2,2,2])
    }

    func testScalarOperations() {
        let a = NDArray.ones(shape: [3])
        let plus = a + 5.0
        let mul = a * 3.0

        XCTAssertEqual(plus.flatten(), [6,6,6])
        XCTAssertEqual(mul.flatten(), [3,3,3])
    }
}

