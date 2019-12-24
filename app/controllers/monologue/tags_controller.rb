<<<<<<< HEAD
class Monologue::TagsController < Monologue::ApplicationController
  caches_action :show, :expires_in => 96.hours, if: Proc.new { monologue_page_cache_enabled? }

  before_filter :recent_posts, :all_tags

  def show
    @tag = retrieve_tag
    if @tag
      @page = nil
      @posts = @tag.posts_with_tag
    else
      redirect_to :root ,notice: "No post found with label \"#{params[:tag]}\""
    end
  end

  private
  def retrieve_tag
    Monologue::Tag.where("lower(name) = ?", params[:tag].downcase).first
  end
end
=======
class Monologue::TagsController < Monologue::ApplicationController
  def show
    @tag = retrieve_tag
    if @tag
      @page = nil
      @posts = @tag.posts_with_tag
    else
      redirect_to :root ,notice: "No post found with label \"#{params[:tag]}\""
    end
  end

  private
  def retrieve_tag
    Monologue::Tag.where("lower(name) = ?", params[:tag].mb_chars.to_s.downcase).first
  end
end
>>>>>>> jipiboily/master
