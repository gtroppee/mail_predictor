require 'csv'
class CsvAdapter

  def get_emails
    source.last.map do |row|
      Email.new_from_string(row)
    end
  end
  
  private
    def source
      CSV.read('data/emails.csv')
    end

end