class Users::ConfirmationsController < Devise::ConfirmationsController
  layout 'login'
  
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      set_flash_message!(:notice, :confirmed)
      redirect_to confirma_email_confirmations_path
    else
      respond_with_navigational(resource.errors, status: :unprocessable_entity) { render :new }
    end
  end

  def confirma_email
  end
end
