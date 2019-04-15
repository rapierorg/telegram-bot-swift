import Foundation

protocol CodeGenerator {
    init(directory: String)
    
    func start() throws
    
    func beforeGeneratingTypes() throws
    func generateType(name: String, info: TypeInfo) throws
    func afterGeneratingTypes() throws
    
    func beforeGeneratingMethods() throws
    func generateMethod(name: String, info: MethodInfo) throws
    func afterGeneratingMethods() throws

    func finish() throws
}

struct FieldInfo {
    var type: String
    var isArray: Bool
    var isOptional: Bool
}

struct TypeInfo {
    var fields: [String: FieldInfo] = [:]
}

struct MethodInfo {
    var parameters: [String: FieldInfo] = [:]
}
