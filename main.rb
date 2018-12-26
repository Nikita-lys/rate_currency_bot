require 'telegram/bot'

TOKEN = '771018612:AAEwpf6xMHFLej0EY4L2E9kTXYGur76RPt4'

ANSWERS = [
	"окей",
	"не окей",
	"так себе",
	"ещё один вариант",
	"1234"
]

Telegram::Bot::Client.run(token) do |bot|
	bot.listen do |message|
		case message.text
		when '/start', '/start start'
			bot.api.send_message(
				chat_id: message.chat.id,
				text: "Здравствуй, #{message.from.first_name}"
				)
		else
			bot.api.send_message(
				chat_id: message.chat.id,
				text: ANSWERS.sample
				)
		end
	end
end