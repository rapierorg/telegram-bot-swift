import Foundation
import Yaml

open class Rapier {
    public let ymlFile: String
    
    private var types: [String: TypeInfo] = [:]
    private var methods: [String: MethodInfo] = [:]
    
    public init(ymlFile: String) {
        self.ymlFile = ymlFile
    }
    
    public func clear() {
        types = [:]
        methods = [:]
    }
    
    public func generate(generator: CodeGenerator) throws {
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
    
    public func parseYml() throws {
        let data = try String(contentsOfFile: self.ymlFile)
        
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
        guard let result = props["result"]?.string else { throw RapierError.missingReturn(parent: methodName)}
        
        let resultField = parseType(field: result)
        
        guard let fieldsDictionary = props["parameters"]?.dictionary else {
            methods[methodName] = MethodInfo(parameters: [:], result: resultField)
            return
        }
        let fields = try parseFields(fieldsDictionary, parent: methodName)
        let methodInfo = MethodInfo(parameters: fields, result: resultField)
        methods[methodName] = methodInfo
    }
    
    private func parseFields(_ fieldsDictionary: [Yaml: Yaml], parent: String) throws -> [String: FieldInfo] {
        var fields: [String: FieldInfo] = [:]
        try fieldsDictionary.forEach { key, value in
            guard let fieldName = key.string else { throw RapierError.fieldNameIsNotString(parent: parent) }
            guard let fieldType = value.string else { throw RapierError.fieldTypeIsNotString(parent: parent) }
            
            fields[fieldName] = parseType(field: fieldType)
        }
        return fields
    }
    
    private func parseType(field: String) -> FieldInfo {
        var fieldType = field
        let isOptional = fieldType.hasSuffix("?")
        if isOptional {
            fieldType = String(fieldType.dropLast())
        }
        
        let isArray = fieldType.hasSuffix("[]")
        if isArray {
            fieldType = String(fieldType.dropLast(2))
        }
        
        return FieldInfo(type: fieldType, isArray: isArray, isOptional: isOptional)
    }
}
