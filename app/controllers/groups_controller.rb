class GroupsController < ApplicationController
  before_action :find_group, only: [:edit, :update, :destroy]
  before_action :user_showall, only: [:index, :show]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.groups.new(clean_params)
    if @group.save
      current_user.join!(@group)
      redirect_to groups_path
    else
      render :new
    end
  end

  def show
    @group = Group.find_by(id: params[:id])
    @posts = @group.posts
  end

  def edit

  end

  def update
    if @group.update(clean_params)
      redirect_to groups_path, notice: "修改討論板成功"
    else
      render :edit
    end
  end

  def destroy
    if @group.destroy
      redirect_to groups_path, alert: "刪除討論板成功"
    else
    end
  end

  def join
    @group = Group.find_by(id: params[:id])

    if !current_user.is_member_of?(@group)
      current_user.join!(@group)
      flash[:notice] = "您已成功加入此討論版"
    else
      flash[:warning] = "您已經是此討論板成員了！"
    end

    redirect_to groups_path(@group)
  end

  def quit
    @group = Group.find_by(id: params[:id])

    if current_user.is_member_of?(@group)
      current_user.quit!(@group)
      flash[:notice] = "您已成功離開此討論版"
    else
      flash[:warning] = "您不是此討論版的會員，又怎麼能退出，ㄏㄏ"
    end

    redirect_to groups_path(@group)
  end

  private
  def clean_params
    params.require(:group).permit(:title, :description)
  end

  def find_group
    @group = current_user.groups.find_by(id: params[:id])
  end

  def user_showall
    @users = User.all
  end
end
