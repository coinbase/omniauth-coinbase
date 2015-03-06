require 'omniauth-oauth2'
require 'coinbase'

module OmniAuth
  module Strategies
    class Coinbase < OmniAuth::Strategies::OAuth2
      option :name, 'coinbase'
      option :client_options, {
              :site => 'https://coinbase.com',
              :proxy => ENV['http_proxy'] ? URI(ENV['http_proxy']) : nil,
              :ssl => {
                :verify => true,
                :cert_store => ::Coinbase::Client.whitelisted_cert_store
              }
      }
      option :authorize_options, [:scope, :meta]


      uid { raw_info['id'] }

      info do
        {
          :id => raw_info['id'],
          :name => raw_info['name'],
          :email => raw_info['email']
        }
      end

      extra do
        { :raw_info => raw_info }
      end

      def raw_info
        # Hack to get sandbox to work
        sandbox = access_token.client.site === "https://sandbox.coinbase.com"
        access_token.client.site = "https://api.sandbox.coinbase.com" if sandbox
        user_info_path = "#{sandbox ? nil : '/api'}/v1/users/self"
        @raw_info ||= MultiJson.load(access_token.get(user_info_path).body)['user']
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end

    end
  end
end
