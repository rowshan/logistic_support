class Address < ApplicationRecord
  has_one :trip


  validates_presence_of :first_name, :last_name, :street, :house_no_main,
                        :postal_code_id, :postal_code, :city, :city_id,
                        :country_id, :country_code, :country

end
