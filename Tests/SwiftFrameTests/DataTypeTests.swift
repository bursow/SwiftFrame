//
//  DataTypeTests.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 22.04.2025.
//

import XCTest
@testable import SwiftFrame

final class DataTypeTests: XCTestCase {
    
    func testToDouble() {
        XCTAssertEqual(DataType.int(42).toDouble(), 42.0)
        XCTAssertEqual(DataType.double(3.14).toDouble(), 3.14)
        XCTAssertEqual(DataType.string("2.5").toDouble(), 2.5)
        XCTAssertNil(DataType.string("abc").toDouble())
    }

    func testToInt() {
        XCTAssertEqual(DataType.int(10).toInt(), 10)
        XCTAssertEqual(DataType.double(7.99).toInt(), 7)
        XCTAssertEqual(DataType.string("100").toInt(), 100)
        XCTAssertNil(DataType.null.toInt())
    }

    func testToBool() {
        XCTAssertEqual(DataType.bool(true).toBool(), true)
        XCTAssertEqual(DataType.string("true").toBool(), true)
        XCTAssertEqual(DataType.string("yes").toBool(), true)
        XCTAssertEqual(DataType.string("1").toBool(), true)
        XCTAssertEqual(DataType.string("no").toBool(), false)
        XCTAssertNil(DataType.int(1).toBool())
    }

    func testIsNull() {
        XCTAssertTrue(DataType.null.isNull)
        XCTAssertFalse(DataType.string("hi").isNull)
    }

    func testIsNumeric() {
        XCTAssertTrue(DataType.int(5).isNumeric)
        XCTAssertTrue(DataType.double(3.14).isNumeric)
        XCTAssertTrue(DataType.string("42.0").isNumeric)
        XCTAssertFalse(DataType.string("hello").isNumeric)
    }

    func testAsString() {
        XCTAssertEqual(DataType.int(5).asString, "5")
        XCTAssertEqual(DataType.bool(true).asString, "true")
        XCTAssertEqual(DataType.null.asString, "null")
    }
}
