import Darwin
import Foundation
import Yaml
import Rapier

private func main() throws -> Int32 {
    let rapier = Rapier(ymlFile: "/Users/cipi1965/Downloads/tests/telegram.yml")
    
    try rapier.parseYml()
    
    let generator = OverviewGenerator(directory: "/Users/cipi1965/Downloads/tests/")
    try rapier.generate(generator: generator)
    
    return 0
}

do {
    exit(try main())
} catch {
    print(error.localizedDescription)
    exit(1)
}
