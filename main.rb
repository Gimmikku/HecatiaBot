require 'discordrb'

bot = Discordrb::Commands::CommandBot.new token: 'MjkxNjkyMTU5OTk4ODg1ODk5.C6tcuw.lLpfQMk4fs1zFg6qPMXERSNiiKo', client_id: 160123456789876543, prefix: '~'

bot.command :hello do |event|
  event << 'Welcome :heart: Hell'
end

bot.run
