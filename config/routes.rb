Rails.application.routes.draw do

  scope '/api/v1' do
    resources :oppositions, only: :show
  end
end
