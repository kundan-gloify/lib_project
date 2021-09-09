class LibrariesController < ApplicationController
  before_action :authenticate_user!

  def index

    @libraries = Library.left_joins(:books).select('libraries.*, COUNT(books.id) as books_count').group('libraries.id')

  end

  def show

    @library = Library.left_joins(books: :user).select('books.id, books.title, books.published_at, users.id as user_id, users.name').where("libraries.id = #{ params[:id] }")
    
    @count = Library.joins('LEFT JOIN books ON libraries.id=books.library_id').select('COUNT(books.id) as books_count').where("libraries.id = #{ params[:id] }")

    @library_name = Library.find(params[:id])

    @books =  Book.where(library_id: [nil, ""])

 # render json: @count  

  end

  def new

    @library = Library.new

  end

  def create

    @library = Library.create(library_params)

    if @library.valid?

      redirect_to libraries_path, notice: "Library Added Successfully"

    else

      render :new
      # redirect_to new_library_path, notice: "Fill all the Mandatory fields"


    end
  end

  def edit

    @library = Library.find(params[:id])

  end

  def update
    

    @library = Library.find(params[:id])
    
    @library.update(library_params)

    redirect_to libraries_path(@library), notice: "Library Updated Successfully"
  end


  def destroy

    @library = Library.find(params[:id])


     
    @library.destroy

    redirect_to libraries_path, notice: "Library Deleted Successfully"
  end

    private

  def library_params
    params.require(:library).permit(:name, :opening_time, :closing_time)
  end
end
