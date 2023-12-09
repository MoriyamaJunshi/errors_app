class ErrorsController < ApplicationController
  
  def index
    @errors = Error.all
  end
  
  def show
    @error = Error.find(params[:id])
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
    @error = Error.find(params[:id])
  end

  def update
    @error = Error.find(params[:id])

    if @error.update(error_params)
      flash[:success] = 'エラーメッセージ は正常に更新されました'
      redirect_to @error
    else
      flash.now[:danger] = 'エラーメッセージは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @error = Error.find(params[:id])
    @error.destroy

    flash[:success] = 'エラーメッセージは正常に削除されました'
    redirect_to errors_url
  end

  private

  # Strong Parameter
  def error_params
    params.require(:error).permit(:content)
  end
end
