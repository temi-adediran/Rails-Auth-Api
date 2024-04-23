class AccountsController < ApplicationController
  skip_before_action :authenticate!
  # before_action :set_params_variables
  # attr_reader :name, :email, :password

  def signup
    return handle_bad_authentication unless name && email && password
    account = User.new(account_params)

    if account.save
      set_token_in_header
      render json: {name: name, email: email}, status: :created
    else
      render json: account.errors, status: :unprocessable_entity
    end
  end

  def login
    return handle_bad_authentication unless email && password
    return handle_not_found unless user
    return handle_incorrect_password unless password == user.password

    set_token_in_header
    render json: {message: "Login successful."}, status: :ok
  end

  def logout
    return handle_bad_authentication unless email && password
    return handle_not_found unless user
    return handle_incorrect_password unless password == user.password

    user.update(token: nil)
    render json: { message: "Logout successful."}, status: :ok
  end

  private

  def email
    params[:data][:email]
  end

  def password
    params[:data][:password]
  end

  def name
    params[:data][:name]
  end

  # def set_params_variables
  #   %i(name email password).map{|x| instance_variable_set("@#{x}", "params[:data][:#{x}]")}
  # end

  def set_token_in_header
    response.headers['Authorization'] = user.token
  end

  def user
    User.find_by_email(email)
  end

  def handle_incorrect_password
    render json: {message: "Incorrect credentials."}, status: :unauthorized
  end

  def handle_bad_authentication
    render json: { message: "Bad credentials" }, status: :unauthorized
  end

  def account_params
    params.require(:data).permit(:email, :name, :password)
  end
end
