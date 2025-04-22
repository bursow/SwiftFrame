// NDArrayManipulationTests.swift
// SwiftNum – Manipulation testleri
// Created by Burhan Söğüt on 22.04.2025.

// NDArrayManipulationTests.swift
// SwiftNum – Manipulation testleri
// Created by Burhan Söğüt on 22.04.2025.

import XCTest
@testable import SwiftFrame

final class NDArrayManipulationTests: XCTestCase {

    func testExpandDims() {
        let array = NDArray.ones(shape: [2, 3])
        let expanded = array.expandDims(at: 1)
        XCTAssertEqual(expanded.shape, [2, 1, 3])
        XCTAssertEqual(expanded[1, 0, 2], 1.0)
    }

    func testSqueeze() {
        let array = NDArray.ones(shape: [1, 3, 1, 4])
        let squeezed = array.squeeze()
        XCTAssertEqual(squeezed.shape, [3, 4])
        XCTAssertEqual(squeezed[[2, 3]], 1.0)
    }

    func testPermute() {
        let array = NDArray.arange(start: 0, end: 6).reshape([2, 3])
        let permuted = array.permute([1, 0])
        XCTAssertEqual(permuted.shape, [3, 2])
        XCTAssertEqual(permuted[[2, 1]], array[[1, 2]])
    }
}
