class NovelsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :selected]
  before_action :set_novel, only: [:show, :edit, :update, :destroy, :selected]
  before_action :list_is_mine, only: [:selected]

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
    @novel.destroy
    respond_to do |format|
      format.html { redirect_to novels_url, notice: 'Novel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def selected
    if list_is_mine
      @novel.update(selected: true)
    end
    redirect_to novel_list_path(@novel.novel_list)
  end

  private
    def set_novel
      @novel = Novel.find(params[:id])
    end

    def novel_params
      params.require(:novel).permit(:text, :novel_list_id)
    end

    def list_is_mine
      if @novel.novel_list.user_id != current_user.id
        return false
      else
        return true
      end
    end
end
