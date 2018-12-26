class ReadersController < ApplicationController

  get '/login' do
    erb :'/readers/login'
  end

  post '/login' do

  end

  get '/signup' do
    erb :'/readers/signup'
  end




end
