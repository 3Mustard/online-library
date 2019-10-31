class BooksController < ApplicationController

    get #users logged in home page do
        #render users profile 
    end 

    get #list of users books do 
        #render index of all books belonging to the user
    end 

    get '/books/new' do 
        #check if they are logged in then send to new book form
        if logged_in?
            #redirect to profile
        else
            redirect '/login'
        end 
    end  

    get '/books/:id/edit' do 
        #check if they are logged in
        #if they are redirect to an edit form
        #if not then back to login
    end
    
    patch do 
    end 

    delete do 
    end 
end 