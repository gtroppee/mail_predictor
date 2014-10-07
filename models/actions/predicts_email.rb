class PredictsEmail
  
  def self.predicts(email)
    domain_name = email.domain_name

    RetrievesEmailFormats.retrieve(domain_name).map { |format|
      formatted_email  = AppliesEmailFormats.apply(format, email)
      confidence_index = ComputesConfidenceIndex.compute(format, domain_name)
      Prediction.new(formatted_email, confidence_index)
    }.sort_by(&:confidence_index)
  end
end
