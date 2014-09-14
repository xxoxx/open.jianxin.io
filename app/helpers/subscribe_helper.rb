# Helper methods defined here can be accessed in any controller or view in the application

require 'mailgun'
require 'digest'
require 'json'
require 'addressable/uri'

module OpenJianxinIo
  class App
    module SubscribeHelper
      def send_mail(from, to_user, subject, html)
        mg_client = Mailgun::Client.new ENV['OPEN_MAIL_KEY']
        message_params = {from: "简信开源 <#{from}@#{ENV['OPEN_MAIL_DOMAIN']}>",
                          to: "#{to_user.name} <#{to_user.email}>",
                          subject: subject,
                          html: html}
        mg_client.send_message ENV['OPEN_MAIL_DOMAIN'], message_params
      end

      def dump_url(action, user)
        result_uri = Addressable::URI.new
        params = {timestamp: Time.now.to_i, email: user.email}
        md5 = Digest::MD5.new
        md5.update "#{params.to_json}#{user.secret}"
        params[:secret] = md5.hexdigest
        result_uri.query_values = params
        "#{ENV['OPEN_ROOT_URL']}subscribe/#{action}?#{result_uri.query}"
      end

      def load_url(params)
        user = Account.find_by(email: params['email'])
        unless user
          return nil
        end
        query = {timestamp: params['timestamp'].to_i, email: params['email']}
        md5 = Digest::MD5.new
        md5.update "#{query.to_json}#{user.secret}"
        puts "#{query.to_json}#{user.secret}"
        unless md5.hexdigest == params['secret']
          return nil
        end
        user
      end
    end

    helpers SubscribeHelper
  end
end
