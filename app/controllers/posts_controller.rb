class PostsController < ApplicationController
  before_action :find_group
  before_action :find_post, only: [:edit, :update, :destroy]
  before_action :member_required, only: [:new, :create ]

  def new
    @post = @group.posts.new
  end

  def create
    @post = @group.posts.new(clean_params)
    @post.author = current_user

    if @post.save
      redirect_to group_path(@group),notice: "討論版文章新增成功"
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @post.update(clean_params)
      redirect_to group_path(@group), notice: "討論版文章修改成功"
    else
      render :edit
    end
  end

  def destroy
    redirect_to group_path(@group), alert: "討論板文章刪除成功" if @post.destroy
  end

  private
  def clean_params
    params.require(:post).permit(:content)
  end

  def find_group
    @group = Group.find_by(id: params[:group_id])
  end

  def find_post
    @post = current_user.posts.find_by(id: params[:id])
  end

  def member_required
    if !current_user.is_member_of?(@group)
      flash[:warning] = "你不是該討論版的成員，不能發文喔！"
      redirect_to group_path(@group)
    end
  end
end
