require "rails_helper"

describe "Get /api/v1/games/:id" do
  it "Gets information about a game based on id" do
    josh = User.create(id: 1, name: "Josh")
    sal = User.create(id: 2, name: "Sal")

    game = Game.create(player_1: josh, player_2: sal)

    josh.plays.create(game: game, word: "sal", score: 3)
    josh.plays.create(game: game, word: "zoo", score: 12)
    sal.plays.create(game: game, word: "josh", score: 14)
    sal.plays.create(game: game, word: "no", score: 2)

    get "http://localhost:3000/api/v1/games/#{game.id}"

    expect(response.status).to eq 200
    game = JSON.parse(response.body)

    expect(game).to have_key("game_id")
    expect(game["game_id"]).to eq(game.id)

    expect(game).to have_key("scores")
    expect(game["scores"]).to be_an Array

    expect(game["scores"].first).to have_key("user_id")
    expect(game["scores"].first["user_id"]).to eq(josh.id)

    expect(game["scores"].first).to have_key("score")
    expect(game["scores"].first["score"]).to eq(15)

    expect(game["scores"][1]).to have_key("user_id")
    expect(game["scores"][1]["user_id"]).to eq(sal.id)

    expect(game["scores"][1]).to have_key("score")
    expect(game["scores"][1]["score"]).to eq(16)
  end
end
