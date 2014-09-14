OpenJianxinIo::App.controllers :account do

  get '/login' do
    @title = '登录'
    if logged_in?
      return redirect '/'
    end
    render :login, layout: 'application'
  end

  get :auth, :map => '/auth/:provider/callback' do
    auth = request.env['omniauth.auth']['info']
    current_user = Account.find_by(email: auth['email']) ||
        Account.create_with_omniauth(auth)
    set_current_account current_user
    redirect_back_or_default('/')
  end

  get :logout do
    set_current_account nil
    redirect '/'
  end

end
