require 'discordrb'

bot = Discordrb::Commands::CommandBot.new token: 'MjkxNjkyMTU5OTk4ODg1ODk5.C6tcuw.lLpfQMk4fs1zFg6qPMXERSNiiKo', client_id: 160123456789876543, prefix: '~'

bot.command :hello do |event|
  event << 'Welcome :heart: Hell'
end

fortune_verb = ["kill", "tackle", "smoosh", "hug", "clean", "purify", "love", "fight", "explode", "find", "pray", "sing", "grow", "hide", "bounce","read"]
fortune_adj = ["sparkly","angel","devil","rainbow","crystal","brave","pretty","weird","ugly","fat","spooky","ancient","new","squishy","dirty","smart"] 
fortune_noun = ["gold","knight","ghost","box","song","sword","ghost","love","imp","card","cummie","nerd","orb","potion","wizard","princess","power"]

bot.command :fortune do |event|
  event << "You will #{fortune_verb.sample} #{fortune_adj.sample} #{fortune_noun.sample}."
end

bot.run
