require 'discordrb'
require 'json'

bot = Discordrb::Commands::CommandBot.new token: 'MjkxNjkyMTU5OTk4ODg1ODk5.C6tcuw.lLpfQMk4fs1zFg6qPMXERSNiiKo', client_id: 160123456789876543, prefix: '~'

fortune_verb = ["kill", "tackle", "smoosh", "hug", "clean", "purify", "love", "fight", "explode", "find", "pray", "sing", "grow", "hide", "bounce","read"]
fortune_adj = ["sparkly","angel","devil","rainbow","crystal","brave","pretty","weird","ugly","fat","spooky","ancient","new","squishy","dirty","smart"] 
fortune_noun = ["gold","knight","ghost","box","song","sword","ghost","love","imp","card","cummie","nerd","orb","potion","wizard","princess","power"]

bot.command :fortune do |event|
  event << "You will #{fortune_verb.sample} #{fortune_adj.sample} #{fortune_noun.sample}."
end

bot.command :join do |event|
  if File.exists?("#{event.user.id}.json") # checks if there is already  file that matches the user's id and cancels command if so
    event << "You've already made a character!"
    break
  end
  #creates a hash with the new character's info and writes this into a json file
  newStats = {:id => event.user.id, :name => event.user.name, :hp => 100, :wait => 0}
  makeFile = JSON.pretty_generate(newStats) #generates the JSON object from the ruby hash to be written
  File.open("#{event.user.id}.json", 'w') { |file| file.write(makeFile) } #writes the object to a new file
  event << "Character made."
end

bot.command :status do |event|
  if !File.exists?("#{event.user.id}.json") #checks to see if the matching json character file exists
    event << "You haven't made a character yet!"
    break
  end
  #finds the matching file and reads out its stats to the user
  charFile = File.read("#{event.user.id}.json")
  charStats = JSON.parse(charFile)
  event << "Your name is: " + charStats['name']
  event << "Your HP is: " + charStats['hp'].to_s
  event << "Your WT is: " + charStats['wait'].to_s
end

def check_hp(target) # just a basic function to return someone's hp
  charFile = File.read("#{target}.json")
  charStats = JSON.parse(charFile)
  return charStats['hp']
end

bot.command :suicide do |event|
  if check_hp(event.user.id) <= 0 # checks if the user is dead or not, should probably make this into its own event somehow
    event << "You can't do anything! You're dead!"
    break
  end
  #loads the user's stat file for moification and reduces HP by 50
  charFile = File.read("#{event.user.id}.json")
  charStats = JSON.load(charFile)
  charStats['hp'] -= 50
  File.open("#{event.user.id}.json", 'w') { |file| file.write(charStats.to_json) } 
  event << charStats.to_json
  event << "Ow! You lost 50 HP!"
end

bot.run
