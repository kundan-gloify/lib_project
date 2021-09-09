class BooksController < ApplicationController

  def index

    if current_user.role == 'admin'

    @books = Book.left_joins(:user).select('books.*, users.name')

  else

    # @books = Book.joins(:user).select('books.*, users.name').where("users.id = #{ current_user.id }")

    @books = Library.joins("RIGHT OUTER JOIN books ON books.library_id = libraries.id LEFT OUTER JOIN users on users.id = books.user_id").select('books.*, users.name, libraries.name as library_name').where("books.user_id = #{ current_user.id }")

    end
  end

  def show

    @book = Book.left_joins(:user).select('books.id, books.title, books.published_at, books.language, users.name').where("books.id = #{ params[:id] }")

    @book_name = Book.find(params[:id])

     # render json: @book_name
  end

  def new

     @book = Book.new
     # @authors = User.where(role: :author)


  end

   def create

    @book = Book.create(book_params)

    if @book.valid?

      redirect_to books_path, notice: "Book Added Successfully"

    else
      render :new

      # redirect_to new_book_path, notice: "Fill all the Mandatory fields"

    end
  end

  def edit

    @book = Book.find(params[:id])
    @authors = User.all


  end

  def update

    if params[:book][:book_id].present?

      @book = Book.find(params[:book][:book_id])

    else
      @book = Book.find(params[:id])

    end

    
    if params[:book][:library_hidden_id].present?

    @library = Library.find(params[:book][:library_hidden_id])

    end


    @book.update(book_params)

    @user_id = @book.user_id


    if @user_id.present?

    @user = User.find(@user_id)

    BookUpdateMailer.send_bookupdate_email(@user).deliver_now
    
    end
    


    if @library.present?

      redirect_to library_path(@library), notice: "Book Added / Removed Successfully"

    else

      redirect_to books_path(@book), notice: "Book Updated Successfully"

    end



  end

   def destroy

    @book = Book.find(params[:id])
    @book.destroy

    redirect_to books_path, notice: "Book Deleted Successfully"
  end

  def book_params
    params.require(:book).permit(:title, :published_at, :language, :user_id, :library_id)
  end

end
