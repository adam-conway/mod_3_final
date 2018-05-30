require 'rails_helper'

describe 'Guest' do
  describe 'visits the home page' do
    scenario 'validates an valid word' do
      VCR.use_cassette('home-page-query-valid') do
        visit '/'

        fill_in 'search', with: "foxes"
        click_on "Validate Word"

        expect(page).to have_content("'foxes' is a valid word and its root form is 'fox'.")
      end
    end
    scenario 'validates an invalid word' do
      VCR.use_cassette('home-page-query-invalid') do
        visit '/'

        fill_in 'search', with: "foxez"
        click_on "Validate Word"

        expect(page).to have_content("'foxez' is not a valid word.")
      end
    end
  end
end
