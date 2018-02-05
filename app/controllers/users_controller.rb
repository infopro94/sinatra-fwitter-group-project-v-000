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
        erb :'/users/create_user', locals: {message: "Please sign up to sign in"}
  		end
	   end


    post '/signup' do
    	if params[:username] == "" || params[:email] == "" || params[:password] == "" 
    		redirect to "/signup"
    	else
         @user = User.create(params) #this section causes error 'signup directs user to twitter index'
           @user.save 
           session[:id]  = @user.id
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
  		 @user = User.find_by(:username => params[:username])
  		if @user = !nil && user.password == params[:password] 
        user && user.authenticate(params[:password])
  			session[:user_id] = user.id
  			redirect to '/tweets'
      else
        redirect to '/signup'
  		end
  	end

    get '/logout' do
    		session.clear
        redirect to '/login'
    end

end

