#load an enviroment 
require_relative './config/enviroment'

use Rack::MethodOverride
use SessionsController
use BooksController
use UsersController
run ApplicationController