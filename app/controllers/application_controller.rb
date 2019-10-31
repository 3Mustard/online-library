class ApplicationController < Sinatra::Base

    configure do 
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, 'library_secrets'
    end 

    get '/' do 
        "Hello World"
    end 

    helpers do 
        def logged_in?
            !!session[:email]
        end
        
        def login(email)
            #is the user who they claim they are
            session[:email] = email
        end 

        def logout
            session.clear 
        end 
    end 
end  