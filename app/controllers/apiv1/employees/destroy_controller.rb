class Apiv1::Employees::DestroyController < Admin::BaseController
  def destroy
    render json: { employee: _employee.destroy }
  end
  private
  def _employee
    @employee ||= Apiv1::Employee.find params[:id]
  end
end