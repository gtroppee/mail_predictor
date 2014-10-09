require 'spec_helper'

describe "Submitting new prediction request" do

  before do
    setup_environment
    visit '/'
  end

  it "should" do 
    expect(page).to have_css 'h1', text: 'The Mail Predictor'
  end

  describe 'when entering valid information' do
    it 'should return a success message with confident information' do
      fill_in 'email_first_name',  with: 'John'
      fill_in 'email_last_name',   with: 'Doe'
      fill_in 'email_domain_name', with: 'alphasights.com'
      click_on 'Submit'        
      expect(page).to have_css '.alert-success'
      expect(page).to have_css 'li.prediction', between: 1..4 
    end
  end
  
  describe 'when entering information that match an existing email address' do
    it 'should return an info message with the matched email' do
      fill_in 'email_first_name',  with: 'John'
      fill_in 'email_last_name',   with: 'Ferguson'
      fill_in 'email_domain_name', with: 'alphasights.com'
      click_on 'Submit'
      expect(page).to have_css '.alert-info'
      expect(page).to have_content 'john.ferguson@alphasights.com'
    end
  end
  
  describe 'when entering information that do not respect the expected format' do
    it 'should return an error message with no suggestion' do
      fill_in 'email_first_name',  with: 'John'
      fill_in 'email_last_name',   with: 'Fer.guson'
      fill_in 'email_domain_name', with: 'alphasights.com'
      click_on 'Submit'
      expect(page).to have_css '.alert-danger'
      expect(page).not_to have_css 'li.prediction' 
    end  
  end

  describe 'when entering invalid information' do
    it 'should return a warning message with unconfident suggestions' do
      fill_in 'email_first_name',  with: 'Barack'
      fill_in 'email_last_name',   with: 'Obama'
      fill_in 'email_domain_name', with: 'whitehouse.gov'
      click_on 'Submit'

      expect(page).to have_css '.alert-warning'
      expect(page).to have_css 'li.prediction', count: 4 
    end
  end
 end
