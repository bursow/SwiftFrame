//
//  PlotKit.swift
//  SwiftFrame
//
//  Created by Burhan Söğüt on 22.04.2025.
//

// Sources/SwiftFrame/Plot/PlotKit.swift


// Sources/SwiftFrame/Plot/PlotKit.swift

import SwiftUI
import Charts

public enum PlotKind {
    case bar
    case line
    case pie
    case area
    case point
}

public struct PlotOptions {
    public var x: String
    public var y: String
    public var kind: PlotKind
    public var title: String?
    public var height: CGFloat

    public init(x: String, y: String, kind: PlotKind = .bar, title: String? = nil, height: CGFloat = 300) {
        self.x = x
        self.y = y
        self.kind = kind
        self.title = title
        self.height = height
    }
}

fileprivate struct PlotPair: Identifiable, Hashable {
    let id = UUID()
    let group: String?
    let x: String
    let y: Double
}

public extension DataFrame {

    /// Tekli kolonlara göre grafik
    func plot(_ options: PlotOptions) -> some View {
        let xData = columns[options.x]?.asStrings ?? []
        let yData = columns[options.y]?.values.compactMap { $0.toDouble() } ?? []
        let pairs = zip(xData, yData).map { PlotPair(group: nil, x: $0.0, y: $0.1) }

        return plotView(pairs: pairs, kind: options.kind, title: options.title, height: options.height)
    }

    /// Çoklu seriler için grafik
    func plotMultiple(x: String, y: [String], kind: PlotKind = .line, title: String? = nil, height: CGFloat = 300) -> some View {
        var allPairs: [PlotPair] = []

        for col in y {
            let xData = columns[x]?.asStrings ?? []
            let yData = columns[col]?.values.compactMap { $0.toDouble() } ?? []
            let pairs = zip(xData, yData).map { PlotPair(group: col, x: $0.0, y: $0.1) }
            allPairs.append(contentsOf: pairs)
        }

        return plotView(pairs: allPairs, kind: kind, title: title, height: height)
    }

    /// Ortak grafik View
    private func plotView(pairs: [PlotPair], kind: PlotKind, title: String?, height: CGFloat) -> some View {
        VStack(alignment: .leading) {
            if let title = title {
                Text(title)
                    .font(.title3.bold())
                    .padding(.horizontal)
            }

            Chart {
                ForEach(pairs) { pair in
                    switch kind {
                    case .bar:
                        BarMark(x: .value("x", pair.x), y: .value("y", pair.y))
                            .foregroundStyle(by: .value("Group", pair.group ?? ""))
                    case .line:
                        LineMark(x: .value("x", pair.x), y: .value("y", pair.y))
                            .foregroundStyle(by: .value("Group", pair.group ?? ""))
                    case .area:
                        AreaMark(x: .value("x", pair.x), y: .value("y", pair.y))
                            .foregroundStyle(by: .value("Group", pair.group ?? ""))
                    case .point:
                        PointMark(x: .value("x", pair.x), y: .value("y", pair.y))
                            .foregroundStyle(by: .value("Group", pair.group ?? ""))
                    case .pie:
                        SectorMark(angle: .value("y", pair.y))
                            .foregroundStyle(by: .value("x", pair.x))
                    }
                }
            }
            .frame(height: height)
            .padding(.horizontal)
        }
    }
}
