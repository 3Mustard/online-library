#load an enviroment 
require_relative './config/enviroment'

use Rack::MethodOverride
run ApplicationController