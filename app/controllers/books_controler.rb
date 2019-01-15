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
    if session[:id]
      book = Book.find_by_slug(params[:slug])
      book.rating = book.add_new_rating(params[:rating].to_f)
      book.save
      erb :'books/index'
    else
      redirect '/login'
    end
  end

  get '/books/edit/:slug' do
    if session[:id]
      @book = Book.find_by_slug(params[:slug])
      erb :'/books/edit'
    else
      redirect '/login'
    end
  end

  patch '/books/edit/:slug' do
    if session[:id]
      book = Book.find_by_slug(params[:slug])

      if !params[:name].empty?
        book.name = params[:name]
      end
      if !params[:author].empty?
        book.author = params[:author]
      end
      if !params[:description].empty?
        book.description = params[:description]
      end
      if !params[:comments].empty?
        book.comments = params[:comments]
      end
      book.save
      redirect '/books'
    else
      redirect '/login'
    end

  end

  delete '/books/delete/:slug' do
    if session[:id]
      book = Book.find(session[:id])
      book.delete
      redirect '/books'
    else
      redirect '/login'
    end
  end

end
