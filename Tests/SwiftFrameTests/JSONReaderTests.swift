//
//  JSONReaderTests.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 22.04.2025.
//

import XCTest
@testable import SwiftFrame

final class JSONReaderTests: XCTestCase {

    func testFromJSONDictionary() {
        let json: [String: [Any]] = [
            "name": ["Ali", "Ayşe", "Can"],
            "age": [24, 30, 28],
            "income": [3500.0, 4200.5, NSNull()]
        ]

        let df = DataFrame.fromJSON(json)

        XCTAssertEqual(df.shape().rows, 3)
        XCTAssertEqual(df.shape().columns, 3)

        XCTAssertEqual(df["name"]?[0], .string("Ali"))
        XCTAssertEqual(df["age"]?[1], .int(30))
        XCTAssertEqual(df["income"]?[2], .null)
    }

    func testLoadJSONFromLocalFile() {
        // Bu test gerçek bir dosya üzerinden yapılabilir ama burada örnek simülasyon yapıyoruz
        let jsonString = """
        {
            "name": ["Zeynep", "Ahmet"],
            "score": [90, 85]
        }
        """
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("test.json")

        do {
            try jsonString.data(using: .utf8)?.write(to: tempURL)
            let df = DataFrame.loadJSON(from: tempURL)
            XCTAssertNotNil(df)
            XCTAssertEqual(df?.shape().rows, 2)
            XCTAssertEqual(df?["score"]?[0], .int(90))
        } catch {
            XCTFail("JSON write/load error: \(error)")
        }
    }
}
