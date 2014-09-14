OpenJianxinIo::App.controllers :auth do

  get :auth, :map => '/auth/:provider/callback' do
    auth = request.env['omniauth.auth']['info']
    current_user = User.find_by(email: auth['email']) ||
        User.create_with_omniauth(auth)
  end

end
