#helper methods located in application_controller.rb

class BooksController < ApplicationController

    get '/books' do 
        "a list of the users books"
    end 

    #render a new book form if the user is logged in
    get '/books/new' do 
        if !logged_in?
            redirect '/login' 
        else
            "new post form" #render form erb :''
        end 
    end  

    #renders an edit form if the post belongs to the user and they are logged in
    get '/books/:id/edit' do 
        if !logged_in? 
            redirect '/login' 
        else 
            if book = current_user.books.find_by(params[:id])
                "edit form"
            else 
                redirect '/books'
            end 
        end     
    end
end 