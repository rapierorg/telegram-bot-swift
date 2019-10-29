//
// Telegram Bot SDK for Swift (unofficial).
//
// This file containing the example code is in public domain.
// Feel free to copy-paste it and edit it in any way you like.
//

import Foundation
import TelegramBotSDK

extension Context {
    var session: Session { return properties["session"] as! Session }
}
