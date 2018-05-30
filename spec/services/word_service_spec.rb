require 'rails_helper'

describe "Word Service" do
  context "searches for word from api" do
    it 'returns word' do
      VCR.use_cassette('word-service') do
        json = WordService.new("foxes").data

        expect(json).to have_key(:results)
        expect(json[:results].first).to be_a Hash

        expect(json[:results].first).to have_key(:id)
        expect(json[:results].first[:id]).to be_a String
      end
    end
  end
end
