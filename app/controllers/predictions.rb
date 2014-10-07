MailPredictor::App.controllers :predictions do
  
  post :create, map: '/predictions' do
    email = Email.new(params[:email])
    @predictor = Predictor.new(email)
    
    render 'predictions/new'
  end

end
