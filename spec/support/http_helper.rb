module RspecHelpers
  module HttpHelper
    def json
      JSON.parse(response.body)
    end
  end
end
