require 'spec_helper'

RSpec.describe AppliesEmailFormats do
  it 'shoud return the right formatted email string given the format and the email object' do
    email = build(:email)

    expect(AppliesEmailFormats.apply(:first_initial_dot_last_name, email)).to eq 'j.ferguson@alphasights.com'
    expect(AppliesEmailFormats.apply(:first_name_dot_last_initial, email)).to eq 'john.f@alphasights.com'
    expect(AppliesEmailFormats.apply(:first_initial_dot_last_initial, email)).to eq 'j.f@alphasights.com'
    expect(AppliesEmailFormats.apply(:first_name_dot_last_name, email)).to eq 'john.ferguson@alphasights.com'
  end
end
