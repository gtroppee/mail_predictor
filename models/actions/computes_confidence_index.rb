class ComputesConfidenceIndex
  
  def self.compute(email, domain_name)
    (get_emails_with_the_same_format(email, domain_name).size /
     get_emails_for_domain(domain_name).size) * 100  
  end

  private
    def self.get_emails_for_domain(domain_name)
      Email.find_by_domain_name(domain_name)
    end

    def self.get_emails_with_the_same_format(email, domain_name)
      get_emails_for_domain(domain_name).select { |e|
        e.format === email.format
      }  
    end
end
