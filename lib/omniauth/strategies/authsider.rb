# frozen_string_literal: true
require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Authsider < OmniAuth::Strategies::OAuth2
      option :name, 'authsider'

      option :client_options,
             token_url: '/oauth/token',
             user_info_url: '/userinfo',
             authorization_url: '/authorize'

      uid {
        raw_info['sub']
      }

      info do
        prune!(
          name: raw_info['name'],
          username: raw_info['username'],
          nickname: raw_info['nickname'],
          email: raw_info['email'],
          first_name: raw_info['given_name'],
          middle_name: raw_info['middle_name'],
          last_name: raw_info['family_name'],
          image: raw_info['picture'],
          gender: raw_info['gender'],
          locale: raw_info['locale']
        )
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def basic_auth_header
        'Basic ' + Base64.strict_encode64("#{options[:client_id]}:#{options[:client_secret]}")
      end

      def callback_url
        options[:redirect_uri] || (full_host + script_name + callback_path)
      end

      def raw_info
        @raw_info ||= access_token.get('/userinfo').parsed
      end

      def prune!(hash)
        hash.delete_if do |_, v|
          prune!(v) if v.is_a?(Hash)
          v.nil? || (v.respond_to?(:empty?) && v.empty?)
        end
      end
    end
  end
end