require 'spec_helper'

describe SessionsController do
  it "should route /login to sessions#new" do
    { :get => '/login' }.should route_to(controller: 'sessions', action: 'new')
  end

  it "should route /login/new to sessions#create" do
    { :post => '/login/new' }.should route_to(controller: 'sessions', action: 'create')
  end

  it "should route /logout to sessions#destroy" do
    { :get => '/logout' }.should route_to(controller: 'sessions', action: 'destroy')
  end
end