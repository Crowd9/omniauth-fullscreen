# OmniAuth Fullscreen Strategy

Strategy to authenticate with Fullscreen via OAuth2 in OmniAuth.

## Installation

Add to your `Gemfile`:

```ruby
gem "omniauth-fullscreen"
```
Then `bundle install`.

## Usage

Here's an example, adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :fullscreen, ENV["FULLSCREEN_KEY"], ENV["FULLSCREEN_SECRET"]
end
```

You can now access the OmniAuth Google OAuth2 URL: `/auth/fullscreen`

### Devise

For devise, you should also make sure you have an OmniAuth callback controller setup

```ruby
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def fullscreen
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.find_for_fullscreen_oauth(request.env["omniauth.auth"], current_user)

      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Fullscreen"
        sign_in_and_redirect @user, :event => :authentication
      else
        session["devise.google_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
  end
end
```

and bind to or create the user

```ruby
def self.find_for_fullscreen_oauth(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
        user = User.create(name: data["name"],
             email: data["email"],
             password: Devise.friendly_token[0,20]
            )
    end
    user
end
```
## Configuration

You can configure several options, which you pass in to the `provider` method via a hash:

## Auth Hash

Here's an example of an authentication hash available in the callback by accessing `request.env["omniauth.auth"]`:

```ruby
{
    :provider => "fullscreen",
    :uid => 12345,
    :info => {
        :email => "john@company_name.com",
        :first_name => "John",
        :last_name => "Doe"
    },
    :credentials => {
        :token => "token",
        :refresh_token => "another_token",
        :expires_at => 1354920555,
        :expires => true
    }
}
```

## License

Copyright (c) 2013 Sean Stavropoulos

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

