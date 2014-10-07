class Predictor

  attr_reader :email

  def initialize(email)
    @email = email
  end

  def status
    return :email_is_already_in_db if @email.already_exists?
    return :email_is_invalid if @email.invalid?
    return :domain_name_is_unknown unless Email.known_domains.include?(@email.domain_name)
    return :predictions_successfully_made
  end

  def predictions
    domain_name = @email.domain_name

    RetrievesEmailFormats.retrieve(domain_name).map { |format|
      formatted_email  = AppliesEmailFormats.apply(format, @email)
      confidence_index = ComputesConfidenceIndex.compute(format, domain_name)
      Prediction.new(formatted_email, confidence_index)
    }.sort_by(&:confidence_index).reverse
  end
end
