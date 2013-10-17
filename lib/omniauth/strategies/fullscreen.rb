require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Fullscreen < OmniAuth::Strategies::OAuth2
      option :name, 'fullscreen'

      option :authorize_options, [:state, :prompt, :scope]

      option :client_options, {
        site:           'https://accounts.fullscreen.net',
        authorize_url:  '/auth/authorize',
        token_url:      '/auth/token'
      }

      ##
      # You can pass +state+ param to the auth request, if
      # you need to set them dynamically. You can also set these options
      # in the OmniAuth config :authorize_params option.
      #
      # /auth/fullscreen?state=ABC
      #
      def authorize_params
        super.tap do |params|
          %w[state].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]

              # to support omniauth-oauth2's auto csrf protection
              session['omniauth.state'] = params[:state] if v == 'state'
            end
          end
        end
      end

      uid { user_info['id'] }

      info do
        {
          first_name:  user_info['info']['first_name'],
          last_name:   user_info['info']['last_name'],
          email:       user_info['info']['email']
        }
      end

      extra do
        { 
          user_info: user_info
        }
      end

      def user_info
        @raw_info ||= @access_token.get("/auth/user.json").parsed
      end

    end
  end
end

OmniAuth.config.add_camelization 'fullscreen', 'Fullscreen'