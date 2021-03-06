class Task < ApplicationRecord
  # before_validation :set_nameless_name
  has_one_attached :image
  validates :name, presence: true
  validates :name, length: {maximum: 30}
  validate :validates_name_not_including_comma
  # モデルに下記のように書くことで1ページの件数も設定可能
  paginates_per 50

  belongs_to :user

  # scope :recent, -> { order(created_at: :desc)}

  # 検索に使用していいカラムの制限
  def self.ransackable_attributes(auth_object = nil)
    %w[name created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def self.csv_attributes
    ["name", "description", "created_at", "updated_at"]
  end

  def self.generate_csv
    CSV.generate(headers: true) do |csv|
      csv << csv_attributes
      all.each do |task|
        csv << csv_attributes.map{ |attr| task.send(attr) }
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      task = new
      task.attributes = row.to_hash.slice(*csv_attributes)
      task.save!
    end
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
