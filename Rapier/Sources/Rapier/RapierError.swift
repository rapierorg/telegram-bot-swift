import Foundation

public enum RapierError: Error {
    case expectedDictionary
    case unknownSectionType
    case expectedField(name: String, parent: String?)
    case missingReturn(parent: String)
    case fieldNameIsNotString(parent: String)
    case fieldTypeIsNotString(parent: String)
}

extension RapierError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .expectedDictionary: return "Expected dictionary as top level element"
        case .unknownSectionType: return "Unknown section type"
        case let .expectedField(name, parent):
            if let parent = parent {
                return "'\(parent)': expected field named '\(name)'"
            } else {
                return "Expected field named '\(name)'"
            }
        case let .missingReturn(parent):
            return "'\(parent)': Missing return property"
        case let .fieldNameIsNotString(parent):
            return "'\(parent)': field name is not a string"
        case let .fieldTypeIsNotString(parent):
            return "'\(parent)': field type is not a string"
        }
    }
}
