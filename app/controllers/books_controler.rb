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
      @book = Book.create(name: params[:name], author: params[:author], description: params[:description], comments: params[:comments])
      @book.owner = Reader.find(session[:id]).id
      @book.number_of_ratings = 0.0
      @book.all_ratings = 0.0
      @book.save
      @book.rating = @book.add_new_rating(params[:rating])
      @book.community_id = Reader.find(session[:id]).community.id
      @book.save
      redirect '/books'
    end
    redirect '/login'
  end

  post '/rate/:slug' do
    book = Book.find_by_slug(:slug)
    book.rating = book.add_new_rating(params[:rating].to_f)
    book.save
    erb :'books/index'
  end

end
