module Keymaker
  class ExecuteGremlinRequest < Request
    def submit
      service.post(full_gremlin_path, opts).on_error do |response|
        case response.status
        when (400..499)
          raise ClientError.new(response, response.body)
        when (500..599)
          raise ServerError.new(response, response.body)
        end
      end
    end
  end
end
