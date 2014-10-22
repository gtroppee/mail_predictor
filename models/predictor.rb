class Predictor
  class << self
    attr_accessor :configuration
  end

  attr_reader :email

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  def initialize(email)
    @email               = email
    @manager             = EmailManager
    @domain_name         = @email.domain_name
    @known_domain_names  = @manager.get_known_domain_names
  end

  def status
    return :email_is_already_registered if @email.already_exists?
    return :email_is_invalid if @email.invalid?
    return :domain_name_is_unknown unless @email.has_known_domain?
    return :predictions_successfully_made
  end

  def predictions
    return [] unless @email.valid?
    formats_for_current_domain_name.map {|format|
      Prediction.new(formatted_email(format), confidence_index(format))
    }.sort_by(&:confidence_index).reverse
  end

  private
    def formats_for_current_domain_name
      RetrievesEmailFormats.retrieve(@domain_name, @known_domain_names)
    end

    def formatted_email(format)
      AppliesEmailFormats.apply(format, @email)
    end

    def confidence_index(format)
      return 0 unless @email.has_known_domain?
      emails_for_domain_name = @manager.get_emails_for_domain_name(@domain_name)
      emails_for_format      = @manager.get_emails_for_format(format, @domain_name)
      ComputesConfidenceIndex.compute(emails_for_format, emails_for_domain_name)
    end
end
