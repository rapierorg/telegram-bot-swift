import Foundation

public struct TypeInfo {
    public init(fields: [String: FieldInfo] = [:]) {
        self.fields = fields
    }
    
    public var fields: [String: FieldInfo]
}
