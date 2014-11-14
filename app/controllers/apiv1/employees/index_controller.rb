class Apiv1::Employees::IndexController < Apiv1::HomeController
  def index
    render json: { employees: _employees.map(&:to_ember_hash) }
  end
  private
  def _employees
    @employees ||= Apiv1::Employee.all
  end
end