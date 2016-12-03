import XCTest
@testable import TelegramBotTests

XCTMain([
     testCase(BlockingServerTests.allTests),
     testCase(RequestTests.allTests),
     testCase(RouterTests.allTests),
     testCase(TelegramBotTests.allTests),
     testCase(UrlencodeTests.allTests),
])
