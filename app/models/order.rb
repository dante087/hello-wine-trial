class Order < ApplicationRecord
  belongs_to :user, inverse_of: :orders
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :amount, presence: true
  validates :user, presence: true

  after_validation :set_delivery_date, :set_payment_date

  enum status: { received: 'Recibida', on_preparation: 'En preparación',
                 on_delivery: 'En entrega', delivered: 'Entregada' }

  enum payment_status: { paid: 'Pagada', unpaid: 'No pagada', pending: 'Pendiente de pago' }

  scope :filter_by_delivery_date, lambda { |search_date|
    from_date = begin
      DateTime.iso8601(search_date)
    rescue StandardError
      DateTime.now
    end
    where(delivery_date: from_date.beginning_of_day..from_date.end_of_day)
  }

  def status
    Order.statuses[attributes['status']]
  end

  def payment_status
    Order.payment_statuses[attributes['payment_status']]
  end

  private

  def set_delivery_date
    self.delivery_date = Time.now if delivered? && status_changed?
  end

  def set_payment_date
    self.payment_date = Time.now if paid? && payment_status_changed?
  end
end
