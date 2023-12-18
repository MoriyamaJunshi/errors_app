class ErrorsController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
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
    @error.user = current_user
    
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
    @pagy, @errors = pagy(Error.where("content LIKE ?", "%#{search_word}%"))
    if @errors.any?
      flash.now[:notice] = "#{@errors.count}件のエラーが見つかりました。"
    else
      flash.now[:alert] = "エラーが見つかりませんでした。"
    end
    
    render 'index'
  end

  
  private

  # Strong Parameter
  
  def error_params
    params.require(:error).permit(:content, :message)
  end
  
  def correct_user
    @error = current_user.user_errors.find_by(id: params[:id])
    unless @error
      redirect_to root_url
    end
  end
end
