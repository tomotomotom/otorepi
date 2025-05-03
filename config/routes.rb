Rails.application.routes.draw do
  root to: 'recipes#home'  # トップはhomeに

  devise_for :users  # ←これを追加！

  resources :recipes do
    member do
      get :read  # 読み上げモード
    end
  end
end
