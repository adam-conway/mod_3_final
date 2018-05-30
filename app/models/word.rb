class Word
  attr_reader :id, :root
  def initialize(search_hash)
    @id = search_hash[:results].first[:id]
    @root = search_hash[:results].first[:lexicalEntries].first[:inflectionOf].first[:id]
  end
end
