module OpenJianxinIo
  class App < Padrino::Application
    register Padrino::Helpers
    register Padrino::Admin::AccessControl

    use OmniAuth::Builder do
      provider :github, ENV['OPEN_GITHUB_KEY'], ENV['OPEN_GITHUB_SECRET'], scope: 'user:email'
    end

    enable :sessions
    enable :authentication
    enable :store_location
    set :login_page, '/account/login'

    access_control.roles_for :any do |role|
      role.protect '/admin'
    end

    access_control.roles_for :admin do |role|
      role.allow '/admin'
    end

    access_control.roles_for :user do |role|
      role.protect '/admin'
    end

  end
end
