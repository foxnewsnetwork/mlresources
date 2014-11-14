class Apiv1::Taxons::UpdateController < Admin::BaseController
  def update
    if _update_valid?
      render json: { taxon: _update_taxon! }
    else
      render json: { taxon: _failure_hash }, status: :expectation_failed
    end
  end
  private
  def _failure_hash
    _updated_taxon.errors.to_h
  end
  def _update_valid?
    _updated_taxon.valid?
  end
  def _updated_taxon
    @taxon ||= _taxon.tap { |t| t.assign_attributes _taxon_params }
  end
  def _update_taxon!
    _updated_taxon.tap(&:save!)
  end
  def _taxon
    Apiv1::Taxon.find params[:id]
  end
  def _taxon_params
    params.require(:taxon).permit :taxon_name, :explanation
  end
end