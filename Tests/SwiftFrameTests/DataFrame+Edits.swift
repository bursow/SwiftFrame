//
//  DataFrame+Edits.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 22.04.2025.
//

import XCTest
@testable import SwiftFrame

final class DataFrameEditingRowsTests: XCTestCase {

    func testInsertRow() {
        var df = DataFrame(columns: [
            "name": Series(name: "name", values: [.string("Ali")]),
            "age": Series(name: "age", values: [.int(25)])
        ])

        df.insertRow(["name": .string("Ayşe"), "age": .int(30)])
        df.insertRow(["name": .string("Can")]) // age null olmalı

        XCTAssertEqual(df.shape().rows, 3)
        XCTAssertEqual(df["name"]?[2], .string("Can"))
        XCTAssertEqual(df["age"]?[2], .null)
    }

    func testDeleteRow() {
        var df = DataFrame(columns: [
            "name": Series(name: "name", values: [.string("Ali"), .string("Ayşe"), .string("Can")]),
            "age": Series(name: "age", values: [.int(25), .int(30), .int(28)])
        ])

        df.deleteRow(at: 1)

        XCTAssertEqual(df.shape().rows, 2)
        XCTAssertEqual(df["name"]?[0], .string("Ali"))
        XCTAssertEqual(df["name"]?[1], .string("Can"))
    }

    func testUpdateCell() {
        var df = DataFrame(columns: [
            "name": Series(name: "name", values: [.string("Ali"), .string("Ayşe")]),
            "age": Series(name: "age", values: [.int(25), .int(30)])
        ])

        df.updateCell(row: 0, column: "age", value: .int(35))
        XCTAssertEqual(df["age"]?[0], .int(35))
    }
}
