class Friendship < ApplicationRecord
  belongs_to :user
  # class_name: "User" because friend is actually just an alias for user!
  belongs_to :friend, class_name: "User"
end
