class ErrorsController < ApplicationController
  before_action :set_error, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    @pagy, @errors = pagy(Error.all)
  end
  
  def show
  end
  
  def new
    @error = Error.new
  end
  
  def create
    @error = Error.new(error_params)
    
    if @error.save
      flash[:success] = 'エラーメッセージが正常に登録されました'
      redirect_to @error
    else
      flash.now[:danger] = 'エラーメッセージが登録されませんでした'
      render :new
    end
  end
  
  def edit
  end

  def update
    if @error.update(error_params)
      flash[:success] = 'エラーメッセージ は正常に更新されました'
      redirect_to @error
    else
      flash.now[:danger] = 'エラーメッセージは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @error.destroy

    flash[:success] = 'エラーメッセージは正常に削除されました'
    redirect_to errors_url
  end

  def search
    search_word = params[:word]
    @error = Error.where("content LIKE ?", "%#{search_word}%")
    if @errors.count > 0
      flash.now[:notice] = "#{@errors.cont}件のエラーが見つかりました。"
    else
      flash.now[:alert] = "#エラーが見つかりませんでした。"
    end
  end
  
  private

  # Strong Parameter
  
  def set_error
    @error = Error.find(params[:id])
  end
  
  def error_params
    params.require(:error).permit(:content, :message)
  end
end
