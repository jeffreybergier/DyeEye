
import ActivityKit
import WidgetKit

public struct Attributes: ActivityAttributes {
    public var name: String
    public init(name: String) {
        self.name = name
    }
}

extension Attributes {
    public struct ContentState: Codable, Hashable {
        public var value: Int
        public init(value: Int) {
            self.value = value
        }
    }
}
