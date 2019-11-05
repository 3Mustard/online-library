class UsersController < ApplicationController 

    #renders a form to sign up
    get '/signup' do 
        erb :'users/signup'
    end 

    #creates a new user if they enter a valid email/password
    post '/newuser' do 
        @user = User.new
        @user.email = params[:email]
        @user.password = params[:password]
        if @user.save
            redirect '/login'
        else 
            erb :'users/signup' #render a view to keep the @user variable. a redirect will lose it!
        end 
    end 
end 
