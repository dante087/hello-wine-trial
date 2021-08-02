class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.decimal :amount, null: false
      t.string :status, default: 'Recibida'
      t.string :payment_status, default: 'Pendiente de pago'
      t.datetime :delivery_date
      t.datetime :payment_date

      t.timestamps
    end
  end
end
