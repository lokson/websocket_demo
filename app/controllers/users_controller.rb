class UsersController < ApplicationController
  layout false
  expose :users
  expose :user, attributes: :user_params

  def update
    user.save!
  end

  def user_params
    params.require(:user).permit :name
  end
end