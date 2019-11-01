class ApplicationController < Sinatra::Base

    configure do 
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, 'library_secrets'
    end 

    get '/' do 
        "Hello World" #set home page
    end 

    helpers do 
        #returns true if a user is logged in
        def logged_in? 
            !!current_user
        end

        #returns an instance of a user object whose email matches the session email set in login
        def current_user 
            @current_user ||= User.find_by(:email => session[:email]) if session[:email] #if there is a session email then find the user by email and store it in instance variable
        end 
        
        #if a user object can be found by email and the password can be authenticated then the session email is set to that email.
        def login(email, password)
            user = User.find_by(:email => email)
            if user && user.authenticate(password)
                session[:email] = user.email 
            else 
                redirect '/login'
            end 
        end 

        #clears the current session
        def logout
            session.clear 
        end 
    end 
end  