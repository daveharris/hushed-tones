require 'spec_helper'

describe SessionsController do
  it "should route /login to sessions#new" do
    expect({ :get => '/login' }).to route_to(controller: 'sessions', action: 'new')
  end

  it "should route /login/new to sessions#create" do
    expect({ :post => '/login/new' }).to route_to(controller: 'sessions', action: 'create')
  end

  it "should route /logout to sessions#destroy" do
    expect({ :get => '/logout' }).to route_to(controller: 'sessions', action: 'destroy')
  end
end