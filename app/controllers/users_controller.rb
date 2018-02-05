require 'pry'

class UsersController < ApplicationController

	   get '/users/:slug' do
    	 @user = User.find_by_slug(params[:slug])
    	 erb :'users/show'
  	 end

  	get '/signup' do
  		if !logged_in?
  			erb :'users/create', locals: {message: "Please sign up to sign in"}
        # binding.pry
  		else
  			redirect to "/tweets"
        
  		end
	   end


    post '/signup' do
    	if params[:username] == "" || params[:email] == "" || params[:password] == "" 
    		redirect to "/signup"
          
    	else
      		# @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])

      		# @user.save
      		# session[:user_id] = @user.id
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
  		   @user = User.find_by(params[:username])
  		if logged_in?
     #    user && user.authenticate(params[:password])
  			# session[:user_id] = user.id
  			redirect to '/tweets'
  		else
  			redirect to '/signup'
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

