class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: 'Github')
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:error] = I18n.t(
        'devise.omniauth_callbacks.failure',
        kind: 'Github',
        reason: 'authentication error'
      )
    end
  end

  def yandex
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: 'yandex')
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:error] = I18n.t(
        'devise.omniauth_callbacks.failure',
        kind: 'yandex',
        reason: 'authentication error'
      )
    end
  end
end
