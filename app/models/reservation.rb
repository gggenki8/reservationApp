class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :number_of_guests, presence: true, numericality: { only_integer: true, greater_than: 0 }

  validate :validate_check_in_and_check_out
  validate :validate_number_of_guests

  private

  def validate_check_in_and_check_out
    if check_in.blank? || check_out.blank?
      errors.add(:base, "チェックインとチェックアウトの日付を入力してください")
    elsif check_in < Date.today
      errors.add(:base, "本日以降の日付を選択してください")
    elsif check_out <= check_in
      errors.add(:base, "チェックイン日以降の日付を選択してください")
    end
  end

  def validate_number_of_guests
    if number_of_guests.blank?
      errors.add(:base, "宿泊人数を入力してください")
    elsif number_of_guests <= 0
      errors.add(:base, "宿泊人数は1人以上でなければなりません")
    end
  end
end 

