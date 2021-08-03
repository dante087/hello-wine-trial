class Api::V1::OrdersController < ApplicationController
  before_action :set_order, only: %i[show update destroy]

  # GET /orders
  def index
    search_by_date = params[:delivery_date]
    render json: search_by_date ? Order.filter_by_delivery_date(search_by_date) : Order.all
  end

  # GET /orders/1
  def show
    render json: @order
  end

  # POST /orders
  def create
    order = Order.new(order_params)
    if order.save
      render json: order, status: 201
    else
      render json: { errors: order.errors }, status: 422
    end
  rescue ArgumentError => e
    render json: { errors: e.message }, status: 422
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params.except(:user_id))
      render json: @order, status: :ok
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  rescue ArgumentError => e
    render json: { errors: e.message }, status: 422
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
    head 204
  end

  private

  def order_params
    params.require(:order).permit(:amount, :user_id, :status, :payment_status)
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
