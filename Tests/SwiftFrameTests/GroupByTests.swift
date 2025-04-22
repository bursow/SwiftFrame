//
//  GroupByTests.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 22.04.2025.
//

import XCTest
@testable import SwiftFrame

final class GroupByTests: XCTestCase {

    func testGroupByWithMeanAndCount() {
        let df = DataFrame(columns: [
            "gender": Series(name: "gender", values: [
                .string("male"), .string("female"), .string("male"), .string("female"), .string("male")
            ]),
            "salary": Series(name: "salary", values: [
                .double(5000), .double(4700), .double(5500), .double(4600), .double(4500)
            ]),
            "age": Series(name: "age", values: [
                .int(30), .int(25), .int(40), .int(27), .int(35)
            ])
        ])

        let grouped = df.groupBy("gender", aggregations: [
            "salary": { series in
                series.mean().map { .double($0) } ?? .null
            },
            "age": { series in
                .int(series.count())
            }
        ])

        let genderValues = grouped["gender"]?.values
        let salaryValues = grouped["salary"]?.values
        let ageCounts = grouped["age"]?.values

        XCTAssertEqual(genderValues?.count, 2)
        XCTAssertTrue(genderValues?.contains(.string("male")) ?? false)
        XCTAssertTrue(genderValues?.contains(.string("female")) ?? false)

        if let idxMale = genderValues?.firstIndex(of: .string("male")) {
            if case let .double(salary) = salaryValues?[idxMale] {
                XCTAssertEqual(salary, 5000.0, accuracy: 0.01) // (5000 + 5500 + 4500) / 3
            }
            XCTAssertEqual(ageCounts?[idxMale], .int(3))
        }

        if let idxFemale = genderValues?.firstIndex(of: .string("female")) {
            if case let .double(salary) = salaryValues?[idxFemale] {
                XCTAssertEqual(salary, 4650.0, accuracy: 0.01) // (4700 + 4600) / 2
            }
            XCTAssertEqual(ageCounts?[idxFemale], .int(2))
        }
    }
}
