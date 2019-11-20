#helper methods located in application_controller.rb

class SessionsController < ApplicationController

    #renders the login page
    get '/login' do 
        erb :'sessions/login'
    end 

    #set's session/logs a user in via helper method - login
    post '/sessions' do 
        login(params[:email], params[:password])
        redirect "/books"
    end 

    #clears the session/logs the user out via helper method - logout  
    get '/logout' do 
        logout
    end 
end 
