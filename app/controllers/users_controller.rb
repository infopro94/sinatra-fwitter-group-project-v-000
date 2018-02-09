class UsersController < ApplicationController

	   get '/users/:slug' do
    	 @user = User.find_by_slug(params[:slug])
    	 erb :'users/show'
  	 end

  	get '/signup' do #part of the signup magic. Change this and add 4 errors
  		if !logged_in?
  			erb :'/users/create_user'
        
      else
        redirect to "/tweets"
        # , locals: {message: "Please sign up to sign in"}
  		end
	   end


    post '/signup' do 
      if logged_in? 
        redirect '/tweets'
        elsif params[:username] == "" || params[:email] == "" || params[:password] == "" 
    		redirect to "/signup"
      else
      		@user = User.create(params)
          @user.save 
      		session[:user_id] = @user.id
          redirect '/tweets'
    	end
  	end

  	get '/login' do #still no changes after removing !from logged_in? and switching redirect and erb
  		if logged_in?
          redirect to '/tweets'
  		else
          erb :'/users/login'
        end
  	end


  	post '/login' do #removed @ from user and user.authenticate and added 3 errors
  		  user = User.find_by(username: params[:username])
  		 if user && user.authenticate(params[:password])
  			session[:user_id] = user.id
  			redirect to '/tweets'
  		else
  			redirect to '/login'
  		end
  	end

    get '/logout' do
      if logged_in?
          session.clear #tried with .destroy, no change
          redirect to '/login'
      else
    		redirect to '/'
    end
  end

end

