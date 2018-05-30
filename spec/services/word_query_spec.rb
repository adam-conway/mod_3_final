require 'rails_helper'

describe "Word Query" do
  context "searches for word validity from api" do
    it 'returns word' do
      # VCR.use_cassette('word-query') do
        query = WordQuery.new("foxes")

        expect(query.word).to be_a Word
      # end
    end
  end
end
