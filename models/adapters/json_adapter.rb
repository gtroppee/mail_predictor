class JsonAdapter

  def get_emails
    source.map do |_, val|
      Email.new_from_string(val)
    end
  end
  
  private
    def source
      JSON.parse(File.read('data/emails.json'))
    end
end