class ActiverecordAdapter

  def get_emails
    source
  end

  private
    def source
      Email.all
    end
end