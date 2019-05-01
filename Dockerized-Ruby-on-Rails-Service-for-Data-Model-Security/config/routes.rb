# frozen_string_literal: true

Rails.application.routes.draw do
  resources :user_content_privileges
  resources :external_user_groups
end
