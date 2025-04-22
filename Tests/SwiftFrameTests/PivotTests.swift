//
//  PivotTests.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 22.04.2025.
//
import XCTest
@testable import SwiftFrame

final class PivotTests: XCTestCase {

    func testSimplePivotWithSum() {
        let df = DataFrame(columns: [
            "department": Series(name: "department", values: [
                .string("HR"), .string("HR"), .string("IT"), .string("IT")
            ]),
            "month": Series(name: "month", values: [
                .string("Jan"), .string("Feb"), .string("Jan"), .string("Feb")
            ]),
            "sales": Series(name: "sales", values: [
                .double(9000), .double(7000), .double(12000), .double(8000)
            ])
        ])

        let pivoted = df.pivot(index: "department", columns: "month", values: "sales") {
            .double($0.sum() ?? 0.0)
        }

        guard let departments = pivoted["department"]?.values else {
            XCTFail("department kolonuna ulaşılamadı")
            return
        }

        for (i, dept) in departments.enumerated() {
            if dept == .string("HR") {
                XCTAssertEqual(pivoted["Jan"]?[i], .double(9000))
                XCTAssertEqual(pivoted["Feb"]?[i], .double(7000))
            } else if dept == .string("IT") {
                XCTAssertEqual(pivoted["Jan"]?[i], .double(12000))
                XCTAssertEqual(pivoted["Feb"]?[i], .double(8000))
            } else {
                XCTFail("Beklenmeyen department: \(dept)")
            }
        }
    }
}
