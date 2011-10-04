class Quote
  include Cinch::Plugin
  
  listen_to :channel
  match /quote (\d+)/
  
  def initialize(*args)
    super
  end
  
  def listen
    
  end
  
  def execute
    
  end
end