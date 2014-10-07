class Email < ActiveRecord::Base

  validates :first_name,  presence: true, uniqueness: true, format: { with: /\A[a-z]+\z/i }
  validates :last_name,   presence: true, uniqueness: true, format: { with: /\A[a-z]+\z/i }
  validates :domain_name, presence: true, format: { with: /\A[a-z]+\.[a-z]+\z/i }
 
  KNOWN_FORMATS = [
    Format.new(:first_name_dot_last_name,       /\A[a-z]{2,}\.[a-z]{2,}@[a-z]+\.[a-z]+\z/),
    Format.new(:first_name_dot_last_initial,    /\A[a-z]{2,}\.[a-z]{1}@[a-z]+\.[a-z]+\z/),
    Format.new(:first_initial_dot_last_name,    /\A[a-z]{1}\.[a-z]{2,}@[a-z]+\.[a-z]+\z/),
    Format.new(:first_initial_dot_last_initial, /\A[a-z]{1}\.[a-z]{1}@[a-z]+\.[a-z]+\z/)
  ]

  def to_s
    "#{first_name.downcase}.#{last_name.downcase}@#{domain_name}"
  end

  def format
    KNOWN_FORMATS.each { |format| return format.name if format.pattern.match(self.to_s) }
  end
  
  def self.find_by_domain_name(domain_name)
    where(domain_name: domain_name)
  end

  def self.known_domains
    pluck(:domain_name).uniq
  end

  def self.create_from_string(email_string)
    domain_name = email_string.partition('@').last.downcase
    names       = email_string.partition('@').first
    first_name  = names.split('.').first.humanize
    last_name   = names.split('.').last.humanize

    Email.create(
      first_name:   first_name,
      last_name:    last_name,
      domain_name:  domain_name
    )
  end

end
