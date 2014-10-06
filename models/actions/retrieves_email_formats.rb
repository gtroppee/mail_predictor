class RetrievesEmailFormats

  def self.retrieve(domain_name)
    Email.find_by_domain_name(domain_name).map { |email| email.format }.uniq
  end
end
