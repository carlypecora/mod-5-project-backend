class UsersController < ApplicationController

	 def index
    @users = User.all
    render json: @users
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def create
    
    user = User.new(email: params[:email], password: params[:password], first_name: params[:first_name], last_name: params[:last_name], bio: params[:bio], photo_url: params[:photo_url])
    conversation = Conversation.find(1)
    if user.save

      token = encode_token(user.id)
      user.conversations << conversation
      render json: {user: UserSerializer.new(user), token: token}
    else
      render json: {errors: user.errors.full_messages}
    end
  end

  def unreads
    byebug
  end

	private
		def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :bio, :photo_url, :program)
	end

end
