require "rubygems"
require "bundler/setup"

require 'cinch'
require 'sequel'

# Load in all plugins
Dir[File.dirname(__FILE__) + '/plugins/*.rb'].each { |f| require f }

# Load the database
DB = Sequel.sqlite 'bot.db'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.sorcery.net"
    c.channels = ["#kolth"]
    
    c.nick = "acdevbot"
    c.verbose = true
    
    c.plugins.plugins = [Seen]
  end
end

bot.start