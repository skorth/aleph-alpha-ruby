module AlephAlpha
  class Models
    def initialize(access_token: nil)
      AlephAlpha.configuration.access_token = access_token if access_token
    end

    def list
      AlephAlpha::Client.get(path: "/models_available")
    end
  end
end
