class ApiBaseController < ActionController::API
  before_action :validate!

  def validate!
    if params[:word]
      render json: { message: "#{params[:word]} is not a valid word." } unless WordQuery.new(params[:word]).word.class == Word
    end
  end
end
