class ComputesConfidenceIndex
  
  def self.compute(format, domain_name)
   index = (get_emails_for_format(format, domain_name).size.to_f /
     get_emails_for_domain(domain_name).size) * 100
   index.round  
  end

  private
    def self.get_emails_for_domain(domain_name)
      Email.find_by_domain_name(domain_name)
    end

    def self.get_emails_for_format(format, domain_name)
      get_emails_for_domain(domain_name).select { |email|
        email.format === format
      }  
    end
end
