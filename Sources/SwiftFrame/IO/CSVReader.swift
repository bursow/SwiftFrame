//
//  CSVReader.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 22.04.2025.
//

import Foundation

public class CSVReader {
    /// CSV metnini `DataFrame`e dönüştürür
    public static func read(from content: String, delimiter: Character = ",") -> DataFrame {
        let lines = content.components(separatedBy: .newlines).filter { !$0.isEmpty }
        guard let headerLine = lines.first else { return DataFrame(columns: [:]) }
        
        let headers = headerLine.split(separator: delimiter).map { String($0) }
        var seriesDict: [String: [DataType]] = [:]
        for header in headers {
            seriesDict[header] = []
        }

        for line in lines.dropFirst() {
            let values = line.split(separator: delimiter, omittingEmptySubsequences: false)
            for (index, value) in values.enumerated() where index < headers.count {
                let str = String(value)
                let casted: DataType =
                    Int(str).map { .int($0) } ??
                    Double(str).map { .double($0) } ??
                    (str.lowercased() == "true" || str.lowercased() == "false" ? .bool(str == "true") : nil) ??
                    (str.isEmpty ? .null : .string(str))
                seriesDict[headers[index]]?.append(casted)
            }
        }

        var finalSeries: [String: Series] = [:]
        for (key, values) in seriesDict {
            finalSeries[key] = Series(name: key, values: values)
        }

        return DataFrame(columns: finalSeries)
    }
}
