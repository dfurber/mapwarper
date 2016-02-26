class Building < ActiveRecord::Base

  has_and_belongs_to_many :architects
  belongs_to :building_type
  belongs_to :frame_type, class_name: 'ConstructionMaterial'
  belongs_to :lining_type, class_name: 'ConstructionMaterial'

  validates :name, :address, :city, :state, presence: true, length: { maximum: 255 }
  validates :year_earliest, :year_latest, numericality: { minimum: 1500, maximum: 2100, allow_nil: true }

  def address_parts
    parts = [street_address].compact
    parts << [[city, state].join(", "), postal_code].join(' ')
  end

  def architects_list
    architects.map(&:name).join(', ')
  end

  def architects_list=(value)
    self.architects = value.split(',').map(&:strip).map {|item| Architect.where(name: item).first_or_create }
  end

  def street_address
    [address_house_number, address_street_prefix, address_street_name, address_street_suffix].join(' ')
  end

end