require 'omniauth-oauth2'
require 'coinbase/wallet'

module OmniAuth
  module Strategies
    class Coinbase < OmniAuth::Strategies::OAuth2
      PRODUCTION_URLS = {
        :site => 'https://www.coinbase.com',
        :api => 'https://api.coinbase.com',
        :authorize_url => 'https://www.coinbase.com/oauth/authorize',
        :token_url => 'https://www.coinbase.com/oauth/token',
      }

      # Options
      option :name, 'coinbase'
      option :client_options, {
              :proxy => ENV['http_proxy'] ? URI(ENV['http_proxy']) : nil,
              :ssl => {
                :verify => true,
                :cert_store => ::Coinbase::Wallet::APIClient.whitelisted_certificates
              }
      }
      option :authorize_options, [:scope, :layout, :account, :meta]

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
        client = ::Coinbase::Wallet::OAuthClient.new(access_token: access_token.token, api_url: PRODUCTION_URLS[:api])
        @raw_info ||= client.current_user
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end

      def request_phase
        load_coinbase_urls
        super
      end

      def callback_phase
        load_coinbase_urls
        super
      end

      def load_coinbase_urls
        options.client_options = (PRODUCTION_URLS).merge(options.client_options)
      end

      def callback_url
        options[:redirect_uri] || (full_host + script_name + callback_path)
      end
    end
  end
end
