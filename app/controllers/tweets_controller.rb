class TweetsController < ApplicationController


	 get '/tweets' do
		if logged_in? 
			@tweets = Tweet.all
			erb :'tweets/tweets'
		else
			redirect to '/login'
		end
	end

	 get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet' #added _tweet
    else
      redirect to '/login'
    end
  end

    post '/tweets' do
      @tweet = Tweet.create(:content => params["tweet"])
      if params[:content] == ""
        Tweet.last.delete
        redirect to :'/tweets/create_tweet' #changed from /new to /create and added _tweet
      else
        @tweet.save
        @user = User.find_by_id(params[:user_id])
          # current_user.tweets.create(content: params[:content])
          @user.tweets << @tweet
        redirect to "/tweets/#{@tweet.id}"
      end
    end

    get '/tweets/:id' do
      if logged_in? 
        @tweet = Tweet.find_by_id(params[:id])
        erb :'tweets/show_tweet'
      else
        redirect to '/login'
      end
    end

    get '/tweets/:id/edit' do
      if logged_in?
  		@tweet = Tweet.find_by_id(params[:id])
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
      @tweet = Tweet.find_by_id(params["id"])
      if params[:content] == ""
        redirect to "/tweets/#{@tweet.id}/edit"
      else
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