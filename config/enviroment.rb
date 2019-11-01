require 'bundler'

Bundler.require

#establish database connection 
ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "db/development.sqlite"
)

require_all 'app'