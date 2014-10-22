require 'spec_helper'

RSpec.describe FormatManager do

  before(:all) do
    setup_environment
    @manager = FormatManager
  end

  describe 'When testing class methods' do

    it '#get_known_format_names' do
      known_formats = [:first_name_dot_last_name, :first_name_dot_last_initial, :first_initial_dot_last_name, :first_initial_dot_last_initial]  
      expect(FormatManager.get_known_format_names - known_formats).to eq []
    end
  end

end
