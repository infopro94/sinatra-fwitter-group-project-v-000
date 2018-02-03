class TweetsController < ApplicationController

	# <!-- loads the login page 
 #    loads the tweets index after login 
 #    does not let user view login page if already logged in  -->

	get '/tweets' do
		if logged_in? 
			@tweets = Tweet.all
			erb :tweets
		else
			redirect to 'login'
		end
	end

	  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end
  end

  	get '/tweets/:id/edit' do
  		@tweets = Tweet.find_by(params[:id])
  		erb :'/tweets/edit'
  	end

  	post '/tweets/:id' do

  	end




end