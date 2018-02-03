require './config/environment'
require 'sinatra'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
		enable :sessions
		set :session_secret, "password_security"
  end

    get '/' do
      erb :index
    end


    helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end


    # get '/signup' do
    #     if User.find_by_id(session[:user_id])
    #       redirect :"/tweets"
		  #   else
    #     erb :'/users/create'
    # 	 end
	   # end


   #  post '/signup' do
   #    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
   #    @user.username = params[:username]
   #    @user.email = params[:email]
   #    @user.password = params[:password]
   #      if @user.username != "" && @user.password != "" && @user.email != ""
   #        @user.save
   #        session[:id] = @user.id
   #        redirect :"/tweets"
   #      else
   #        redirect :"/signup"
   #  	end
  	# end

   #  get '/logout' do
   #    session[:id].clear
   #    redirect :'/login'
   #  end
    end
  end
