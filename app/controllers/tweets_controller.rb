class TweetsController < ApplicationController

<<<<<<< HEAD
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
=======

>>>>>>> 9c00e3c02ba107ce2cc7377a0ad232064cefc214

end