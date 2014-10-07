require 'spec_helper'

RSpec.describe Email do
  it ".to_s" do
    email = build(:email)
    expect(email.to_s).to eq "john.ferguson@alphasights.com"
  end  

  it '#create_from_string' do
    expect{ Email.create_from_string "john.ferguson@alphasights.com" }.to change{ Email.count }.by 1
    email = Email.last
    expect(email.first_name).to eq "John"
    expect(email.last_name).to eq "Ferguson"
    expect(email.domain_name).to eq "alphasights.com"   
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

  it '#find_by_domain_name' do
    %w(alphasights.com apple.com google.com).each do |domain_name|
      Email.find_by_domain_name(domain_name).each do |email|
        expect(email.domain_name).to eq domain_name
      end
    end
  end
end
