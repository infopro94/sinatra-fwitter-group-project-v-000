class TweetsController < ApplicationController


	 get '/tweets' do
		if logged_in? 
      @user = current_user #added, no change in error status 2/8
			@tweets = Tweet.all
			erb :'/tweets/tweets' #substituted for index, no change 2/8
		else
			redirect to '/login'
		end
	end

	 get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet' #or create. No change either way 2/8
    else
      redirect to '/login'
    end
  end

    post '/tweets' do  
      if params[:content] == ""
         redirect to :'/tweets/new' #changed from /create_tweet to /new 2/8
      else
        @tweet = current_user.tweets.create(content: params[:content])
        redirect to "/tweets/#{@tweet.id}"
      end
    end

    get '/tweets/:id' do
      if logged_in? 
        @tweet = Tweet.find_by_id(params[:id])
        erb :'tweets/show_tweet' #corrected to singular tweet, no change 2/8
      else
        redirect to '/login'
      end
    end

    get '/tweets/:id/edit' do #changes made 2/8, no change in error status
      if !logged_in?
        # moved @tweet = Tweet to below 'else'
        redirect to '/login'   
        else  
          @tweet = Tweet.find_by_id(params[:id])
        if @tweet.user_id == current_user.id
          erb :'/tweets/edit_tweet'
        else
          redirect to "/tweets" #substituted "" for '', no change
        end
      # else
      #   redirect to '/login'
       end
  	end

  	patch '/tweets/:id' do
      if params[:content] == ""
        redirect to "/tweets/#{@tweet.id}/edit"
      else
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.content = params[:content]
        @tweet.save
        redirect to "/tweets/#{@tweet.id}"
      end
    end

    delete '/tweets/:id/delete' do #changed "delete" to "destroy, no changes in errors"
      if logged_in?
        @tweet = Tweet.find_by(params[:id]) #changed from userid, no diff. 2/8
        if @tweet.user_id == current_user.id
          @tweet.destroy
          redirect to '/tweets'
        else
          redirect to '/login'
      end
    end
  end


end