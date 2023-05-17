module AlephAlpha
  module HTTP
    def get(path:)
      to_json(conn.get(uri(path: path)) do |req|
        req.headers = headers
      end&.body)
    end

    def json_post(path:, parameters:)
      to_json(conn.post(uri(path: path)) do |req|
        req.headers = headers
        req.body = parameters.to_json
      end&.body)
    end

    def json_patch(path:, parameters:)
      to_json(conn.patch(uri(path: path)) do |req|
        req.headers = headers
        req.body = parameters.to_json
      end&.body)
    end

    def delete(path:)
      to_json(conn.delete(uri(path: path)) do |req|
        req.headers = headers
      end&.body)
    end

    private

    def headers
      {
        "Content-Type" => "application/json",
        "Authorization" => "Bearer #{AlephAlpha.configuration.access_token}"
      }
    end

    def uri(path:)
      AlephAlpha.configuration.uri_base + path
    end

    def to_json(string)
      return unless string

      JSON.parse(string)
    rescue JSON::ParserError
      string
    end

    def conn
      Faraday.new do |f|
        f.options[:timeout] = AlephAlpha.configuration.request_timeout
      end
    end
  end
end
