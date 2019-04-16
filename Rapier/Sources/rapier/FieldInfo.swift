import Foundation

public struct FieldInfo {
    public init(type: String = "", isArray: Bool = false, isOptional: Bool = false) {
        self.type = type
        self.isArray = isArray
        self.isOptional = isOptional
    }
    
    public var type: String
    public var isArray: Bool
    public var isOptional: Bool
}
