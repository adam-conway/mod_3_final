class SearchController < ApplicationController
  def show
    @word = WordQuery.new(params[:search]).word
  end
end
