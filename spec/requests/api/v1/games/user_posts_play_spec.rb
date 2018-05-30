require "rails_helper"

describe "Post /api/v1/games/:id/plays" do
  it "Posts a play and then gets new game information" do
    josh = User.create(id: 1, name: "Josh")
    sal = User.create(id: 2, name: "Sal")

    game = Game.create(player_1: josh, player_2: sal)

    josh.plays.create(game: game, word: "sal", score: 3)
    josh.plays.create(game: game, word: "zoo", score: 12)
    sal.plays.create(game: game, word: "josh", score: 14)
    sal.plays.create(game: game, word: "no", score: 2)

    post "http://localhost:3000/api/v1/games/#{game.id}/plays?user_id=1&word=at"

    expect(response.status).to eq 201
  end
end
