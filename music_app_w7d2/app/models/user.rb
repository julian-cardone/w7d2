class User < ApplicationRecord
    #FIGVAPER CRLLL

    validates :email, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true

    validates :password, length: {minimum: 6}, allow_nil: true

    before_validation :ensure_session_token

    attr_reader :password

    def self.find_by_credentials(email, password)
        @user = user.find_by(email: user[:email])
        if @user && user.is_password?(password)
            return @user
        else
            return nil
        end
    end

    def generate_session_token
        self.session_token = SecureRandom::urlsafe_base64
    end

    def is_password?(password)
        password_object = BCrypt::Password.new(self.password_digest)
        password_object.is_password?(password)
    end

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end

    def reset_session_token
        self.session_token = SecureRandom::urlsafe_base64
        
        self.save!

        self.session_token
    end

end