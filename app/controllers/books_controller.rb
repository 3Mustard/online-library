#helper methods logged_in? and current_user located in application_controller.rb

class BooksController < ApplicationController
    
    #if a user is logged in, the index view of all the users books will be rendered
    get '/books' do
      if !logged_in? 
        redirect '/login'
      else
        @books = current_user.books.all 
        erb :'/books/index'
      end 
    end

    #if a user is logged in, the new book form is rendered
    get '/books/new' do
        if !logged_in? 
            redirect '/login'
        else
            erb :'/books/new' 
        end
    end

    #handles a form submitted from books/new.erb
    post '/books' do 
        @book = current_user.books.build(:title => params[:title], :author => params[:author])
        @book.save
        redirect "/books/#{@book.id}"
    end

    #if the book belongs to the current user a page displaying the book will be rendered.
    get '/books/:id' do
        set_book
        if @book.user == current_user 
            erb :'/books/show'
        else
            "error"
        end
    end

    #renders an edit form if the book belongs to the current user
    get '/books/:id/edit' do
        set_book
        if @book.user == current_user
            erb :'/books/edit'       
        else
            redirect '/books'
        end
    end
    
    #handles a post from books/edit.erb by updating the values of a Book object
    patch '/books/:id' do
        set_book
        @book.title = params[:title]
        @book.author = params[:author]
        @book.save
        redirect "/books/#{@book.id}"
    end

    #sends user to a confirm delete page
    get '/books/:id/delete' do
        set_book
        erb :'/books/delete'
    end 
    
    #handles a delete request
    delete '/books/:id' do
        set_book
        @book.delete
        redirect '/books'
    end

    private 
    
    #returns a book based on it's id
    def set_book 
        @book = Book.find_by_id(params[:id])
    end 
end
