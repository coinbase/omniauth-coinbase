require 'omniauth-oauth2'
require 'coinbase/wallet'

module OmniAuth
  module Strategies
    class Coinbase < OmniAuth::Strategies::OAuth2
      option :name, 'coinbase'
      option :client_options, {
              :site => 'https://www.coinbase.com',
              :authorize_url => 'https://www.coinbase.com/oauth/authorize',
              :token_url => 'https://www.coinbase.com/oauth/token',
              :proxy => ENV['http_proxy'] ? URI(ENV['http_proxy']) : nil,
              :ssl => {
                :verify => true,
                :cert_store => ::Coinbase::Wallet::APIClient.whitelisted_certificates
              }
      }
      option :authorize_options, [:scope, :meta]


      uid { raw_info.id }

      info do
        {
          :id => raw_info.id,
          :name => raw_info.name
        }
      end

      extra do
        { :raw_info => raw_info }
      end

      def raw_info
        client = ::Coinbase::Wallet::OAuthClient.new(access_token: access_token.token)
        @raw_info ||= client.current_user
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end
    end
  end
end
