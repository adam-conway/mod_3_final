class WordQuery
  def initialize(word)
    @raw_word = word
  end

  def word
    Word.new(raw_word_query)
  end

  private
    attr_reader :raw_word

    def raw_word_query
      WordService.new(raw_word).data
    end
end
