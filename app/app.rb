module OpenJianxinIo
  class App < Padrino::Application
    register Padrino::Mailer
    register Padrino::Helpers

    enable :sessions

    use OmniAuth::Builder do
      provider :github, ENV['OPEN_GITHUB_KEY'], ENV['OPEN_GITHUB_SECRET'],scope: 'user:email'
    end

  end
end
