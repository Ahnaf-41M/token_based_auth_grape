class UserAPI < BaseAPI
  format :json

  # With :: (absolute path):
  # Starts searching from the global/root namespace.
  # Always finds the top-level Helpers module.
  # Works regardless of what module/class this code is in.
  # If we don't use it, Could find a different Helpers
  # module if one exists in the current context.
  helpers ::Helpers::AuthHelpers

  resource :users do
    desc "Fetch all users"
    get do
      authenticate_user!
      present User.all, with: Entities::User, with_company: true
    end

    desc "Update current user"
    params do
      optional :email, type: String, desc: "New email"
      optional :password, type: String, desc: "New password"
      at_least_one_of :email, :password
    end
    patch do
      if current_user.update(declared(params, include_missing: false))
        present current_user, with: Entities::User
      else
        error!({ error: current_user.errors.full_messages }, 422)
      end
    end
  end
end
