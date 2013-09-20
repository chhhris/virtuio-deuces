class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :client_id
      t.integer :user_id
      t.string :description
      t.integer :amount
      t.string :date_paid
      t.string :date_due

      t.timestamps
    end
  end
end
