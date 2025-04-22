//
//  DataFrame+CombineTests.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 22.04.2025.
//

import XCTest
@testable import SwiftFrame

final class DataFrameCombineTests: XCTestCase {

    func testConcatRows() {
        let df1 = DataFrame(columns: [
            "name": Series(name: "name", values: [.string("Ali")]),
            "age": Series(name: "age", values: [.int(25)])
        ])

        let df2 = DataFrame(columns: [
            "name": Series(name: "name", values: [.string("Ayşe")]),
            "age": Series(name: "age", values: [.int(30)])
        ])

        let combined = df1.concatRows(with: df2)
        XCTAssertEqual(combined.shape().rows, 2)
        XCTAssertEqual(combined["name"]?[1], .string("Ayşe"))
    }

    func testConcatColumns() {
        let df1 = DataFrame(columns: [
            "name": Series(name: "name", values: [.string("Ali"), .string("Ayşe")])
        ])

        let df2 = DataFrame(columns: [
            "age": Series(name: "age", values: [.int(25), .int(30)])
        ])

        let combined = df1.concatColumns(with: df2)
        XCTAssertEqual(combined.shape().columns, 2)
        XCTAssertEqual(combined["age"]?[1], .int(30))
    }

    func testJoin() {
        let df1 = DataFrame(columns: [
            "id": Series(name: "id", values: [.int(1), .int(2), .int(3)]),
            "name": Series(name: "name", values: [.string("Ali"), .string("Ayşe"), .string("Can")])
        ])

        let df2 = DataFrame(columns: [
            "id": Series(name: "id", values: [.int(2), .int(3)]),
            "score": Series(name: "score", values: [.int(90), .int(85)])
        ])

        let joined = df1.join(with: df2, on: "id")

        XCTAssertEqual(joined.shape().rows, 2)
        XCTAssertEqual(joined["name"]?[0], .string("Ayşe"))
        XCTAssertEqual(joined["score_right"]?[1], .int(85))
    }
}
