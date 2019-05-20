class UsersController < ApplicationController
	before_action :authenticate_user!
	#before_filter :correct_user,   only: [:edit, :update, :show, :index, :create, :new, ]
  def show

  	@user = User.find(params[:id])
  	#render template: "books/show"
  	@books = Book.where(user_id: @user.id)
  	@book = Book.new


  end
  def index
	@users = User.all
	@user = current_user
	#@users = User.all
  	#@user = User.find(params[:id])
  	@book = Book.new
  	#@books = Book.where(user_id: @user.id)
  end
  def create
        @book = Book.new(book_params ,user_id: @current_user.id)
        @book.user_id = current_user.id

        if @book.save
          flash[:notice] = "Book was successfully created"
           redirect_to book_path(@book.id)
          else
           render :action =>"index"
        end
  end
  def new
  	@user = User.new
  	@book = Book.new
  end
  def edit
    @user = User.find(params[:id])
    @user_id = current_user.id

  end
  def update
  	@user = User.find(params[:id])
    if @user.update(user_params)
    	flash[:notice] = "You have updated user successfully."
    	redirect_to user_path(@user.id)
    else
    	render :action =>"edit"
    end
  end
  def ensure_correct_user
    @user = User.find_by(id:params[:id])
    if @user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to user_path(@user.id)
    end
  end
  private
  def correct_user
      @user = User.find(params[:id])
      redirect_to(user_path) unless current_user?(@user)
    end
def user_params
    params.require(:user).permit(:name, :profile_image , :introduction)
end
def book_params
      params.require(:book).permit(:title, :body)
    end
end
