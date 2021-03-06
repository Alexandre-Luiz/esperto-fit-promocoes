class Api::V1::PartnerCompaniesController < Api::V1::ApiController
  before_action :cpf_validation, only: %i[search]
  def search
    @partner_company_employee = PartnerCompanyEmployee.find_by(cpf: params[:q])
    if @partner_company_employee.blank?
      render json: { message: 'Nenhum desconto para esse CPF' }, status: :not_found
    else
      render json: @partner_company_employee.partner_company.as_json(only: %i[discount name id],
                                                                     methods: :format_discount_duration)
    end
  end

  private

  def cpf_validation
    return if params.key?(:q) && CPF.valid?(params[:q]) && (/^\d{3}\.\d{3}\.\d{3}-\d{2}$/).match?(params[:q])

    render status: :precondition_failed, json: { message: 'CPF inválido' }
  end
end
