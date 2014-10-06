class Email < ActiveRecord::Base
  
  def to_s
    "#{first_name.downcase}.#{last_name.downcase}@#{domain_name}"
  end

  def self.create_from_string(email_string)
    names       = email_string.partition('@').first
    first_name  = names.split('.').first.humanize
    last_name   = names.split('.').last.humanize
    domain_name = email_string.partition('@').last

    Email.create(
      first_name: first_name,
      last_name: last_name,
      domain_name: domain_name
    )
  end

  def self.count_for_domain(domain_name)
    where(domain_name: domain_name).count
  end

end
