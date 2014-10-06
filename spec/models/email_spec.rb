require 'spec_helper'

RSpec.describe Email do
  it "#to_s" do
    email = FactoryGirl.build(:email)
    expect(email.to_s).to eq "john.ferguson@alphasights.com"
  end  

  it '#create_from_string' do
    email = Email.create_from_string "john.ferguson@alphasights.com"
    expect(email.first_name).to eq "John"
    expect(email.last_name).to eq "Ferguson"
    expect(email.domain_name).to eq "alphasights.com"   
  end

  it '#count_for_domain' do
    2.times { FactoryGirl.create(:email) }
    FactoryGirl.create(:email ,domain_name: 'google.com')
    expect(Email.count_for_domain 'google.com').to eq 1
    expect(Email.count_for_domain 'alphasights.com').to eq 2
  end
end
