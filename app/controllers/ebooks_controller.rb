class EbooksController < ApplicationController
  before_action :set_ebook, only: [:show, :edit, :update, :destroy]

  def index
    @ebooks = Ebook.all
  end

  def show
    @authors = get_authors
  end

  def new
    @ebook = Ebook.new
  end

  def edit
  end

  def create
    @ebook = Ebook.new(ebook_params)
    if @ebook.save
      flash[:notice] = "Ebook created successfully"
      redirect_to ebooks_path
    else
      render 'new'
    end
  end

  def update
    if @ebook.update(ebook_params)
      flash[:notice] = "Ebook was updated successfully."
      redirect_to @ebook
    else
      render 'edit'
    end
  end

  def destroy
    byebug
    @ebook.destroy
    flash[:notice] = "Ebook deleted successfully"
    redirect_to ebooks_path
  end

  private
  def get_authors
    @ebook.authors.map(&:name).join ', '
  end

  def set_ebook
    @ebook = Ebook.find(params[:id])
  end

  def ebook_params
    params.require(:ebook).permit(:title, :description, :date_release)
  end

end
