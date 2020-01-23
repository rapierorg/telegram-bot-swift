import Foundation

public struct MethodInfo {
    public init(name: String, parameters: [FieldInfo] = [], result: FieldInfo) {
        self.name = name
        self.parameters = parameters
        self.result = result
    }
    public var name: String
    public var parameters: [FieldInfo]
    public var result: FieldInfo
}
