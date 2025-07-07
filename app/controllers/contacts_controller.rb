class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(contact_params)
  
    # 戻るボタンが押された場合のみ new に戻る
    if params[:back_button]
      render :new
    elsif @contact.valid?
      # 問題なければ確認画面を表示
      render :confirm
    else
      # バリデーション失敗
      render :new
    end
  end


  def thanks
    if request.post?
      if params[:back_button]
        # 戻るボタンが押されたら new に戻る
        @contact = Contact.new(contact_params) # 入力値を保持したい場合
        render :new
        return
      end
  
      @contact = Contact.new(contact_params)
      if @contact.valid?
        # 送信処理
        redirect_to thanks_contacts_path # GETリクエストで完了画面へ
      else
        render :new
      end
    else
      # GETは完了画面表示
      render :thanks
    end
  end


  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
