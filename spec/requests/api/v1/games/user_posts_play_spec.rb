require "rails_helper"

describe "Post /api/v1/games/:id/plays" do
  it "Posts a play and then gets new game information" do
    VCR.use_cassette('posts-valid-play') do
      josh = User.create(id: 1, name: "Josh")
      sal = User.create(id: 2, name: "Sal")

      game = Game.create(player_1: josh, player_2: sal)

      josh.plays.create(game: game, word: "sal", score: 3)
      josh.plays.create(game: game, word: "zoo", score: 12)
      sal.plays.create(game: game, word: "josh", score: 14)
      sal.plays.create(game: game, word: "no", score: 2)

      post "http://localhost:3000/api/v1/games/#{game.id}/plays?user_id=1&word=at"

      expect(response.status).to eq 201

      get "http://localhost:3000/api/v1/games/#{game.id}"

      game_data = JSON.parse(response.body)

      expect(game_data).to have_key("game_id")
      expect(game_data["game_id"]).to eq(game.id)

      expect(game_data).to have_key("scores")
      expect(game_data["scores"]).to be_an Array

      expect(game_data["scores"].first).to have_key("user_id")
      expect(game_data["scores"].first["user_id"]).to eq(josh.id)

      expect(game_data["scores"].first).to have_key("score")
      expect(game_data["scores"].first["score"]).to eq(17)

      expect(game_data["scores"][1]).to have_key("user_id")
      expect(game_data["scores"][1]["user_id"]).to eq(sal.id)

      expect(game_data["scores"][1]).to have_key("score")
      expect(game_data["scores"][1]["score"]).to eq(16)
    end
  end

  it "tries to post an invalid word" do
    VCR.use_cassette('posts-invalid-play') do
      josh = User.create(id: 1, name: "Josh")
      sal = User.create(id: 2, name: "Sal")
      word = "foxez"

      game = Game.create(player_1: josh, player_2: sal)

      post "http://localhost:3000/api/v1/games/#{game.id}/plays?user_id=1&word=#{word}"

      invalid_move = JSON.parse(response.body)
      expect(invalid_move).to have_key("message")
      expect(invalid_move["message"]).to eq("#{word} is not a valid word.")
    end
  end
end
