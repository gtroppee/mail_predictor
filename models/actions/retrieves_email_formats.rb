class RetrievesEmailFormats

  def self.retrieve(domain_name, known_domain_names)
    if known_domain_names.include?(domain_name)
      return_formats_for_domain_name(domain_name)
    else
      return_all_possible_formats
    end
  end

  private
    def self.return_formats_for_domain_name(domain_name)
      EmailManager.get_emails_for_domain_name(domain_name).map { |email| email.format }.uniq
    end

    def self.return_all_possible_formats
      EmailManager.get_known_format_names
    end
end
