module MailPredictor
  class App < Padrino::Application
    register Padrino::Helpers

    enable :sessions

    class MailPredictor::App
      get '/' do
        render 'predictions/index'
      end
    end
  end
end
