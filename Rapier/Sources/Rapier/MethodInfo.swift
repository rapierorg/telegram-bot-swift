import Foundation

public struct MethodInfo {
    public init(parameters: [String: FieldInfo] = [:], result: FieldInfo) {
        self.parameters = parameters
        self.result = result
    }
    
    public var parameters: [String: FieldInfo]
    public var result: FieldInfo
}
