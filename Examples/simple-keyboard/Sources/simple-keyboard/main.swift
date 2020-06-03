import Foundation
import TelegramBotSDK

let token = readToken(from: "SIMPLE_KEYBOARD_TOKEN")
let bot = TelegramBot(token: token)
var router = Router(bot: bot)
let e = InlineKeyboardButton(text: "Englist",callbackData: "e")
let f = InlineKeyboardButton(text: "Français", callbackData: "f")
let c = InlineKeyboardButton(text: "中文",callbackData: "c")

func onCallbackQueryc(context: Context) -> Bool {
    let markup = InlineKeyboardMarkup(inlineKeyboard: [[e,f]])

    if let _ = context.update.callbackQuery {
        context.bot.editMessageTextAsync(
            chatId: ChatId.chat(context.fromId!),
            messageId: context.message?.messageId,
            text: "这是中文",
            replyMarkup: ReplyMarkup.inlineKeyboardMarkup(markup)
        )
    }else{
        context.respondAsync("这是中文", replyMarkup: ReplyMarkup.inlineKeyboardMarkup(markup))
    }
    return true
}

func onCallbackQuerye(context: Context) -> Bool {
    let markup = InlineKeyboardMarkup(inlineKeyboard: [[c,f]])

    context.bot.editMessageTextAsync(
        chatId: ChatId.chat(context.fromId!),
        messageId: context.message?.messageId,
        text: "This is English",
        replyMarkup: ReplyMarkup.inlineKeyboardMarkup(markup)
    )
    return true
}

func onCallbackQueryf(context: Context) -> Bool {
    let markup = InlineKeyboardMarkup(inlineKeyboard: [[e,c]])

    context.bot.editMessageTextAsync(
        chatId: ChatId.chat(context.fromId!),
        messageId: context.message?.messageId,
        text: "C'est du français.",
        replyMarkup: ReplyMarkup.inlineKeyboardMarkup(markup)
    )
    return true
}

router["start"] = onCallbackQueryc
router[.callback_query(data: "c")] = onCallbackQueryc
router[.callback_query(data: "e")] = onCallbackQuerye
router[.callback_query(data: "f")] = onCallbackQueryf

while let update = bot.nextUpdateSync() {
    try router.process(update: update)
}


fatalError("Server stopped due to error: \(String(describing: bot.lastError))")
