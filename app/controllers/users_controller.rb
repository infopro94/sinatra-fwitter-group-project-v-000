require 'pry'

class UsersController < ApplicationController

	   get '/users/:slug' do
    	 @user = User.find_by_slug(params[:slug])
    	 erb :'users/show'
  	 end

  	get '/signup' do
  		if logged_in?
  			redirect to "/tweets"
  		else
        erb :'users/create', locals: {message: "Please sign up to sign in"}
  		end
	   end


    post '/signup' do
    	if params[:username] == "" || params[:email] == "" || params[:password] == "" 
    		redirect to "/signup"
          
    	else
          # @user = User.create(params)
          # @user.save
          #  session[:id]  = @user.id
          redirect to "/tweets"
    	end
  	end

  	get '/login' do
  		if !logged_in?
  			erb :'users/login'
  		else
  			redirect to '/tweets'
  		end
  	end

  	post '/login' do
  		   # @user = User.find_by(params[:username])
  		if !logged_in?
        redirect to '/signup'
      else 
        user && user.authenticate(params[:password])
  			session[:user_id] = user.id
  			redirect to '/tweets'
  		end
  	end

    get '/logout' do
    	if logged_in?
    		session.destroy
    		redirect to '/login'
    	else
    		redirect to '/'
        end
    end

end

