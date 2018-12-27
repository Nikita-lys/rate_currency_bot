require 'telegram/bot'
require 'nokogiri'
require 'open-uri'
require 'date'

TOKEN = '771018612:AAE6YylyBVHFPP3OxVU6HsgFpVrmyLvw3sg'

usd = Nokogiri::HTML(open('http://bhom.ru/currencies/usd/?startdate=alltime')).xpath('//span[@id="currency-today"]').map {|x| x.text()}
eur = Nokogiri::HTML(open('http://bhom.ru/currencies/eur/')).xpath('//span[@id="currency-today"]').map {|x| x.text()}
grivna = Nokogiri::HTML(open('http://bhom.ru/currencies/uah/')).xpath('//span[@id="currency-today"]').map {|x| x.text()}
pounds = Nokogiri::HTML(open('http://bhom.ru/currencies/gbp/')).xpath('//span[@id="currency-today"]').map {|x| x.text()}
yen = Nokogiri::HTML(open('http://bhom.ru/currencies/jpy/')).xpath('//span[@id="currency-today"]').map {|x| x.text()}
teng = Nokogiri::HTML(open('http://bhom.ru/currencies/kzt/')).xpath('//span[@id="currency-today"]').map {|x| x.text()}
yuan = Nokogiri::HTML(open('http://bhom.ru/currencies/cny/')).xpath('//span[@id="currency-today"]').map {|x| x.text()}

a = Time.now
puts(a.hour.to_s + ":" + a.min.to_s)
now = a.day.to_s + "." + a.month.to_s + "." + a.year.to_s

#loop do
  begin
    Telegram::Bot::Client.run(TOKEN) do |bot|
      bot.listen do |message|
        Thread.start(message) do |message|
          answers = Telegram::Bot::Types::ReplyKeyboardMarkup.new(keyboard: ['Курс', 'Доллар', 'Евро'], one_time_keyboard: true)

          case message.text
          when '/start', '/start start'
            bot.api.send_message(chat_id: message.chat.id, text: "Здравствуй, #{message.from.first_name}" +
                ". Я - бот, который выводит курс валют. \nДостаточно написать мне \"Курс\".", reply_markup: answers)

          when 'Курс'
            bot.api.send_message(
                chat_id: message.chat.id,
                text: "Текущий курс на " + now + "\nДоллар США: \t\t\t\t\t\t\t\t\t\t\t" + usd.to_s.split('"')[1] +
                      "\nЕвро: \t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t" + eur.to_s.split('"')[1] +
                      "\nУкраинская гривна: " + grivna.to_s.split('"')[1] +
                      "\nФунт стерлингов: \t\t\t\t" + pounds.to_s.split('"')[1] +
                      "\nЯпонская иена: \t\t\t\t\t\t\t\t" + yen.to_s.split('"')[1] +
                      "\nКазахский тенге: \t\t\t\t\t" + teng.to_s.split('"')[1] +
                      "\nКитайский юань: \t\t\t\t\t" + yuan.to_s.split('"')[1],
                reply_markup: answers)
          when 'Доллар'
            bot.api.send_message(
                chat_id: message.chat.id,
                text: "Курс на " + now + "\nДоллар: \t" + usd.to_s.split('"')[1],
                reply_markup: answers)
          when 'Евро'
            bot.api.send_message(
                chat_id: message.chat.id,
                text: "Курс на " + now + "\nЕвро: \t\t\t\t\t\t" + eur.to_s.split('"')[1],
                reply_markup: answers)
          end
        end
          # rescue
          #   puts "RESCUE PRCSNG"
          # end
      end
    end
  end
#end

