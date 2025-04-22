//
//  CSVReaderTest.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 22.04.2025.
//

import XCTest
@testable import SwiftFrame

final class CSVReaderTests: XCTestCase {
    func testBasicCSVParsing() {
        let csv = """
        name,age,income
        John,30,4000.5
        Alice,25,3500
        Bob,28,
        """

        let df = CSVReader.read(from: csv)
        
        // Shape test
        XCTAssertEqual(df.shape().rows, 3)
        XCTAssertEqual(df.shape().columns, 3)

        // Mean test
        let ageMean = df["age"]?.mean()
        XCTAssertNotNil(ageMean)
        XCTAssertEqual(ageMean!, 27.666666666666668, accuracy: 0.001)

        // Null detection test
        let income = df["income"]
        XCTAssertEqual(income?.values[2], .null)

        // Unique value test
        let names = df["name"]
        let uniqueNames = names?.unique()
        XCTAssertEqual(uniqueNames?.count, 3)
    }
}
