class PartnerCompany < ApplicationRecord
  belongs_to :user

  validates :name, :cnpj, :address, :email, presence: true
  validates :cnpj, uniqueness: true
  validate :cnpj_validation

  def cnpj_validation
    return if CNPJ.valid?(cnpj)

    errors.add(:cnpj, :invalid)
  end
end