class BooksController < ApplicationController

  get '/books' do
    erb :'/books/index'
  end

  get '/books/:id' do
    erb :'/books/show'
  end

  get '/books/new' do
    erb :'/books/new'
  end


end
