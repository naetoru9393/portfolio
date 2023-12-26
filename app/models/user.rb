class User < ApplicationRecord
  attr_accessor :remember_digest
  has_one_attached :image

  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true

                    has_secure_password
                    validates :password, presence: true, if: :password_required?
                    validate :password_complexity, on: :create

  def password_complexity
    if password.present? && (password.length < 8 || !password.match(/^(?=.*[a-zA-Z])(?=.*\d).+$/))
      errors.add(:password, "は8文字以上で、英字と数字をそれぞれ1文字以上含めてください")
    end
  end

  validate :introduction_presence_on_update, on: :update

    # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # 永続化セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
    remember_digest
  end

  # セッションハイジャック防止のためにセッショントークンを返す
  # この記憶ダイジェストを再利用しているのは単に利便性のため
  def session_token
   # remember_digest || remember
  end

    # ユーザーの永続セッションを破棄する
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