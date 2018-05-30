require 'rails_helper'

describe Word do
  it "Validation check" do
    word = Word.new({
      "results": [
        {   "id": "foxes",
            "lexicalEntries": [
                {  "inflectionOf": [
                        {
                            "id": "fox",
                            "text": "fox"
                        }
                    ]
                }
            ]
        }
    ]
})

    expect(word).to be_a Word
  end

  it "attribute check" do
    word = Word.new({
      "results": [
        {   "id": "foxes",
            "lexicalEntries": [
                {  "inflectionOf": [
                        {
                            "id": "fox",
                            "text": "fox"
                        }
                    ]
                }
            ]
        }
    ]
})

    expect(word.id).to eq("foxes")
    expect(word.root).to eq("fox")
  end
end
