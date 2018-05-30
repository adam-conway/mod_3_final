class WordQuery
  def initialize(word)
    @raw_word = word
  end

  def word
    response = raw_word_query
    if response.class == String
      response
    else
      Word.new(raw_word_query)
    end
  end

  private
    attr_reader :raw_word

    def raw_word_query
      WordService.new(raw_word).data
    end
end
