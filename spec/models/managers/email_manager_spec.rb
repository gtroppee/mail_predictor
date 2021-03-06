require 'spec_helper'

RSpec.describe EmailManager do

  before(:all) do
    setup_environment
    @manager = EmailManager
  end

  describe 'When testing class methods' do
    
    it '#get_known_domain_names' do
      known_domains = %w(alphasights.com apple.com google.com)
      expect(@manager.get_known_domain_names - known_domains).to eq []
    end

    it '.get_emails_for_domain_name' do
      %w(alphasights.com apple.com google.com).each do |domain_name|
        @manager.get_emails_for_domain_name(domain_name).each do |email|
          expect(email.domain_name).to eq domain_name
        end
      end
    end
  end

end
