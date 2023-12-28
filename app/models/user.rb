# models/user.rb

class User < ApplicationRecord
  attr_accessor :remember_digest
  has_one_attached :image

  before_save { self.email = email.downcase }
  validates :name, presence: { message: '名前を入力してください' }, length: { maximum: 50, message: '名前は50文字以内で入力してください' }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: { message: 'メールアドレスを入力してください' },
                    length: { maximum: 255, message: 'メールアドレスは255文字以内で入力してください' },
                    format: { with: VALID_EMAIL_REGEX, message: '正しい形式でメールアドレスを入力してください' },
                    uniqueness: { case_sensitive: false, message: '既に登録されているメールアドレスです' }

  has_secure_password validations: false
  validates :password, presence: { message: 'パスワードを入力してください' }, if: :password_required?
  validate :password_complexity, on: :create

  def password_complexity
    if password.present? && (password.length < 8 || !password.match(/^(?=.*[a-zA-Z])(?=.*\d).+$/))
      errors.add(:password, "は8文字以上で、英字と数字をそれぞれ1文字以上含めてください")
    end
  end

  validate :introduction_presence_on_update, on: :update

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def remember
    self.remember_token = self.class.new_token
    update_attribute(:remember_digest, self.class.digest(remember_token))
    remember_digest
  end

  def session_token
    # remember_digest || remember
  end

  def forget
    update_columns(remember_digest: nil)
  end

  private

  def introduction_presence_on_update
    if introduction.blank?
      errors.add(:introduction, '自己紹介文が空です')
    elsif introduction.length < 50 || introduction.length >= 200
      errors.add(:introduction, '50文字以上、200文字未満で入力してください')
    end
  end

  def password_required?
    password_digest.blank? || password.present?
  end
end
