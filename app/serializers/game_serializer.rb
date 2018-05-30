class GameSerializer < ActiveModel::Serializer
  attributes :game_id,
             :scores

  def game_id
    object.id
  end

  def scores
  [
    {
      "user_id": object.player_1_id,
      "score": object.plays.where(user_id: object.player_1_id).pluck(:score).sum
    },
    {
      "user_id": object.player_2_id,
      "score": object.plays.where(user_id: object.player_2_id).pluck(:score).sum
    }
  ]
  end
end
