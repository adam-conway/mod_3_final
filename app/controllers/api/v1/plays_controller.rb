module Api
  module V1
    class PlaysController < ApiBaseController
      def create
        game = Game.find(params[:game_id])
        game.plays.create(user_id: params[:user_id], word: params[:word])
        render json: game, status: 201
      end
    end
  end
end
