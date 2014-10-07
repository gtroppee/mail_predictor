# Helper methods defined here can be accessed in any controller or view in the application

module MailPredictor
  class App
    module PredictionsHelper

      def define_response_status(email)
        @matching_email = Email.all.select{ |e| e.to_s === email.to_s }.first
        if @matching_email
          :email_is_already_in_db
        elsif email.valid?
          @predictions = PredictsEmail.predicts(email) 
          if @predictions.map(&:confidence_index).reduce(:+).zero?
            :domain_name_is_unknown 
          else
            :predictions_successfully_made
          end
        else
          :email_is_invalid
        end
      end

    end

    helpers PredictionsHelper
  end
end
