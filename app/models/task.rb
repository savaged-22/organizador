# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  due_date    :string
#  date        :string
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Task < ApplicationRecord
  belongs_to :category
  belongs_to :owner, class_name: 'User'
  has_many :participating_users, class_name: 'Participant'
  has_many :participants, through: :participating_users, source: :user

  #---------validations------------
  validates :name, :description, presence: true
  validates :name, uniqueness: {case_insensitive: true}
  #validate :validation_due_date
  validates :participating_users, presence: true
  #-----------methods---------------
  accepts_nested_attributes_for :participating_users, allow_destroy: true
  #This method send an message if the due_date is incorrect.
  def validation_due_date
    return if due_date.blank?
    return if due_date > Date.today
    errors.add :due_date, I18n.t("tasks.errors.invalid_due_date") 
   end

  

end
