require 'spec_helper'

RSpec.describe Predictor do
 
  let(:registered_email) { create(:email) }
  let(:email) { registered_email.dup } 
  let(:predictor) { Predictor.new(email) }

  it '.status && .predictions' do
  # I know that testing multiple methods at the same time is not pretty but, since they both need more or less the same context, this seems better (to me) than duplicating chunks of code.
    # email_is_already_in_db
    expect(predictor.status).to eq :email_is_already_in_db
    expect(predictor.email.to_s).to eq registered_email.to_s

    # domain_name_is_unknown
    email.domain_name = 'unknown.com'
    expect(predictor.status).to eq :domain_name_is_unknown
    expect(predictor.predictions.count).to eq 4

    # email_is_invalid
    email.first_name = 'Malformed.name'
    expect(predictor.status).to eq :email_is_invalid
    expect(predictor.predictions.count).to eq 0

    # predictions_successfully_made
    email.attributes = { first_name: 'Name', domain_name: registered_email.domain_name }
    expect(predictor.status).to eq :predictions_successfully_made
    expect(predictor.predictions.count).to eq 1
  end
end
