class FormatManager

  KNOWN_FORMATS = [
    Format.new(:first_name_dot_last_name,       /\A[a-z]{2,}\.[a-z]{2,}@[a-z]+\.[a-z]+\z/),
    Format.new(:first_name_dot_last_initial,    /\A[a-z]{2,}\.[a-z]{1}@[a-z]+\.[a-z]+\z/),
    Format.new(:first_initial_dot_last_name,    /\A[a-z]{1}\.[a-z]{2,}@[a-z]+\.[a-z]+\z/),
    Format.new(:first_initial_dot_last_initial, /\A[a-z]{1}\.[a-z]{1}@[a-z]+\.[a-z]+\z/)
  ]

  def self.get_known_formats
    KNOWN_FORMATS
  end

  def self.get_known_format_names
    get_known_formats.map(&:name)
  end
end