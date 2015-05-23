module Bravo
  class Authorization
    @authorized_cuits = []

    def self.for(cuit)
      credentials = @authorized_cuits.find { |authorization| authorization.cuit == cuit }
      raise ::Bravo::MissingCredentials.new, "missing credentials for #{ cuit }" unless credentials
      credentials
    end
  end
end
