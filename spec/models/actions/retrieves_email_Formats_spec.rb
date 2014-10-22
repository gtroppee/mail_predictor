require 'spec_helper'

RSpec.describe RetrievesEmailFormats do
  before do
    setup_environment
  end
  
  it 'it should return all the email formats used by the given domain' do
    expect(RetrievesEmailFormats.retrieve 'alphasights.com', @known_domains).to eq [:first_name_dot_last_name]
    expect(RetrievesEmailFormats.retrieve 'apple.com', @known_domains).to eq [:first_initial_dot_last_initial]
    expect(RetrievesEmailFormats.retrieve 'google.com', @known_domains).to include :first_initial_dot_last_name
    expect(RetrievesEmailFormats.retrieve 'google.com', @known_domains).to include :first_name_dot_last_initial
  end

  it 'it should return all the email formats possible if the given domain is unknown' do
    expect(RetrievesEmailFormats.retrieve 'unknown.com', @known_domains).to include :first_name_dot_last_name
    expect(RetrievesEmailFormats.retrieve 'unknown.com', @known_domains).to include :first_name_dot_last_initial
    expect(RetrievesEmailFormats.retrieve 'unknown.com', @known_domains).to include :first_initial_dot_last_name
    expect(RetrievesEmailFormats.retrieve 'unknown.com', @known_domains).to include :first_initial_dot_last_initial
  end
end
