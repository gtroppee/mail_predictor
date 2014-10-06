class AppliesEmailFormats
  
  def apply(format_name, email)
    send(:"apply_#{format_name}", email)
  end

  private
    def apply_first_name_dot_last_name(email)
      "#{email.first_name}.#{email.last_name}@#{email.domain_name}"  
    end

    def apply_first_name_dot_last_initial(email)
      "#{email.first_name}.#{email.last_name[0]}@#{email.domain_name}"   
    end

    def apply_first_initial_dot_last_name(email)
     "#{email.first_name[0]}.#{email.last_name}@#{email.domain_name}" 
    end

    def apply_first_initial_dot_last_initial(email)
     "#{email.first_name[0]}.#{email.last_name[0]}@#{email.domain_name}" 
    end
end
