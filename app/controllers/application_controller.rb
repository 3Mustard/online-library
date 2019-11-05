class ApplicationController < Sinatra::Base

    #set's up the location of views and enables the use of sessions
    configure do 
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, 'library_secrets'
    end 

    #set's the root directory to home.erb
    get '/' do 
        erb :home
    end 

    #Helper methods!!
    helpers do 
        #returns true if a user is logged in
        def logged_in? 
            !!current_user
        end

        #returns an instance of a user object whose email matches the session email set in login
        def current_user 
            @current_user ||= User.find_by(:id => session[:user_id]) if session[:user_id] #if there is a session id then find the user who has the same id
        end 
        
        #if a user object can be found by email and the password can be authenticated then the session id is set to the user's id
        def login(email, password)
            user = User.find_by(:email => email)
            if user && user.authenticate(password)
                session[:user_id] = user.id
            else 
                redirect '/login'
            end 
        end 

        #clears the current session
        def logout
            session.clear 
            redirect '/'
        end 
    end 
end  
