class EmailManager

  def self.get_emails
    adapter = "#{Predictor.configuration.adapter.to_s.humanize}Adapter".constantize.new
    adapter.get_emails
  end

  def self.get_emails_for_domain_name(domain_name)
    get_emails.select{|email| email.domain_name == domain_name}
  end

  def self.get_known_domain_names
    get_emails.map{|email| email.domain_name}.uniq
  end
end