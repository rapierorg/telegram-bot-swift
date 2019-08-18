import Darwin
import Foundation
import Yaml
import Rapier

private func main() throws -> Int32 {
    guard CommandLine.arguments.count == 3 else {
        print("Usage: rapier <yaml path> <output path>")
        return 1
    }
    let rapier = Rapier(ymlFile: CommandLine.arguments[1])
    
    try rapier.parseYml()
    
    let generator = TelegramBotSDKGenerator(directory: CommandLine.arguments[2])
    try rapier.generate(generator: generator)
    
    return 0
}

do {
    exit(try main())
} catch {
    print(error.localizedDescription)
    exit(1)
}
