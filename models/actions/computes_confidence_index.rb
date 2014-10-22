class ComputesConfidenceIndex
  
  def self.compute(format, domain_name, known_domain_names)
    return 0 unless known_domain_names.include?(domain_name)
    index = (get_emails_for_format(format, domain_name).size.to_f / get_emails_for_domain(domain_name).size) * 100
    index.round
  end

  private
    def self.get_emails_for_domain(domain_name)
      EmailManager.get_emails_for_domain_name(domain_name)
    end

    def self.get_emails_for_format(format, domain_name)
      get_emails_for_domain(domain_name).select { |email|
        email.format === format
      }  
    end
end
