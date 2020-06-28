class Task < ApplicationRecord
    validates :status, presence: true, length: { maximum: 20 }
end
