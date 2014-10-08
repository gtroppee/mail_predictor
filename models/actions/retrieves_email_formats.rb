class RetrievesEmailFormats

  def self.retrieve(domain_name)
    if Email.known_domains.include?(domain_name)
      return_formats_for_domain_name(domain_name)
    else
      return_all_possible_formats
    end
  end

  private
    def self.return_formats_for_domain_name(domain_name)
      Email.find_by_domain_name(domain_name).map { |email| email.format }.uniq
    end

    def self.return_all_possible_formats
      Email.known_formats
    end
end
