class BaseAPI < Grape::API
  format :json
  helpers ::Helpers::AuthHelpers
end
