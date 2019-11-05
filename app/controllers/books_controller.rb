#helper methods logged_in? and current_user located in application_controller.rb

class BooksController < ApplicationController
    
    #if a user is logged in the index view of all the users books will be rendered
    get '/books/index' do
      if !logged_in? 
        redirect '/login'
      else
        @books = current_user.books.all 
        erb :'/books/index'
      end 
    end

    #if a user is logged in the new book form at books/new.erb is rendered
    get '/books/new' do
        if !logged_in? 
            redirect '/login'
        else
            erb :'/books/new' 
        end
    end

    #handles a form submitted from books/new.erb
    post '/books/new' do
        @book = Book.new(:title => params[:title], :author => params[:author])
        @book.user = current_user #associates the book to the current user 
        @book.save
        redirect "/books/#{@book.id}"
    end

    #if the book belongs to the current user a page displaying the book will be rendered.
    get '/books/:id' do
        @book = Book.find_by_id(params[:id])
        if @book.user == current_user 
            erb :'/books/show'
        else
            "error"
        end
    end

    #renders an edit form if the book belongs to the current user
    get '/books/:id/edit' do
        @book = Book.find_by_id(params[:id])
        if @book.user == current_user
            erb :'/books/edit'       
        else
            redirect '/books/index'
        end
    end
    
    #handles a post from books/edit.erb by updating the values of a Book object
    patch '/books/:id' do
      @book = Book.find_by_id(params[:id])
      @book.title = params[:title]
      @book.author = params[:author]
      @book.save
      redirect "/books/#{@book.id}"
    end

    #sends user to a confirm delete page
    get '/books/:id/delete' do
        @book = Book.find_by_id(params[:id])
        erb :'/books/delete'
    end 
    
    #handles a delete request from books/delete.erb
    delete '/books/:id' do
      @book = Book.find_by_id(params[:id])
      @book.delete
      redirect '/books/index'
    end
end
