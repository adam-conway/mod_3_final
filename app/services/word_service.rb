class WordService
  def initialize(word)
    @word = word
  end

  def data
    raw_search
  end

  private
    attr_reader :word

    def conn
      Faraday.new(url: "https://od-api.oxforddictionaries.com:443/api/v1/inflections/en/#{word}")
    end

    def response
      @response ||= conn.get do |req|
        req.headers['app_key'] = ENV['OXFORD_API_KEY']
        req.headers['app_id'] = ENV['OXFORD_APP_ID']
      end
    end

    def raw_search
      return invalid_word if response.body.include?("404")
      JSON.parse(response.body, symbolize_names: true)
    end

    def invalid_word
      "'#{word}' is not a valid word."
    end
end
