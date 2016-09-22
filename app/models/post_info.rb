class PostInfo < ApplicationRecord
  after_commit :calculate_rating!, on: :update

  belongs_to :post

  protected

    def calculate_rating!
      return unless !self.views.zero?

      _rating = ((likes.to_f) / (views.to_f)) * 100
      update_column(:rating, _rating)
    end

end
