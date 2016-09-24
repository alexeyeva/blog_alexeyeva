class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like]
  before_action :find_comments, only: :show
  before_action :find_blog, only: [:show, :edit, :update]


  # GET /posts
  # GET /posts.json
  def index
    # raise params.inspect
    @q = Post.ransack(params[:q])
    @posts = @q.result.includes(:post_info, :tags).order("post_infos.rating DESC").order(created_at: :asc).to_a.uniq
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    views = @post.post_info.views + 1
    @post.post_info.update(views: views)

    @comment = Comment.new
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    @post.user = current_user
    @post.blog_id = params[:blog_id]

    @blog = Blog.find(params[:blog_id])

    @post.tag_ids = params[:post][:tags].delete_if { |a| a == "" }

    if params[:post][:new_tags]

      @tag_names = params[:post][:new_tags].split(/\W+/)

      @tag_names.map { |tag_name| Tag.new(name: tag_name, post_ids: [@post.id]).save }

    end

    if @post.save
      redirect_to @post.blog, notice: 'Post was successfully created.'
      send_mails
    else
      render :new
    end
  end

  def like
    @likes = @post.post_info.likes + 1
    @post.post_info.update(likes: @likes)
    redirect_to @post.blog
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def find_blog
      @blog = @post.blog
    end

    def find_comments
      @comments = @post.comments.order(created_at: :desc)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :text, :tags)
    end

    def send_mails
      @blog = @post.blog
      @blog.users.each do |user|
        UserMailer.new_post_email(user, @blog).deliver_now
      end
    end
end
