class GameController
  include Moon::Eventable

  class UnitEvent < Moon::Event
    attr_accessor :unit

    def initialize(unit, action)
      @unit = unit
      super action
    end
  end

  attr_reader :model # World

  def initialize(model)
    initialize_eventable
    @model = model
  end

  def add_unit(unit)
    @model.units << unit
    trigger UnitEvent.new(unit, :unit_added)
  end

  def add_static_unit(unit)
    add_unit(unit)
  end

  def remove_unit(unit)
    @model.units.delete unit
    trigger UnitEvent.new(unit, :unit_removed)
  end

  def remove_static_unit(unit)
    remove_unit(unit)
  end

  def select_unit_at_pos(position, threshold = nil)
    threshold ||= 0.5
    @model.units.find do |unit|
      unit.cpos.near?(position, threshold)
    end
  end
end
