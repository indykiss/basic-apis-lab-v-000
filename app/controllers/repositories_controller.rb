class RepositoriesController < ApplicationController

  def search
  end

  def github_search
      @resp = Faraday.get 'https://developer.github.com/v3/search/#search-repositories' do |req|
        req.params['client-id'] = 'd39518d29d8d39a37017'
        req.params['client_secret'] = '02dbaf073d5a7a127693bdc3c833ca58833ff390'
        req.params['q'] = params[:query]
    end
      body = JSON.parse(@resp.body)
      if @resp.success?
        @repos = body["items"]
      else
        @error = body["meta"]["errorDetail"]
      end
      
      rescue Faraday::ConnectionFailed
        @error = "There was a timeout. Please try again."
      render 'search'
  end



end
