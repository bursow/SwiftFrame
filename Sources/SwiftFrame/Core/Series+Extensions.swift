//
//  Series+Extensions.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 22.04.2025.
//

// Sources/SwiftFrame/Core/Series+Extensions.swift

import Foundation

public extension Series {
    /// Sütun boş mu?
    var isEmpty: Bool {
        values.isEmpty
    }

    /// İlk değer
    var first: DataType? {
        values.first
    }

    /// Son değer
    var last: DataType? {
        values.last
    }

    /// Belirli bir değeri içeriyor mu?
    func contains(_ value: DataType) -> Bool {
        values.contains(value)
    }

    /// Tüm değerlerde işlem uygular
    func map(_ transform: (DataType) -> DataType) -> Series {
        Series(name: name + "_mapped", values: values.map(transform))
    }

    /// Nil dönebilecek dönüştürmelerde
    func compactMap(_ transform: (DataType) -> DataType?) -> Series {
        Series(name: name + "_compact", values: values.compactMap(transform))
    }

    /// String'e dönüştürülmüş değer dizisi
    var asStrings: [String] {
        values.map { $0.description }
    }
}
