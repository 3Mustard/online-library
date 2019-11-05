#helper methods located in application_controller.rb

class BooksController < ApplicationController
    
    #render index of all the suer books
    get '/books/index' do
      if !logged_in?
        redirect '/login'
      else
        @books = current_user.books.all #should grab all the books belonging to the current user but need to check. might not need .all
        erb :'/books/index'
      end 
    end

    #render a new book form if the user is logged in
    get '/books/new' do
        if !logged_in?
            redirect '/login'
        else
            erb :'/books/new'
        end
    end

    post '/books/new' do
        @book = Book.new(:title => params[:title], :author => params[:author]) #creates a new book object
        @book.user = current_user #associates the book to the current user
        @book.save
        redirect "/books/#{@book.id}"
    end

    get '/books/:id' do
        @book = current_user.books.find_by_id(params[:id]) #finds the book by id
        if @book.user == current_user #checks if the book entry belongs to the current user
            erb :'/books/show'
        else
            "error"
        end
    end

    #renders an edit form if the post belongs to the user and they are logged in
    get '/books/:id/edit' do
        if !logged_in?
            redirect '/login'
        else
            if @book = current_user.books.find_by(params[:id])
                erb :'/books/edit'
            else
                redirect '/books/index'
            end
        end
    end
    
    patch '/books/:id' do
      @book = Book.find_by_id(params[:id])
      @book.title = params[:title]
      @book.author = params[:author]
      @book.save
      redirect "/books/#{@book.id}"
    end
    
    delete 'books/:id' do
      @book = Book.find_by_id(params[:id])
      @book.delete
      redirect '/books/index'
    end
end
