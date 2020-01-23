import Foundation
import Yaml

open class Rapier {
    public let ymlFile: String
    
    private var types: [TypeInfo] = []
    private var methods: [MethodInfo] = []
    
    public init(ymlFile: String) {
        self.ymlFile = ymlFile
    }
    
    public func clear() {
        types = []
        methods = []
    }
    
    public func generate(generator: CodeGenerator) throws {
        try generator.start()
        
        try generator.beforeGeneratingTypes()
        try types.forEach { typeInfo in
            try generator.generateType(name: typeInfo.name, info: typeInfo)
        }
        try generator.afterGeneratingTypes()
        
        try generator.beforeGeneratingMethods()
        try methods.forEach { methodInfo in
            try generator.generateMethod(name: methodInfo.name, info: methodInfo)
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
        guard let fieldsArray = props["fields"]?.array else {
            types.append(TypeInfo(name: typeName, fields: []))
            return
        }
        let fields = try parseFields(fieldsArray, parent: typeName)
        let typeInfo = TypeInfo(name: typeName, fields: fields)
        types.append(typeInfo)
    }
    
    private func parseMethod(props: [Yaml: Yaml]) throws {
        guard let methodName = props["method"]?.string else { throw RapierError.expectedField(name: "method", parent: nil) }
        guard let result = props["result"]?.string else { throw RapierError.missingReturn(parent: methodName)}
        
        let resultField = parseType(name: methodName, field: result)
        
        guard let fieldsArray = props["parameters"]?.array else {
            methods.append(MethodInfo(name: methodName, parameters: [], result: resultField))
            return
        }
        let fields = try parseFields(fieldsArray, parent: methodName)
        let methodInfo = MethodInfo(name: methodName, parameters: fields, result: resultField)
        methods.append(methodInfo)
    }
    
    private func parseFields(_ fieldsArray: [Yaml], parent: String) throws -> [FieldInfo] {
        var fields: [FieldInfo] = []
        try fieldsArray.forEach { item in
            guard let field = item.dictionary else {
                throw RapierError.expectedDictionary
            }
            guard let fieldName = field.first?.key.string else { throw RapierError.fieldNameIsNotString(parent: parent) }
            guard let fieldType = field.first?.value.string else { throw RapierError.fieldTypeIsNotString(parent: parent) }
            
            fields.append(parseType(name: fieldName, field: fieldType))
        }
        return fields
    }
    
    private func parseType(name: String, field: String) -> FieldInfo {
        var fieldType = field
        let isOptional = fieldType.hasSuffix("?")
        if isOptional {
            fieldType = String(fieldType.dropLast())
        }
        
        let isArray = fieldType.hasSuffix("[]")
        if isArray {
            fieldType = String(fieldType.dropLast(2))
        }
        
        let isArrayOfArray = fieldType.hasSuffix("[]")
        if isArrayOfArray {
            fieldType = String(fieldType.dropLast(2))
        }
        
        return FieldInfo(name: name, type: fieldType, isArray: isArray, isArrayOfArray: isArrayOfArray, isOptional: isOptional)
    }
}
