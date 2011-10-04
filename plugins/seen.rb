class Seen
  include Cinch::Plugin
  
  listen_to :channel
  match /seen (\w+)/

  def initialize(*args)
    super
    
    @dataset = DB[:seen]
  end
  
  def join(m, channel)
    create_or_update_user(m)
  end
  
  def listen(m)
    create_or_update_user(m)
  end

  def execute(m, nick)
    if nick == @bot.nick
      m.reply "That's me!"
    elsif nick == m.user.nick
      m.reply "That's you!"
    elsif (user = @dataset.filter(:nick => nick).first)
      
      day = user[:when].strftime("%A, %B %d, %Y")
      time = user[:when].strftime("%I:%M%p")
      
      m.reply "The last time I saw #{nick} was in #{user[:channel]} on #{day} at #{time}."
    else
      m.reply "I haven't seen #{nick}."
    end
  end
  
  private
  def create_or_update_user(m)
    user = @dataset.filter(:nick => m.user.nick).first
    
    if user
      puts "[Seen] Updating user seen information for #{m.user.nick}\n"
      user.update(:channel => m.channel.name, :when => Time.now)
    else
      puts "[Seen] Create new user seen information for #{m.user.nick}\n"
      @dataset.insert(:nick => m.user.nick, :channel => m.channel.name, :when => Time.now)
    end
  end
end