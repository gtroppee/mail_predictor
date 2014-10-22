shared_examples_for "an adapter" do
  before(:all) do
    setup_environment
    @adapter = described_class.new
  end

  it '#get_emails' do
    expect(@adapter.get_emails.first).to be_an Email
  end
end