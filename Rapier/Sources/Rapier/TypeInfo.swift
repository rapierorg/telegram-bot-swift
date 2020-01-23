import Foundation

public struct TypeInfo {
    public init(name: String, fields: [FieldInfo] = []) {
        self.name = name
        self.fields = fields
    }
    
    public var name: String
    public var fields: [FieldInfo]
}
