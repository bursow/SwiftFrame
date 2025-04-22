//
//  SeriesTests.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 22.04.2025.
//

import XCTest
@testable import SwiftFrame

final class SeriesTests: XCTestCase {
    
    func testCountAndUnique() {
        let series = Series(name: "numbers", values: [.int(1), .int(2), .int(1), .int(3)])
        XCTAssertEqual(series.count(), 4)
        XCTAssertEqual(Set(series.unique()), Set([.int(1), .int(2), .int(3)]))
    }

    func testSubscriptAccess() {
        let series = Series(name: "letters", values: [.string("a"), .string("b"), .string("c")])
        XCTAssertEqual(series[0], .string("a"))
        XCTAssertEqual(series[2], .string("c"))
        XCTAssertNil(series[10])
    }

    func testFirstLastIsEmpty() {
        let series = Series(name: "test", values: [.bool(true), .bool(false)])
        XCTAssertFalse(series.isEmpty)
        XCTAssertEqual(series.first, .bool(true))
        XCTAssertEqual(series.last, .bool(false))
    }

    func testContains() {
        let series = Series(name: "test", values: [.string("apple"), .string("banana")])
        XCTAssertTrue(series.contains(.string("banana")))
        XCTAssertFalse(series.contains(.string("grape")))
    }

    func testMapAndCompactMap() {
        let series = Series(name: "numbers", values: [.int(1), .int(2), .int(3)])
        
        let doubled = series.map { .int(($0.toInt() ?? 0) * 2) }
        XCTAssertEqual(doubled.values, [.int(2), .int(4), .int(6)])

        let filtered = series.compactMap { $0.toInt() == 2 ? nil : $0 }
        XCTAssertEqual(filtered.values, [.int(1), .int(3)])
    }

    func testAsStrings() {
        let series = Series(name: "mixed", values: [.int(1), .bool(false), .null])
        XCTAssertEqual(series.asStrings, ["1", "false", "null"])
    }
}
