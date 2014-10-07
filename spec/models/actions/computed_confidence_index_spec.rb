require 'spec_helper'

RSpec.describe ComputesConfidenceIndex do
  before do
    setup_environment
  end

  it 'should return 100 when a domain only uses one email format' do
    expect(ComputesConfidenceIndex.compute(:first_name_dot_last_name, 'alphasights.com')).to eq 100
    expect(ComputesConfidenceIndex.compute(:first_initial_dot_last_initial, 'apple.com')).to eq 100
  end

  it "should return 0 when the given domain doesn't use the given format" do
    expect(ComputesConfidenceIndex.compute(:first_name_dot_last_initial, 'alphasights.com')).to eq 0
    expect(ComputesConfidenceIndex.compute(:first_initial_dot_last_name, 'apple.com')).to eq 0 
  end

  it "should return the right value when the given domain use multiple formats" do
    expect(ComputesConfidenceIndex.compute(:first_name_dot_last_initial, 'google.com')).to eq 50
    expect(ComputesConfidenceIndex.compute(:first_initial_dot_last_name, 'google.com')).to eq 50
  end
end
