//
//  DataFrame+TransfromTests.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 22.04.2025.
//

import XCTest
@testable import SwiftFrame

final class DataFrameTransformTests: XCTestCase {

    func testAstypeToString() {
        var df = DataFrame(columns: [
            "age": Series(name: "age", values: [.int(25), .int(30)])
        ])

        df.astype("age", to: "string")

        XCTAssertEqual(df["age"]?[0], .string("25"))
        XCTAssertEqual(df["age"]?[1], .string("30"))
    }

    func testFillna() {
        var df = DataFrame(columns: [
            "income": Series(name: "income", values: [.double(5000), .null, .double(3000)])
        ])

        df.fillna(column: "income", with: .double(0.0))

        XCTAssertEqual(df["income"]?[1], .double(0.0))
    }

    func testDropna() {
        var df = DataFrame(columns: [
            "name": Series(name: "name", values: [.string("Ali"), .null, .string("Ayşe")]),
            "age": Series(name: "age", values: [.int(25), .int(30), .null])
        ])

        df.dropna()

        XCTAssertEqual(df.shape().rows, 1)
        XCTAssertEqual(df["name"]?[0], .string("Ali"))
    }

    func testReplace() {
        var df = DataFrame(columns: [
            "city": Series(name: "city", values: [.string("Ankara"), .string("İstanbul"), .string("Ankara")])
        ])

        df.replace(column: "city", old: .string("Ankara"), new: .string("Bursa"))

        XCTAssertEqual(df["city"]?[0], .string("Bursa"))
        XCTAssertEqual(df["city"]?[2], .string("Bursa"))
    }
}
