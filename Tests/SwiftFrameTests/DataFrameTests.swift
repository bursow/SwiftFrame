//
//  DataFrameTests.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 22.04.2025.
//

import XCTest
@testable import SwiftFrame

final class DataFrameTests: XCTestCase {

    func testAddAndDropColumn() {
        var df = DataFrame(columns: [:])
        df.addColumn(name: "age", values: [.int(25), .int(30), .int(28)])
        
        XCTAssertNotNil(df["age"])
        XCTAssertEqual(df["age"]?.count(), 3)

        df.dropColumn(name: "age")
        XCTAssertNil(df["age"])
    }

    func testRenameColumn() {
        var df = DataFrame(columns: [
            "income": Series(name: "income", values: [.double(3000), .double(4000)])
        ])
        
        df.renameColumn(from: "income", to: "salary")
        XCTAssertNil(df["income"])
        XCTAssertNotNil(df["salary"])
        XCTAssertEqual(df["salary"]?.name, "salary")
    }

    func testShapeAndColumnNames() {
        let df = DataFrame(columns: [
            "name": Series(name: "name", values: [.string("Ali"), .string("Ayşe")]),
            "age": Series(name: "age", values: [.int(22), .int(24)])
        ])
        
        let shape = df.shape()
        XCTAssertEqual(shape.rows, 2)
        XCTAssertEqual(shape.columns, 2)
        XCTAssertEqual(Set(df.columnNames), Set(["name", "age"]))
        XCTAssertFalse(df.isEmpty)
    }

    func testRowAccess() {
        let df = DataFrame(columns: [
            "name": Series(name: "name", values: [.string("Ali"), .string("Veli")]),
            "age": Series(name: "age", values: [.int(25), .int(30)])
        ])
        
        let row0 = df.row(at: 0)
        XCTAssertEqual(row0?["name"], .string("Ali"))
        XCTAssertEqual(row0?["age"], .int(25))

        let all = df.rows
        XCTAssertEqual(all.count, 2)
        XCTAssertEqual(all[1]["name"], .string("Veli"))
    }
}
