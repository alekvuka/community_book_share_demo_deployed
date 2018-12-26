class ReadersController < ApplicationController

  get '/login' do
    erb :'/readers/login'
  end

  post '/login' do

  end

  get '/signup' do
    erb :'/readers/signup'
  end

  post '/signup' do
    binding.pry
    @reader = Reader.create(name: params[:name], email: params[:email], username: params[:username])

    if params[:community] == nil
      @reader.community = Community.create(name: params[:new_community])
    else
      @reader.community = Community.find_by(name: params[:community])
    end

    @reader.save
    sessions[:id] = @reader.id

    redirect '/books'

  end




end
