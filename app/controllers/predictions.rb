MailPredictor::App.controllers :predictions do
  
  post :create, map: '/predictions' do
    email = Email.new(params[:email])

    if email.valid?
      @predictions = PredictsEmail.predicts(email) 
    else
      @invalid_email = true
    end
    
    render 'predictions/new'
  end

end
