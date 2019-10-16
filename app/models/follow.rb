class Follow < ApplicationRecord
    belongs_to :user
    belongs_to :follower, class_name: "User", foreign_key: "followee_id"

end
