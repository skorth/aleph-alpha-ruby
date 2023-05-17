module AlephAlpha
  class Tokens
    def initialize(access_token: nil)
      AlephAlpha.configuration.access_token = access_token if access_token
    end

    def list
      AlephAlpha::Client.get(path: "/users/me/tokens")
    end

    def create(parameters: {})
      AlephAlpha::Client.json_post(path: "/users/me/tokens", parameters: parameters)
    end

    def delete(id:)
      AlephAlpha::Client.delete(path: "/users/me/tokens/#{id}")
    end
  end
end
