class UsersController < ApplicationController
  def index
    @users = User.left_joins(:books).select('users.*, COUNT(books.id) as books_count').group('users.id')
  end

  def show

    @user = User.find(params[:id])
   

  end

  def new
    @user = User.new

  end

  def edit

    @user = User.find(params[:id])

  end

   def update

    @user = User.find(params[:id])


    @user.update(user_params)

    redirect_to users_path(@user)

  end

  def destroy

    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_path
  end

  def user_params
    params.require(:user).permit(:name, :email, :date_of_birth)
  end

end
