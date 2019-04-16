import Foundation

public struct MethodInfo {
    public init(parameters: [String: FieldInfo] = [:]) {
        self.parameters = parameters
    }
    
    public var parameters: [String: FieldInfo]
}
