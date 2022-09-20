class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    # Дёргаем метод модели, который найдёт пользователя
    @user = User.github_from_omniauth(request.env['omniauth.auth'])
    # Если юзер есть, то логиним и редиректим на его страницу
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: 'Github')
      # Если неудачно, то выдаём ошибку и редиректим на главную
    else
      flash[:error] = I18n.t(
        'devise.omniauth_callbacks.failure',
        kind: 'Github',
        reason: 'authentication error'
      )
    end
  end

  def google_oauth2
    @user = User.google_oauth2_from_omniauth(request.env['omniauth.auth'])
    # Если юзер есть, то логиним и редиректим на его страницу
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: 'google_oauth2')
      # Если неудачно, то выдаём ошибку и редиректим на главную
    else
      flash[:error] = I18n.t(
        'devise.omniauth_callbacks.failure',
        kind: 'google_oauth2',
        reason: 'authentication error'
      )
    end
  end
end
