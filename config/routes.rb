Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'scrapper#index'
  post 'scrapper/get_words_count' => "scrapper#get_words_count"

end
