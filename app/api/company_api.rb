class CompanyAPI < BaseAPI
  format :json

  # With :: (absolute path):
  # Starts searching from the global/root namespace.
  # Always finds the top-level Helpers module.
  # Works regardless of what module/class this code is in.
  # If we don't use it, Could find a different Helpers
  # module if one exists in the current context.
  include ::Helpers::AuthHelpers

  resources :companies do
    desc "Get all companies"
    get do
      authenticate_user!
      present Company.all, with: Entities::Company, with_users: true
    end

    desc "Create a company"
    params do
      requires :name, type: String, desc: "Company name"
      requires :industry, type: String, desc: "Company industry"
      optional :address, type: String, desc: "Company address"
    end
    post do
      company = Company.new(declared(params, include_missing: false))
      if company.save
        present company, with: Entities::Company
      else
        error!({ error: company.errors.full_messages }, 422)
      end
    end
  end
end
