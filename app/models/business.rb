class Business < ApplicationRecord
  has_many :schedule
  has_many :service
  has_many :ratings
  before_validation :format_params
  validates :name, presence: true, length: { minimum: 5 }, uniqueness: true
  validates :city, presence: true
  validates :state, presence: true
  validates :neighborhood, presence: true
  validates :address, presence: true
  validates :zipcode, presence: true
  validates :cnpj, uniqueness: true
  validate :cnpj_valid

  scoped_search on: [:name]
  
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 def average_rating
      ratings.sum(:score) / ratings.size
    end
  private
    
  	def cnpj_valid
  		errors.add(:cnpj, 'inválido') if !CNPJ.valid?(cnpj, strict: true)
  	end

  	def format_params
  		self.cnpj = CPF.new(cnpj).stripped
    end
    
end
