require 'spec_helper'

RSpec.describe Email do

  before(:all) do
    setup_environment
    @registered_email = EmailManager.get_emails.first
  end

  describe 'When testing class methods' do
    it '#new_from_string' do
      email = Email.new_from_string "john.doe@alphasights.com"
      expect(email.first_name).to eq "John"
      expect(email.last_name).to eq "Doe"
      expect(email.domain_name).to eq "alphasights.com"   
    end
  end

  describe 'When instance class methods' do
    it ".to_s" do
      email = build(:email)
      expect(email.to_s).to eq "john.doe@alphasights.com"
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
      email = @registered_email.dup
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
      email.first_name = ''
      expect(email).to be_invalid

      email.first_name = 'John'
      email.last_name  = ''
      expect(email).to be_invalid

      email.last_name   = 'Doe'
      email.domain_name = ''
      expect(email).to be_invalid

      email.domain_name = 'alphasights.com'
      expect(email).to be_valid
    end

    it 'should respect the format validations' do
      email.first_name = 'Jo.hn'
      expect(email).to be_invalid

      email.first_name = 'John'
      email.last_name  = 'Do.e'
      expect(email).to be_invalid

      email.last_name  = 'Doe'
      expect(email).to be_valid

      email.domain_name = 'alpha.sights.com'
      expect(email).to be_invalid
    end

    it 'should respect the unicity constraint' do
      new_email = @registered_email.dup
      expect(new_email).to be_invalid

      new_email.first_name = 'Othername'
      expect(new_email).to be_valid
    end
  end

end
