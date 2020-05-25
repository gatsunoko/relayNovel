class NovelListsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_novel_list, only: [:show, :edit, :update, :destroy]
  before_action :is_mine, only: [:edit, :update, :destroy]

  def index
    @novel_lists = NovelList.all.includes(:novels).order('novels.updated_at desc')
  end

  def show
    impressionist(@novel_list, nil, unique: [:session_hash])
    @max_number = @novel_list.novels.maximum(:number)
    if @max_number == @novel_list.novels.where(selected: true).maximum(:number)
      @latest = false
    else
      @latest = true
    end

    respond_to do |format|
      format.html { render :show }
      format.json { render :show }
    end
  end

  def new
    @novel_list = NovelList.new
    @novel_list.novels.build
  end

  def edit
  end

  def create
    @novel_list = NovelList.new(novel_list_params)
    @novel_list.user_id = current_user.id
    @novel_list.novels.build
    @novel_list.novels[0].user_id = current_user.id
    @novel_list.novels[0].text = params[:novel_list][:novels][:text]
    @novel_list.novels[0].selected = true
    @novel_list.novels[0].number = 1

    respond_to do |format|
      if @novel_list.save
        format.html { redirect_to @novel_list, notice: 'Novel list was successfully created.' }
        format.json { render :show, status: :created, location: @novel_list }
      else
        format.html { render :new }
        format.json { render json: @novel_list.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @novel_list.update(novel_list_params)
        format.html { redirect_to @novel_list, notice: 'Novel list was successfully updated.' }
        format.json { render :show, status: :ok, location: @novel_list }
      else
        format.html { render :edit }
        format.json { render json: @novel_list.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @novel_list.destroy
    respond_to do |format|
      format.html { redirect_to novel_lists_url, notice: 'Novel list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_novel_list
      @novel_list = NovelList.find(params[:id])
    end

    def novel_list_params
      params.require(:novel_list).permit(:title, :thumbnail)
    end

    def is_mine
      if @novel_list.user_id != current_user.id
        redirect_back(fallback_location: root_path) and return
      end
    end
end
