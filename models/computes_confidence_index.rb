class ComputesConfidenceIndex
  
  def compute(email, domain_name)
    
  end

  private
    def get_emails_for_domain(domain_name)
      Email.where(domain_name: domain_name)
    end

    def get_emails_with_the_same_format
  
    end

end
