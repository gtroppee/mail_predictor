class Predictor
  class << self
    attr_accessor :configuration
  end

  attr_reader :email

  def initialize(email)
    @email = email
    @manager = EmailManager
  end

  def status
    return :email_is_already_registered if @email.already_exists?
    return :email_is_invalid if @email.invalid?
    return :domain_name_is_unknown unless @manager.get_known_domain_names.include?(@email.domain_name)
    return :predictions_successfully_made
  end

  def predictions
    return [] unless @email.valid?
    domain_name         = @email.domain_name
    known_domain_names  = @manager.get_known_domain_names

    RetrievesEmailFormats.retrieve(domain_name, known_domain_names).map {|format|
      confidence_index = ComputesConfidenceIndex.compute(format, domain_name, known_domain_names)
      formatted_email = AppliesEmailFormats.apply(format, @email)
      
      Prediction.new(formatted_email, confidence_index)
    }.sort_by(&:confidence_index).reverse
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
