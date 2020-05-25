class Task < ApplicationRecord
  # before_validation :set_nameless_name
  validates :name, presence: true
  validates :name, length: {maximum: 30}
  validate :validates_name_not_including_comma

  belongs_to :user

  scope :recent, -> { order(created_at: :desc)}

  # 検索に使用していいカラムの制限
  def self.ransackable_attributes(auth_object = nil)
    %w[name created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
  
  private

  def validates_name_not_including_comma
    errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
  end
  # 不要の処理
  # def set_nameless_name
  #   self.name = '名前なし' if name.blank?
  # end
end
