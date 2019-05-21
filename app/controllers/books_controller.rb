class BooksController < ApplicationController
  before_action :authenticate_user!
   before_action :current_user, only: [:edit, :update]
  def show

    @books = Book.find(params[:id])
    @book = Book.new
    @users = @books.user
    @user = User.find_by(id: current_user.id)
  end

  def index
    #@book = Book.all
    #@book = Book.find(params[:id])
    @book = Book.new
    #@user = User.find_by(id: current_user.id)
    @user = current_user
    @books = Book.all
  end

  def new
      @book = Book.new
  	  @user = User.new
  end

  def create
        @book = Book.new(book_params)
        @book.user_id = current_user.id
        @books = Book.all
        @user = current_user

        if @book.save
          flash[:notice] = "You have creatad book successfully."
           redirect_to book_path(@book.id)
        else
           render :action =>"index"
        end
  end

  def edit
    @book = Book.find(params[:id])
    #@book.user_id = current_user.id
    #@books = Book.new
    
      if @book.user.id != current_user.id

      redirect_to books_path
      end
  end

  def update
      @book = Book.find(params[:id])
      #@book.user_id = current_user.id
      if @book.update(book_params)
        flash[:notice] = "You have updated book successfully."
         redirect_to book_path(@book.id)
       else
        render :action => "edit"
      end
  end
 def destroy
        book = Book.find(params[:id])
        book.destroy
        redirect_to books_path
 end

  private
    def book_params
      params.require(:book).permit(:title, :body)
    end
    def user_params
        params.require(:user).permit(:name, :profile_image , :introduction)
    end

end

