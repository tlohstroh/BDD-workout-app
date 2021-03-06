class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # NOTE !!!  lecture 131
  has_many :exercises
  has_many :friendships
  has_many :friends, through: :friendships, class_name: "User"
  has_one :room
  has_many :messages

  validates :first_name, presence: true
  validates :last_name, presence: true

  # automatically creates chatroom when user signs up.
  # see private
  after_create :create_chatroom

  # works with will_paginate gem to decide how many items per page
  self.per_page = 10

  def full_name
    # "#{first_name} #{last_name}"
    [first_name, last_name]. join(" ")
  end

  def self.search_by_name(name)
    names_array = name.split(' ')

    if names_array.size == 1
    where('first_name LIKE ? or last_name LIKE ?',
      "%#{names_array[0]}%", "%#{names_array[0]}%").order(:first_name)
    else
      where('first_name LIKE ? or first_name LIKE ? or last_name LIKE ?
        or last_name LIKE ?', "%#{names_array[0]}%",
        "%#{names_array[1]}%", "%#{names_array[0]}%",
        "%#{names_array[1]}%").order(:first_name)
    end
  end

  def follows_or_same?(new_friend)
    # friendships.map(&: friend) returns all of the users friends
    friendships.map(&:friend).include?(new_friend) || self == new_friend

  end

  def current_friendship(friend)
    # returns an ARRAY with one record, so we need the first (and only) one.
    friendships.where(friend: friend).first
  end

  private

  def create_chatroom
    hyphenated_username = self.full_name.split.join("-")
    Room.create(name: hyphenated_username, user_id: self.id)

  end

end
