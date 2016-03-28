class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  belongs_to :user
  has_many :ticket_types

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

   def self.upcoming_list
    where('starts_at > ?', DateTime.now.to_date)
   end

   def self.upcoming_list_search(search)
     where('name LIKE ?',"%#{search}%")
   end

   def self.list_event_created_by_curren_user(user)
     where(user_id: user)
   end
end
