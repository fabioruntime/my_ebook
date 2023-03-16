class EbooksController < ApplicationController
  before_action :set_ebook, only: [:show, :edit, :update, :destroy, :change_status]

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

  def manager_ebooks
    @ebooks = Ebook.all
  end

  def create
    @ebook = Ebook.new(ebook_params)
    if @ebook.save
      flash[:notice] = "Ebook created successfully"
      redirect_to ebooks_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @ebook.update(ebook_params)
      flash[:notice] = "Ebook was updated successfully."
      redirect_to @ebook
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @ebook.destroy
    flash[:notice] = "Ebook deleted successfully"
    redirect_to ebooks_path, status: :see_other
  end

  def change_status
    if params[:status].present? && Ebook::statuses.include?(params[:status].to_sym)
      @ebook.update(status: params[:status])
      redirect_to @ebook, notice: "Status updated to #{@ebook.status}"
    else
      render :manager_ebooks, status: :unprocessable_entity
    end
  end

  private
  def get_authors
    @ebook.authors.map(&:name).join ', '
  end

  def set_ebook
    @ebook = Ebook.find(params[:id])
  end

  def ebook_params
    params.require(:ebook).permit(:title, :description, :date_release, :status)
  end

end
