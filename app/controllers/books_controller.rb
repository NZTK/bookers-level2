class BooksController < ApplicationController
  before_action :authenticate_user!
  def show

    @books = Book.find(params[:id])
    @book = Book.new
    #@user = User.find(params[:id])
    @user = User.find_by(id: current_user.id)
  end

  def index
    #@book = Book.all
    #@book = Book.find(params[:id])
    @book = Book.new
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

        if @book.save
          flash[:notice] = "Book was successfully created"
           redirect_to book_path(@book.id)
          else
           render :action =>"index"
        end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
      book = Book.find(params[:id])
      if book.update(book_params)
        flash[:notice] = "Book was successfully updated"
         redirect_to book_path(book.id)
       else
        render :action => "index"
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
