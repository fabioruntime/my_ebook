class EbooksController < ApplicationController

  def index
    ebooks = Ebook.all
    render :index, locals: { ebooks: ebooks }
  end

  def show
    ebook = Ebook.find(params[:id])
    render :show, locals: { ebook: ebook, authors: get_authors(ebook) }
  end

  def new
    render :new, locals: { ebook: Ebook.new }
  end

  def edit
    ebook = Ebook.find(params[:id])
    render :edit, locals: { ebook: ebook }
  end

  def create
    ebook = Ebook.new(ebook_params)
    ebook.save!
    redirect_to ebooks_path, notice:"Ebook created successfully"

  rescue StandardError => e
    flash[:danger] = "Error creating a new Ebook: #{e} "
    old_input = params
    render :new, locals: { ebook: nil, params: old_input }, status: :unprocessable_entity
  end

  def update
    ebook = Ebook.find(params[:id])
    ebook.update!(ebook_params)
    redirect_to ebook, notice: "Ebook was updated successfully."

  rescue StandardError => e
    flash[:danger] = "Error to update: #{e} "
    old_input = params
    render :edit, locals: { ebook: nil, params: old_input }, status: :unprocessable_entity
  end

  def destroy
    ebook = Ebook.find(params[:id])
    ebook.destroy
    redirect_to ebooks_path, status: :see_other, notice: "Ebook deleted successfully"
  end

  def manager_ebooks
    render :manager_ebooks, locals: { ebooks: Ebook.all }
  end

  def change_status
    if params[:status].present? && Ebook::statuses.include?(params[:status].to_sym)
      ebook = Ebook.find(params[:id])
      ebook.update(status: params[:status])
      redirect_to ebook, notice: "Status updated to #{ebook.status}"
    else
      render :manager_ebooks, status: :unprocessable_entity
    end
  end

  def book
    ebook = Ebook.find(params[:ebook_id])
    render :book, locals: { ebook: ebook }
  end

  private
  def get_authors(ebook)
    ebook.authors.map(&:name).join ', '
  end

  def ebook_params
    params.require(:ebook).permit(:title, :description, :date_release, :status, :image, :files)
  end

  def render_unpermitted_params_response
    render json: { "Unpermitted Parameters": params.to_unsafe_h.except(:controller, :action, :title, :description, :date_release, :status, :image).keys }, status: :unprocessable_entity
  end
end
