class RetrievesEmailFormats

  def retrieve(domain_name)
    emails = Email.find_by_domain_name(domain_name)
    emails.map { |email| get_format_for_email(email) }.uniq
  end
end
