namespace :mp do

  desc "initialize/reset the projet"
  task  setup: :environment do
    Rake.application['ar:setup'].invoke
    Rake.application['mp:test_prepare'].invoke
  end

  task  test_prepare: :environment do
    %w(drop create migrate).each do |action|
      ENV['RACK_ENV'] = 'test'
      Rake.application["ar:#{action}"].invoke
    end
  end
end
