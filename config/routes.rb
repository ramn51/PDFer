Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'converter#index'
  post 'convert', to: 'converter#convert'
  get 'download', to: 'converter#download'

end
