module Api
  module V1
    class GamesController < ApiBaseController
      def show
        render json: Game.find(params[:id])
      end
    end
  end
end
