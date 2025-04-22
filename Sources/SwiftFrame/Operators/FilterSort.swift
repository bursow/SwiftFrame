//
//  FilterSory.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 17.04.2025.
//


import Foundation

extension Series {

    public func filter(_ isIncluded: (DataType) -> Bool) -> Series {
        let filteredValues = values.filter(isIncluded)
        return Series(name: self.name + "_filtered", values: filteredValues)
    }

    public func sortAscending() -> Series {
        let sorted = values.sorted(by: { ($0.toDouble() ?? 0) < ($1.toDouble() ?? 0) })
        return Series(name: self.name + "_sorted", values: sorted)
    }

    public func sortDescending() -> Series {
        let sorted = values.sorted(by: { ($0.toDouble() ?? 0) > ($1.toDouble() ?? 0) })
        return Series(name: self.name + "_sortedDesc", values: sorted)
    }

    /// Belirli bir string ile eşleşen değerleri filtreler (case insensitive)
    public func filterString(matching target: String) -> Series {
        let result = values.filter {
            if case let .string(str) = $0 {
                return str.lowercased() == target.lowercased()
            }
            return false
        }
        return Series(name: self.name + "_filtered_\(target)", values: result)
    }

    /// Null olmayan değerleri döndürür
    public func dropNulls() -> Series {
        let filtered = values.filter { $0 != .null }
        return Series(name: self.name + "_nonNull", values: filtered)
    }
}
