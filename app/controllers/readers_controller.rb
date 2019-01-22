class ReadersController < ApplicationController

  get '/login' do
    erb :'/readers/login'
  end

  post '/login' do
    if params[:username].empty? || params[:password].empty?
      redirect '/login'
    end

    @reader = Reader.find_by(username: params[:username])

    if @reader && @reader.authenticate(params[:password])
      session[:user_id] = @user.id
      erb :'/books/index'
    else
      redirect '/login'
    end

  end

  get '/signup' do
    erb :'/readers/signup'
  end

  post '/signup' do

    if params[:username].empty? || params[:username] == nil
      redirect '/signup'
    end

    Reader.all.each do |reader|
      if reader.username == params[:username]
        redirect '/signup'
      end
      if reader.slug == params[:name].downcase.tr(' ', '-')
        redirect '/signup'
      end
    end

    if params[:community] == nil && params[:new_community].empty?
      redirect '/signup'
    end

    if !params[:new_community].empty?
      Community.all.each do |community|
        if community.slug == params[:new_community].downcase.tr(' ', '-')
            redirect '/signup'
        end
      end
    end

    @reader = Reader.create(name: params[:name], email: params[:email], username: params[:username], password: params[:password])

    if params[:community] == nil
      @reader.community = Community.create(name: params[:new_community])
    else
      @reader.community = Community.find(params[:community])
    end

    @reader.save
    session[:user_id] = @reader.id

    redirect '/books'
  end

  get '/readers/logout' do
    session.clear
    erb :'/readers/login'
  end

  get '/readers' do
    if logged_in?
      erb :'/readers/index'
    else
      redirect '/login'
    end
  end

  get '/readers/:slug' do
    if logged_in?
      @reader = Reader.find_by_slug(params[:slug])
      erb :'/readers/show'
    else
      redirect '/login'
    end
  end

  get '/readers/:slug/edit' do
    if !logged_in?
      redirect '/login'
    end

    if Reader.find_by_slug(params[:slug]) != current_user
      redirect '/readers'
    end

    @reader = Reader.find_by_slug(params[:slug])
    erb :'/readers/edit'

  end

  patch '/readers/:slug/edit' do
    if !logged_in?
      redirect '/login'
    end

    if Reader.find_by_slug(params[:slug]) != current_user
      redirect '/readers'
    end

    @reader = current_user

    if current_user.username != params[:username]

      if Reader.find_by(username: params[:username])
        redirect '/readers'
      end

      if params[:username].empty?
        redirect '/readers'
      end

      @reader.username = params[:username]
    end

    if current_user.name != params[:name]
      Reader.all.each do |reader|
        if reader.slug == params[:name].downcase.tr(' ', '-')
          redirect '/readers'
        end
      end

      if params[:name].empty?
        redirect '/readers'
      end
      @reader.name = params[:name]
    end

    if params[:new_community].empty? && params[:community] == nil
      redirect '/readers'
    end

    if params[:new_community].empty?
      @reader.community = Community.find(params[:community])
    else
      @reader.community = Community.create(name: params[:new_community])
    end
    @reader.save
    erb :'readers/index'

  end

  delete '/readers/:slug/delete' do
    if !logged_in?
      redirect '/login'
    end

    if Reader.find_by_slug(params[:slug]) != current_user
      redirect '/readers'
    end

    reader = Reader.find_by_slug(params[:slug])
    session.clear
    reader.delete
    redirect '/login'

  end
end
