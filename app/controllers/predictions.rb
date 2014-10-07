MailPredictor::App.controllers :predictions do
  
  post :create, map: '/predictions' do
    email = Email.new(params[:email])

    # if email.valid_format?

    # else

    # end

    @predictions = PredictsEmail.predicts(email) || []
    render 'predictions/new'
  end

end
