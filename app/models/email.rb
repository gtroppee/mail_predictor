class Email
  attr_accessor :first_name, :last_name, :domain

  def initialize(first_name, last_name, domain)
    @first_name, @last_name, @domain = first_name, last_name, domain
  end

end