//
//  CSVWriterTests.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 22.04.2025.
//

import XCTest
@testable import SwiftFrame

final class CSVWriterTests: XCTestCase {
    
    func testExportToCSV() {
        let df = DataFrame(columns: [
            "name": Series(name: "name", values: [.string("Ali"), .string("Ayşe")]),
            "age": Series(name: "age", values: [.int(25), .int(30)]),
            "income": Series(name: "income", values: [.double(4000.5), .null])
        ])
        
        let csv = df.toCSV()
        let lines = csv.components(separatedBy: .newlines).filter { !$0.isEmpty }

        // ✅ Header sırasına takılmadan test et
        let header = lines.first?.components(separatedBy: ",").sorted()
        XCTAssertEqual(header, ["name", "age", "income"].sorted())

        // ✅ Satır sayısı
        XCTAssertEqual(lines.count, 3)

        // ✅ İçerik kontrol
        XCTAssertTrue(lines[1].contains("Ali"))
        XCTAssertTrue(lines[2].contains("Ayşe"))
        XCTAssertTrue(lines[2].contains("null") || lines[2].split(separator: ",").count == 3)
    }
}
