module AlephAlpha
  class Client
    extend AlephAlpha::HTTP

    def initialize(access_token: nil, uri_base: nil, request_timeout: nil)
      AlephAlpha.configuration.access_token = access_token if access_token
      AlephAlpha.configuration.uri_base = uri_base if uri_base
      AlephAlpha.configuration.request_timeout = request_timeout if request_timeout
    end

    def version
      AlephAlpha::Client.get(path: "/version")
    end

    def tokens
      @tokens ||= AlephAlpha::Tokens.new
    end

    def models
      @models ||= AlephAlpha::Models.new
    end

    def users
      @users ||= AlephAlpha::Users.new
    end

    def completions(parameters: {}, nice: false)
      AlephAlpha::Client.json_post(path: "/complete?nice=#{nice}", parameters: parameters)
    end

    def embeddings(parameters: {}, nice: false)
      AlephAlpha::Client.json_post(path: "/embed?nice=#{nice}", parameters: parameters)
    end

    def semantic_embeddings(parameters: {}, nice: false)
      AlephAlpha::Client.json_post(path: "/semantic_embed?nice=#{nice}", parameters: parameters)
    end

    def evaluate(parameters: {}, nice: false)
      AlephAlpha::Client.json_post(path: "/evaluate?nice=#{nice}", parameters: parameters)
    end

    def explain(parameters: {}, nice: false)
      AlephAlpha::Client.json_post(path: "/explain?nice=#{nice}", parameters: parameters)
    end

    def tokenize(parameters: {})
      AlephAlpha::Client.json_post(path: "/tokenize", parameters: parameters)
    end

    def detokenize(parameters: {})
      AlephAlpha::Client.json_post(path: "/detokenize", parameters: parameters)
    end

    def qa(parameters: {}, nice: false)
      AlephAlpha::Client.json_post(path: "/qa?nice=#{nice}", parameters: parameters)
    end

    def summarize(parameters: {}, nice: false)
      AlephAlpha::Client.json_post(path: "/summarize?nice=#{nice}", parameters: parameters)
    end

    def permissions(parameters: [])
      AlephAlpha::Client.json_post(path: "/check_privileges", parameters: parameters)
    end
  end
end
