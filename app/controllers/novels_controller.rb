class NovelsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :selected, :like]
  before_action :set_novel, only: [:show, :edit, :update, :destroy, :selected]
  before_action :list_is_mine, only: [:selected]
  before_action :is_mine, only: [:edit, :update, :destroy]

  def index
    @novels = Novel.all
  end

  def show
  end

  def new
    @novel = Novel.new
    @novel.novel_list_id = params[:novel_list_id]
  end

  def edit
  end

  def create
    @novel = Novel.new(novel_params)
    @novel.user_id = current_user.id
    #現在いくつのNovelが登録されているか +1 をnumberに保存
    novel_list = NovelList.find(@novel.novel_list_id)
    if novel_list.novels.where(selected: true).count > 0
      number = novel_list.novels.where(selected: true).maximum(:number) + 1
    else
      number = 1
    end
    @novel.number = number

    respond_to do |format|
      if @novel.save
        format.html { redirect_to novel_list_path(@novel.novel_list.id), notice: 'Novel was successfully created.' }
        format.json { render :show, status: :created, location: @novel }
      else
        format.html { render :new }
        format.json { render json: @novel.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @novel.update(novel_params)
        format.html { redirect_to novel_list_path(@novel.novel_list.id), notice: 'Novel was successfully updated.' }
        format.json { render :show, status: :ok, location: @novel }
      else
        format.html { render :edit }
        format.json { render json: @novel.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    novel_list = @novel.novel_list.id
    @novel.destroy
    respond_to do |format|
      format.html { redirect_to novel_list_path(novel_list), notice: 'Novel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def selected
    if list_is_mine
      @novel.update(selected: true)
    end
    redirect_to novel_list_path(@novel.novel_list)
  end

  def like
    if NovelLike.where('user_id = ? AND novel_id = ?', current_user.id, params[:id]).count == 0
      NovelLike.create(user_id: current_user.id, novel_id: params[:id])
    else
      like = NovelLike.where('user_id = ? AND novel_id = ?', current_user.id, params[:id])
      like.destroy_all
    end
    @novel = Novel.find params[:id]
  end

  private
    def set_novel
      @novel = Novel.find(params[:id])
    end

    def novel_params
      params.require(:novel).permit(:text, :novel_list_id, :image)
    end

    def is_mine
      if @novel.user_id != current_user.id && @novel.novel_list.user_id != current_user.id
        redirect_back(fallback_location: root_path) and return
      end
    end

    def list_is_mine
      if @novel.novel_list.user_id != current_user.id
        return false
      else
        return true
      end
    end
end
