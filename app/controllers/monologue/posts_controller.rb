<<<<<<< HEAD
class Monologue::PostsController < Monologue::ApplicationController
  caches_action :index, :show, :feed, :expires_in => 96.hours, if: Proc.new { monologue_page_cache_enabled? }

  before_filter :recent_posts, :all_tags

  def index
    @page = params[:page].nil? ? 1 : params[:page]
    @posts = Monologue::Post.published.page(@page)
  end

  def show
    if monologue_current_user
      @post = Monologue::Post.default.where("monologue_posts_revisions.url = :url", {url: params[:post_url]}).first
    else
      @post = Monologue::Post.published.where("monologue_posts_revisions.url = :url", {url: params[:post_url]}).first
    end
    if @post.nil?
      not_found
      return
    end
    @revision = @post.active_revision
  end

  def feed
    @posts = Monologue::Post.published.limit(25)
  end
end
=======
class Monologue::PostsController < Monologue::ApplicationController
  def index
    @page = params[:page].nil? ? 1 : params[:page]
    @posts = Monologue::Post.page(@page).includes(:user).published
  end

  def show
    if monologue_current_user
      @post = Monologue::Post.default.where("url = :url", {url: params[:post_url]}).first
    else
      @post = Monologue::Post.published.where("url = :url", {url: params[:post_url]}).first
    end
    if @post.nil?
      not_found
    end
  end

  def feed
    @posts = Monologue::Post.published.limit(25)
    if params[:tags].present?
      tags = Monologue::Tag.where(name: params[:tags].split(",")).pluck(:id)
      @posts = @posts.joins(:taggings).where("monologue_taggings.tag_id in (?)", tags)
    end
    render 'feed', layout: false
  end
end
>>>>>>> jipiboily/master
