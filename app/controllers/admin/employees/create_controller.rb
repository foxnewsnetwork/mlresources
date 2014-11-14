class Admin::Employees::CreateController < Admin::BaseController
  def create
    if _employee_creation_success?
      _employee_factory.save!
      render json: _employee_hash
    else
      render json: _error_hash, status: :expectation_failed
    end
  end
  private
  def _employee_creation_success?
    _employee_factory.satisfy_specifications?
  end
  def _employee_hash
    _employee_factory.employee_hash
  end
  def _error_hash
    _employee_factory.error_hash
  end
  def _employee_factory
    @employee_factory ||= Admin::EmployeeFactory.new _employee_params
  end
  def _employee_params
    params.require(:admin_employee)
  end
end