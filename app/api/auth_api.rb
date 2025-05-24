class AuthAPI < BaseAPI
  helpers do
    include Rails.application.routes.url_helpers
  end
  resource :auth do
    desc "User sign up"
    params do
      requires :email, type: String, desc: "User email"
      requires :password, type: String, desc: "User password"
      requires :company_id, type: Integer, desc: "Company ID"
      requires :avatar, type: File, desc: "User avatar"
    end
    post :signup do
      user = User.new(declared(params, include_missing: false).except(:avatar))
      if params[:avatar]
        user.avatar.attach(
          io: params[:avatar][:tempfile],
          filename: params[:avatar][:filename],
          content_type: params[:avatar][:type]
        )
      end

      if user.save
        token = JsonWebToken.encode(user_id: user.id)
        { message: "User created successfully", token: token }
      else
        error!({ error: user.errors.full_messages }, 422)
      end
    end

    desc "User login"
    params do
      requires :email, type: String, desc: "User email"
      requires :password, type: String, desc: "User password"
    end
    post :login do
      user = User.find_by(email: params[:email])
      if user&.authenticate(params[:password])
        token = JsonWebToken.encode(user_id: user.id)
        { token: token }
      else
        error!("Invalid email or password", 401)
      end
    end
  end
end
