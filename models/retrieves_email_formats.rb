class RetrievesEmailFormats
  KNOWN_FORMATS = [
    {
      name: :first_name_dot_last_name,        
      pattern: /\A[a-z]{2,}\.[a-z]{2,}@[a-z]+\.[a-z]+\z/
    },   
    {
      name: :first_name_dot_last_initial,    
      pattern: /\A[a-z]{2,}\.[a-z]{1}@[a-z]+\.[a-z]+\z/
    },
    {
      name: :first_initial_dot_last_name,     
      pattern: /\A[a-z]{1}\.[a-z]{2,}@[a-z]+\.[a-z]+\z/
    },
    {
      name: :first_initial_dot_last_initial,  
      pattern: /\A[a-z]{1}\.[a-z]{1}@[a-z]+\.[a-z]+\z/
    }
  ]

  def retrieve(domain_name)
    emails = Email.find_by_domain_name(domain_name)
    emails.map { |email| get_format_for_email(email) }.uniq
  end

  private
    def get_format_for_email(email)
      KNOWN_FORMATS.each { |name, pattern| return name if pattern.match(email.to_s) }
    end
end
