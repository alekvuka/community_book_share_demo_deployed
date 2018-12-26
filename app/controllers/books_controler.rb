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
      erb :'/readers/login'
    end
  end

  get '/books/:slug' do
    if session[:id]
      @book = Book.find_by_slug(params[:slug])
      erb :'/books/show'
    else
      erb :'/readers/login'
    end
  end

  post '/books' do
    if session[:id]
      if Book.find_by(name: params[:name])
        redirect '/books'
      end
      @book = Book.create(name: params[:name], author: params[:author], description: params[:description])
      @book.owner = Reader.find(session[:id])
      @book.rating = @book.add_new_rating(params[:rating].to_f)
      redirect '/books'
    end
    redirect '/login'
  end
end
