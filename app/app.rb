module MailPredictor
  class App < Padrino::Application
    register Padrino::Helpers

    enable :sessions

    class MailPredictor::App
      # for more info: http://www.seanbehan.com/how-to-fix-activerecord-connectiontimeouterror-with-sinatra
      after { ActiveRecord::Base.connection.close }

      get '/' do
        render 'predictions/new'
      end
    end
  end
end
