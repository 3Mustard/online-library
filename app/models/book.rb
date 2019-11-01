#table needs :user_id attr

class Book < ActiveRecord::Base
    belongs_to :user
end 