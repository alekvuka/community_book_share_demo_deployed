class BooksController < ApplicationController

  get '/books' do
    if session[:id]
      @reader = Reader.find(session[:id])
      erb :'/books/index'
    else
      erb :'/readers/login'
    end
  end

  get '/books/new' do
    
    if session[:id]
      erb :'/books/new'
    else
      erb :'/login'
    end
  end

  get '/books/:id' do
    if session[:id]
      @reader = Reader.find(session[:id])
      erb :'/books/show'
    else
      erb :'/readers/login'
    end
  end

end
