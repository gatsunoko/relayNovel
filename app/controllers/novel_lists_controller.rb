class NovelListsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_novel_list, only: [:show, :edit, :update, :destroy]

  def index
    @novel_lists = NovelList.all.order(created_at: :desc)
  end

  def show
    @max_number = @novel_list.novels.maximum(:number)
    if @max_number == @novel_list.novels.where(selected: true).maximum(:number)
      @latest = false
    else
      @latest = true
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

  # PATCH/PUT /novel_lists/1
  # PATCH/PUT /novel_lists/1.json
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

  # DELETE /novel_lists/1
  # DELETE /novel_lists/1.json
  def destroy
    @novel_list.destroy
    respond_to do |format|
      format.html { redirect_to novel_lists_url, notice: 'Novel list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_novel_list
      @novel_list = NovelList.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def novel_list_params
      params.require(:novel_list).permit(:title)
    end
end
