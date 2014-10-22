class Email < ActiveRecord::Base

  validates :first_name,  presence: true, format: { with: /\A[a-z]+\z/i }
  validates :last_name,   presence: true, format: { with: /\A[a-z]+\z/i }
  validates :domain_name, presence: true, format: { with: /\A[a-z]+\.[a-z]+\z/i }

  validate :unicity_constraint

  def to_s
    "#{first_name.downcase}.#{last_name.downcase}@#{domain_name}"
  end

  def format
    known_formats.each { |format| return format.name if format.pattern.match(self.to_s) }
  end

  def already_exists?
    registered_emails.any?{ |e| e.to_s === to_s }
  end

  def self.new_from_string(email_string)
    domain_name = email_string.partition('@').last.downcase
    names       = email_string.partition('@').first
    first_name  = names.split('.').first.humanize
    last_name   = names.split('.').last.humanize

    Email.new(
      first_name:   first_name,
      last_name:    last_name,
      domain_name:  domain_name
    )
  end

  def self.create_from_string(email_string)
    new_from_string(email_string).save
  end

  protected
    def unicity_constraint
      errors.add(:base, "Two addresses cannot be indentical") if already_exists?
    end

  private
    def registered_emails
      EmailManager.get_emails
    end

    def known_formats
      FormatManager.get_known_formats
    end
end
