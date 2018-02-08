class TweetsController < ApplicationController


	 get '/tweets' do
		if logged_in? 
			@tweets = Tweet.all
			erb :index
		else
			redirect to '/login'
		end
	end

	 get '/tweets/new' do
    if logged_in?
      erb :'tweets/create' #or create_tweet
    else
      redirect to '/login'
    end
  end

    post '/tweets' do  
      if params[:content] == ""
         redirect to :'/tweets/create_tweet' #changed from /new to /create and added _tweet
      else
        @tweet = current_user.tweets.create(content: params[:content])
        redirect to "/tweets/#{@tweet.id}"
      end
    end

    get '/tweets/:id' do
      if logged_in? 
        @tweet = Tweet.find_by_id(params[:id])
        erb :'tweets/show_tweets'
      else
        redirect to '/login'
      end
    end

    get '/tweets/:id/edit' do
      if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
       # redirect to '/login'      
        if @tweet.user_id == current_user.id
          erb :'/tweets/edit_tweet'
        else
          redirect to '/tweets'
        end
      else
        redirect to '/login'
       end
  	end

  	patch '/tweets/:id' do
      if params[:content] == ""
        redirect to "/tweets/#{@tweet.id}/edit"
      else
        # @tweet = Tweet.find_by_id(params[:id])
        @tweet.content = params[:content]
        @tweet.save
        redirect to "/tweets/#{@tweet.id}"
      end
    end

    delete '/tweets/:id/delete' do
      if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet.user_id == current_user
          @tweet.delete
          redirect to '/tweets'
        else
          redirect to '/login'
      end
    end
  end


end