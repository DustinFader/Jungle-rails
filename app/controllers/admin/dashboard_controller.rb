class Admin::DashboardController < ApplicationController
  def show
    @categories = Category.all.count
    @products = Product.all.count
  end
end
