class Admin::EmployeeFactory
  delegate :save!,
    to: :_employee
  def initialize(input_params)
    @params = input_params.permit *Apiv1::Employee::Fields
    @raw_pictures = _arrayify(input_params[:pictures])
  end
  def satisfy_specifications?
    _pictures.all?(&:valid?) && _employee.valid?
  end
  def employee_hash
    { employee: _employee.to_ember_hash }
  end
  def error_hash
    _employee.errors.to_h
  end
  private
  def _employee
    @employee ||= Apiv1::Employee.new @params
  end
  def _pictures
    @pictures ||= _employee.pictures.new _picture_params
  end
  def _picture_params
    @raw_pictures.map { |pic| { pic: pic } }
  end
  def _arrayify(array_like)
    return array_like if array_like.is_a? Array
    array_like.to_a.map(&:last)
  end
end