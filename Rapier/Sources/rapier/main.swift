import Darwin
import Foundation
import Yaml

var types: [String: TypeInfo] = [:]
var methods: [String: MethodInfo] = [:]

enum RapierError: Error {
    case expectedDictionary
    case unknownSectionType
    case expectedField(name: String, parent: String?)
    case fieldNameIsNotString(parent: String)
    case fieldTypeIsNotString(parent: String)
}

extension RapierError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .expectedDictionary: return "Expected dictionary as top level element"
        case .unknownSectionType: return "Unknown section type"
        case let .expectedField(name, parent):
            if let parent = parent {
                return "'\(parent)': expected field named '\(name)'"
            } else {
                return "Expected field named '\(name)'"
            }
        case let .fieldNameIsNotString(parent):
            return "'\(parent)': field name is not a string"
        case let .fieldTypeIsNotString(parent):
            return "'\(parent)': field type is not a string"
        }
    }
}

private func main() throws -> Int32 {
    try parseYml(file: "/Users/user/Zabiyaka/Software/rapier/tests/telegram.yml")
    
    let generator = TelegramBotSDKGenerator(directory: "/Users/user/Zabiyaka/Software/rapier/tests")
    try generate(generator: generator)
    
    return 0
}

private func generate(generator: CodeGenerator) throws {
    try generator.start()
    
    try generator.beforeGeneratingTypes()
    try types.forEach { typeName, typeInfo in
        try generator.generateType(name: typeName, info: typeInfo)
    }
    try generator.afterGeneratingTypes()
    
    try generator.beforeGeneratingMethods()
    try methods.forEach { methodName, methodInfo in
        try generator.generateMethod(name: methodName, info: methodInfo)
    }
    try generator.afterGeneratingMethods()
    
    try generator.finish()
}

private func parseYml(file: String) throws {
    let data = try String(contentsOfFile: file)
    
    let documents = try Yaml.loadMultiple(data)
    
    try documents.forEach { document in
        guard let props = document.dictionary else { throw RapierError.expectedDictionary }
        if nil != props["format"] {
            try configure(props: props)
        } else if nil != props["type"] {
            try parseType(props: props)
        } else if nil != props["method"] {
            try parseMethod(props: props)
        } else {
            throw RapierError.unknownSectionType
        }
    }
}

private func configure(props: [Yaml: Yaml]) throws {
    
}

private func parseType(props: [Yaml: Yaml]) throws {
    guard let typeName = props["type"]?.string else { throw RapierError.expectedField(name: "type", parent: nil) }
    guard let fieldsDictionary = props["fields"]?.dictionary else {
        types[typeName] = TypeInfo(fields: [:])
        return
    }
    let fields = try parseFields(fieldsDictionary, parent: typeName)
    let typeInfo = TypeInfo(fields: fields)
    types[typeName] = typeInfo
}

private func parseMethod(props: [Yaml: Yaml]) throws {
    guard let methodName = props["method"]?.string else { throw RapierError.expectedField(name: "method", parent: nil) }
    guard let fieldsDictionary = props["parameters"]?.dictionary else {
        methods[methodName] = MethodInfo(parameters: [:])
        return
    }
    let fields = try parseFields(fieldsDictionary, parent: methodName)
    let methodInfo = MethodInfo(parameters: fields)
    methods[methodName] = methodInfo
}

private func parseFields(_ fieldsDictionary: [Yaml: Yaml], parent: String) throws -> [String: FieldInfo] {
    var fields: [String: FieldInfo] = [:]
    try fieldsDictionary.forEach { key, value in
        guard let fieldName = key.string else { throw RapierError.fieldNameIsNotString(parent: parent) }
        guard var fieldType = value.string else { throw RapierError.fieldTypeIsNotString(parent: parent) }
        
        let isOptional = fieldType.hasSuffix("?")
        if isOptional {
            fieldType = String(fieldType.dropLast())
        }
        
        let isArray = fieldType.hasSuffix("[]")
        if isArray {
            fieldType = String(fieldType.dropLast(2))
        }
        
        fields[fieldName] = FieldInfo(type: fieldType, isArray: isArray, isOptional: isOptional)
    }
    return fields
}

do {
    exit(try main())
} catch {
    print(error.localizedDescription)
    exit(1)
}
