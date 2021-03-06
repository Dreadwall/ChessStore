class ItemPrice < ActiveRecord::Base
  # get module to help with some functionality
  include ChessStoreHelpers::Validations

  # List of allowable categories
  CATEGORIES = [['Wholesale','wholesale'],['Manufacturer','manufacturer']]

  # Relationships
  belongs_to :item

  # Scopes
  scope :current,       -> { where(end_date:nil) }
  scope :chronological, -> { order(start_date: :desc ) }
  scope :for_date,      ->(date) { where("start_date <= ? AND (end_date > ? OR end_date IS NULL)", date, date) }
  scope :for_item,      ->(item_id) { where(item_id: item_id) }
  scope :wholesale,     -> { where(category: "wholesale") }
  scope :manufacturer,  -> { where(category: "manufacturer") }
  scope :idealsort, -> { order('start_date DESC, id DESC') }

  # Validations
  validates_numericality_of :price, greater_than_or_equal_to: 0
  validates_date :start_date, on_or_before: lambda { Date.current }
  validates_date :end_date, on_or_after: :start_date, allow_blank: true
  validates_inclusion_of :category, in: %w[wholesale manufacturer], message: "must be either manufacturer or wholesale"
  validate :item_is_active_in_system

  # Callbacks
  before_create :set_end_date_of_old_price
  before_destroy :is_never_destroyable

  # Other methods
  private
  def item_is_active_in_system
    is_active_in_system(:item)
  end

  def set_end_date_of_old_price
    return if self.category.nil?
    if self.category == "wholesale"
      previous = ItemPrice.wholesale.current.for_item(self.item_id).take
    else
      previous = ItemPrice.manufacturer.current.for_item(self.item_id).take
    end
    previous.update_attribute(:end_date, self.start_date) unless previous.nil?
  end
end
