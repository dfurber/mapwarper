class People::CensusRecordsController < ApplicationController

  include RestoreSearch

  respond_to :json, only: :index
  respond_to :html

  def index
    authorize! :read, resource_class
    unless params[:q].andand[:s]
      params[:q] ||= {}
      params[:q][:s] = 'last_name asc'
    end
    if cannot? :moderate, resource_class
      params[:q][:reviewed_at_not_null] = 1
    end
    @search = resource_class.ransack(params[:q])
    @records = @search.result
    unless request.format.json?
      @per_page = params[:per_page] || 25
      paginate_params = {
        :page => params[:page],
        :per_page => @per_page
      }
      @records = @records.paginate(paginate_params)
    end
    respond_with @records
  end

  def new
    authorize! :create, resource_class
    @record = resource_class.new
    if params[:attributes]
      params[:attributes].each do |key, value|
        @record.public_send "#{key}=", value
      end
    end
  end

  def building_autocomplete
    record = resource_class.new
    record.street_name = params[:street]
    record.city = params[:city]
    buildings = record.buildings_on_street
    buildings = buildings.map {|building| { id: building.id, name: building.name } }
    render json: buildings
  end

  def create
    @record = resource_class.new resource_params
    authorize! :create, @record
    @record.created_by = current_user
    if can?(:review, @record)
      @record.reviewed_by = current_user
      @record.reviewed_at = Time.now
    end
    if @record.save
      flash[:notice] = 'Census Record created.'
      after_saved
    else
      flash[:errors] = 'Census Record not saved.'
      render action: :new
    end
  end

  def show
    @record = resource_class.find params[:id]
    authorize! :read, @record
  end

  def edit
    @record = resource_class.find params[:id]
    # @record.photos.build
    authorize! :update, @record
    # @record.building = @record.matching_building if @record.building_id.blank? && @record.street_house_number && @record.street_name
  end

  def update
    @record = resource_class.find params[:id]
    authorize! :update, @record
    if @record.update_attributes(resource_params)
      flash[:notice] = 'Census Record updated.'
      after_saved
    else
      flash[:errors] = 'Census Record not saved.'
      render action: :edit
    end
  end

  def destroy
    @record = resource_class.find params[:id]
    authorize! :destroy, @record
    if @record.destroy
      flash[:notice] = 'Census Record deleted.'
      redirect_to action: :index
    else
      flash[:errors] = 'Unable to delete building.'
      redirect_to :back
    end
  end

  def save_as
    @record = resource_class.find params[:id]
    authorize! :create, @record
    after_saved
  end

  def reviewed
    @record = resource_class.find params[:id]
    authorize! :review, @record
    @record.reviewed_by ||= current_user
    @record.reviewed_at ||= Time.now
    @record.save
    flash[:notice] = 'The census record is marked as reviewed and available for public view.'
    redirect_to :back
  end

  private

  def resource_class
    raise 'resource_class needs a constant name!'
  end

  def resource_params
    params.require(resource_class.model_name.param_key).permit!
  end

  def after_saved
    if params[:then].present?
      attrs = []
      attrs += case params[:then]
      when 'enumeration'
        %w{page_number county city ward enum_dist}
      when 'page'
        %w{page_number county city ward enum_dist}
      when 'dwelling'
        %w{page_number county city ward enum_dist dwelling_number street_house_number street_prefix street_suffix street_name}
      when 'family'
        %w{page_number county city ward enum_dist dwelling_number street_house_number street_prefix street_suffix street_name family_id}
      end
      attributes = attrs.inject({}) {|hash, item|
        hash[item] = @record.public_send(item)
        hash
      }
      redirect_to action: :new, attributes: attributes
    else
      redirect_to @record
    end
  end

end