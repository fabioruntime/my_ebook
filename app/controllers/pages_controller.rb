class PagesController < ApplicationController
  def home
    ebooks_top = Ebook.joins(:users).group('ebooks.id').order('count(ebooks.id) DESC').limit(6).count

    render :home, locals: { ebooks_top: get_ebooks_by_id(ebooks_top), ebooks_coming: Ebook.coming }
  end

  private
  def get_ebooks_by_id(ebook_ids)
    ebooks = []
    ebook_ids.each do |key, value|
      e = Ebook.find(key)
      ebooks << e
    end
    ebooks
  end
end
