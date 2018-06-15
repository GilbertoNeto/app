class Customer < ApplicationRecord
  has_many :schedule
  has_many :cars
  has_many :ratings
  before_validation :format_params
  validates :name, presence: true,
                    length: { minimum: 5 }
  validates :city, presence: true
  validates :state, presence: true
  validates :neighborhood, presence: true
  validates :address, presence: true
  validates :zipcode, presence: true
  validates :cpf, uniqueness: true
  validate :cpf_valid
  

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private
    def cpf_valid
      errors.add(:cpf, 'inválido') if !CPF.valid?(cpf, strict: true)
    end

    def format_params
      self.cpf = CPF.new(cpf).stripped
    end
end
