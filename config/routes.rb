Rails.application.routes.draw do
  root to: 'recipes#home'  # トップはhomeに

  resources :recipes do
    member do
      get :read  # 読み上げモード
    end
  end
end