class Foster::FostersController < ApplicationController
  before_action :authenticate_foster!

  def show
    @foster = Foster.find(params[:id])
  end

  def edit
    @foster = Foster.find(params[:id])
  end

  def update
    @foster = Foster.find(current_foster.id)
    if @foster.update(foster_params)
      flash[:notice] = "登録情報を変更しました"
      redirect_to foster_foster_path
    else
      flash[:alert] = "登録情報を変更できませんでした"
      render :edit
    end
  end

  def out
    @foster = Foster.find(current_foster.id)
    @foster.update(is_deleted: true)
    reset_session
    flash[:notice] = "ありがとうございました！またのご利用お待ちしております。"
    redirect_to root_path
  end

  private

  def foster_params
    params.require(:foster).permit(:last_name, :first_name, :telephone_number, :postal_code,
                                   :address, :email)
  end
end
