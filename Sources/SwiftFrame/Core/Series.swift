// Sources/SwiftFrame/Core/Series.swift

public struct Series {
    public let name: String
    public var values: [DataType]

    public init(name: String, values: [DataType]) {
        self.name = name
        self.values = values
    }

    public func count() -> Int {
        values.count
    }

    public func unique() -> [DataType] {
        Array(Set(values))
    }

    public subscript(index: Int) -> DataType? {
        guard index >= 0 && index < values.count else { return nil }
        return values[index]
    }
}
