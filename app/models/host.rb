class Host < ActiveRecord::Base
    has_secure_password
    has_many :reservations
end
