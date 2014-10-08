require 'spec_helper'

RSpec.describe Email do

  describe 'When testing class methods' do

    it '#known_formats' do
      known_formats = [:first_name_dot_last_name, :first_name_dot_last_initial, :first_initial_dot_last_name, :first_initial_dot_last_initial]  
      expect(Email.known_formats - known_formats).to eq []
    end

    it '#known_domains' do
      known_domains = %w(alphasights.com apple.com google.com)
      expect(Email.known_domains - known_domains).to eq []
    end

    it '#find_by_domain_name' do
      %w(alphasights.com apple.com google.com).each do |domain_name|
        Email.find_by_domain_name(domain_name).each do |email|
          expect(email.domain_name).to eq domain_name
        end
      end
    end

    it '#create_from_string' do
      expect{ Email.create_from_string "john.ferguson@alphasights.com" }.to change{ Email.count }.by 1
      email = Email.last
      expect(email.first_name).to eq "John"
      expect(email.last_name).to eq "Ferguson"
      expect(email.domain_name).to eq "alphasights.com"   
    end
  end

  describe 'When instance class methods' do
    it ".to_s" do
      email = build(:email)
      expect(email.to_s).to eq "john.ferguson@alphasights.com"
    end  
    
    it '.format' do
      email = build(:email)
      expect(email.format).to eq :first_name_dot_last_name

      email.first_name = 'J'
      expect(email.format).to eq :first_initial_dot_last_name

      email.last_name = 'F'
      expect(email.format).to eq :first_initial_dot_last_initial

      email.first_name = 'John'
      expect(email.format).to eq :first_name_dot_last_initial
    end

    it '.already_exists?' do
      registered_email = create(:email)

      email = registered_email.dup
      expect(email.already_exists?).to be_truthy

      email.first_name = 'Othername'
      expect(email.already_exists?).to be_falsy 
    end
  end

  describe 'When testing validations' do

    let(:email) { build(:email) }

    it 'should be valid as is' do
      expect(email).to be_valid
    end

    it 'should respect the presence validations' do
      email.first_name = nil
      expect(email).to be_invalid
      email.attributes = { first_name: 'John', last_name: nil }
      expect(email).to be_invalid
      email.attributes = { last_name: 'Ferguson', domain_name: nil }
      expect(email).to be_invalid
      email.attributes = { domain_name: 'alphasights.com' }
      expect(email).to be_valid
    end

    it 'should respect the format validations' do
      email.first_name = 'Jo.hn'
      expect(email).to be_invalid
      email.attributes = { first_name: 'John', last_name: 'Fer.guson' }
      expect(email).to be_invalid
      email.attributes = { last_name: 'Ferguson' }
      expect(email).to be_valid
      email.attributes = { domain_name: 'alpha.sights.com' }
      expect(email).to be_invalid
    end

    it 'should respect the unicity constraint' do
      email.save

      new_email = email.dup
      expect(new_email).to be_invalid

      new_email.first_name = 'Othername'
      expect(new_email).to be_valid
    end
  end

end
