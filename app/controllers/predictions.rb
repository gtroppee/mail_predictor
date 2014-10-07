MailPredictor::App.controllers :predictions do
  
  post :create, map: '/predictions' do
    email = Email.new(params[:email])
    @status = define_response_status(email)
    render 'predictions/new'
  end

end
