MailPredictor::Admin.controllers :emails do
  get :index do
    @title = "Emails"
    @emails = Email.all
    render 'emails/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'email')
    @email = Email.new
    render 'emails/new'
  end

  post :create do
    @email = Email.new(params[:email])
    if @email.save
      @title = pat(:create_title, :model => "email #{@email.id}")
      flash[:success] = pat(:create_success, :model => 'Email')
      params[:save_and_continue] ? redirect(url(:emails, :index)) : redirect(url(:emails, :edit, :id => @email.id))
    else
      @title = pat(:create_title, :model => 'email')
      flash.now[:error] = pat(:create_error, :model => 'email')
      render 'emails/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "email #{params[:id]}")
    @email = Email.find(params[:id])
    if @email
      render 'emails/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'email', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "email #{params[:id]}")
    @email = Email.find(params[:id])
    if @email
      if @email.update_attributes(params[:email])
        flash[:success] = pat(:update_success, :model => 'Email', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:emails, :index)) :
          redirect(url(:emails, :edit, :id => @email.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'email')
        render 'emails/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'email', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Emails"
    email = Email.find(params[:id])
    if email
      if email.destroy
        flash[:success] = pat(:delete_success, :model => 'Email', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'email')
      end
      redirect url(:emails, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'email', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Emails"
    unless params[:email_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'email')
      redirect(url(:emails, :index))
    end
    ids = params[:email_ids].split(',').map(&:strip)
    emails = Email.find(ids)
    
    if Email.destroy emails
    
      flash[:success] = pat(:destroy_many_success, :model => 'Emails', :ids => "#{ids.to_sentence}")
    end
    redirect url(:emails, :index)
  end
end
