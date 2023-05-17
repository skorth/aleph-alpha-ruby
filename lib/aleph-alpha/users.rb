module AlephAlpha
  class Users
    def initialize(access_token: nil)
      AlephAlpha.configuration.access_token = access_token if access_token
    end

    def me
      AlephAlpha::Client.get(path: "/users/me")
    end

    def usage
      AlephAlpha::Client.get(path: "/users/me/requests")
    end

    def settings(parameters: {})
      AlephAlpha::Client.json_patch(path: "/users/me", parameters: parameters)
    end
  end
end
