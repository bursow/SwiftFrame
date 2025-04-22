//
//  DescribeTests.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 22.04.2025.
//

import XCTest
@testable import SwiftFrame

final class DescribeTests: XCTestCase {

    func testDescribeDetailed() {
        let df = DataFrame(columns: [
            "value": Series(name: "value", values: [.int(10), .int(20), .int(30)])
        ])

        let summary = df.describe(detailed: true)

        guard let stats = summary["value"] else {
            XCTFail("Kolon bulunamadı")
            return
        }

        XCTAssertEqual(stats["first"], .int(10))
        XCTAssertEqual(stats["last"], .int(30))
        XCTAssertEqual(stats["mean"], .double(20.0))
        XCTAssertEqual(stats["median"], .double(20.0))
    }

}
