FactoryBot.define do
  factory :io_log do
    user_id { 1 }
    quantity { 1 }
    
    factory :borrow_io_log do
      kind { 0 }
    end

    factory :return_io_log do
      kind { 1 }
    end
  end
end
