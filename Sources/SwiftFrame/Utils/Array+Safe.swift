//
//  Untitled.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 22.04.2025.
//

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
