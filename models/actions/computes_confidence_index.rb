class ComputesConfidenceIndex
  
  def self.compute(emails_for_format, emails_for_domain_name)
    numerator   = emails_for_format.size.to_f # number of emails with the same format
    denominator = emails_for_domain_name.size # number of emails with the same domain_name
    index       = (numerator / denominator) * 100
    index.round
  end
end
