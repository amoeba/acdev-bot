require 'sequel'

namespace :db do
  task :create do
    DB = Sequel.sqlite "bot.db"
    
    DB.create_table :seen do
      primary_key :id
      String  :nick
      String  :channel
      Time    :when
    end
  end
end