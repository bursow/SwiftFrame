//
//  PlotKitTests.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 22.04.2025.
//

// Tests/SwiftFrameTests/PlotTests.swift

import XCTest
import SwiftUI
@testable import SwiftFrame

final class PlotTests: XCTestCase {

    func testBasicPlotGeneration() {
        let df = DataFrame(columns: [
            "month": Series(name: "month", values: [
                .string("Jan"), .string("Feb"), .string("Mar")
            ]),
            "sales": Series(name: "sales", values: [
                .double(1000), .double(1500), .double(1200)
            ])
        ])

        let view = df.plot(PlotOptions(x: "month", y: "sales", kind: .bar))
        XCTAssertNotNil(view) // View oluşturulmalı
    }

    func testPlotMultipleView() {
        let df = DataFrame(columns: [
            "month": Series(name: "month", values: [
                .string("Jan"), .string("Feb"), .string("Mar")
            ]),
            "income": Series(name: "income", values: [
                .double(3000), .double(3500), .double(3200)
            ]),
            "expenses": Series(name: "expenses", values: [
                .double(2000), .double(1800), .double(2100)
            ])
        ])

        let view = df.plotMultiple(
            x: "month",
            y: ["income", "expenses"],
            kind: .line,
            title: "Income vs Expenses"
        )

        XCTAssertNotNil(view) // View render edilmeli
    }
}
