class ReadersController < ApplicationController

  get '/login' do
    erb :'/readers/login'
  end

  post '/login' do
    if params[:username].empty? || params[:password].empty?
      redirect '/login'
    end

    @user = Reader.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      erb :'/books/index'
    else
      redirect '/login'
    end

  end

  get '/signup' do
    erb :'/readers/signup'
  end

  post '/signup' do
    @reader = Reader.create(name: params[:name], email: params[:email], username: params[:username], password: params[:password])

    if params[:community] == nil
      @reader.community = Community.create(name: params[:new_community])
    else
      @reader.community = Community.find_by(name: params[:community])
    end

    @reader.save
    session[:id] = @reader.id

    redirect '/books'

  end

  get '/readers/logout' do
    session.clear
    erb :'/readers/login'
  end

  get '/readers' do
    if session[:id]
      @reader = Reader.find(session[:id])
      erb :'/readers/index'
    else
      redirect '/login'
    end
  end

  get '/readers/:slug' do
    if session[:id]
      @reader = Reader.find_by_slug(params[:slug])
      erb :'/readers/show'
    else
      redirect '/login'
    end
  end

  get '/readers/edit/:slug' do
    if session[:id]
      @reader = Reader.find_by_slug(params[:slug])
      erb :'/readers/edit'
    else
      redirect '/login'
    end
  end

  patch '/readers/edit/:slug' do
    if session[:id]
      @reader = Reader.find(session[:id])
      @reader.name = params[:name]
      @reader.username = params[:username]
      if params[:new_community].empty?
        @reader.community = Community.find(params[:community])
      else
        @reader.community = Community.create(name: params[:new_community])
      end
      @reader.save
      erb :'readers/index'
    else
      redirect '/login'
    end
  end


  delete '/readers/delete/:slug' do
    if session[:id]
      reader = Reader.find_by_slug(params[:slug])
      reader.delete
      redirect '/logout'
    else
      redirect '/login'
    end
  end
end
