class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def confirm
    if params[:contact].blank?
      redirect_to new_contacts_path, alert: "もう一度入力してください"
      return
    end
  
    @contact = Contact.new(contact_params)
    render :new unless @contact.valid?
  end


  def thanks
    if request.post?
      @contact = Contact.new(contact_params)
      if @contact.valid?
        # メール送信などの処理
        render :thanks
      else
        render :new
      end
    else
      # GETリクエストなら単純に完了画面を表示
      # @contactが不要なら空でOK
      render :thanks
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
