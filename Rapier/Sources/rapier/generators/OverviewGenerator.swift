import Foundation

private struct Context {
    let directory: String

    var outTypes: String = ""
    var outMethods: String = ""
    
    init(directory: String) {
        self.directory = directory
    }
}

class OverviewGenerator: CodeGenerator {
    private var context: Context
    
    required init(directory: String) {
        self.context = Context(directory: directory)
    }
    
    func start() throws {
        
    }
    
    func beforeGeneratingTypes() throws {
        context.outTypes.append("TYPES:\n\n")
    }
    
    func generateType(name: String, info: TypeInfo) throws {
        context.outTypes.append("\(name)\n")
        info.fields.sorted { $0.key < $1.key }.forEach { fieldName, fieldInfo in
            context.outTypes.append("  \(fieldName): \(fieldInfo.type)")
            if (fieldInfo.isOptional) {
                context.outTypes.append(" [optional]")
            }
            context.outTypes.append("\n")
        }
    }
    
    func afterGeneratingTypes() throws {
        context.outTypes.append("\nEND\n")
    }
    
    func beforeGeneratingMethods() throws {
        context.outMethods.append("METHODS:\n\n")
    }
    
    func generateMethod(name: String, info: MethodInfo) throws {
        context.outMethods.append("\(name)\n")
        info.parameters.sorted { $0.key < $1.key }.forEach { fieldName, fieldInfo in
            context.outMethods.append("  \(fieldName): \(fieldInfo.type)")
            if (fieldInfo.isOptional) {
                context.outMethods.append(" [optional]")
            }
            context.outMethods.append("\n")
        }
    }

    func afterGeneratingMethods() throws {
        context.outMethods.append("\nEND\n")
    }
    
    func finish() throws {
        try saveTypes()
        try saveMethods()
    }
}

extension OverviewGenerator {
    private func saveTypes() throws {
        let dir = URL(fileURLWithPath: context.directory, isDirectory: true)
        let file = dir.appendingPathComponent("types.swift", isDirectory: false)
        try context.outTypes.write(to: file, atomically: true, encoding: .utf8)
    }
    
    private func saveMethods() throws {
        let dir = URL(fileURLWithPath: context.directory, isDirectory: true)
        let file = dir.appendingPathComponent("methods.swift", isDirectory: false)
        try context.outMethods.write(to: file, atomically: true, encoding: .utf8)
    }
}
