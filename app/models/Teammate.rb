# encoding: utf-8

class Teammate
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter
  include MotionModel::Validatable

  columns display_name: :string,
          spoken_name:  :string,
          selected:     { type: :boolean, default: true }

  validate :display_name, presence: true

  alias real_spoken_name spoken_name
  def spoken_name
    real_spoken_name || display_name
  end

  def toggle_selected
    self.selected = !self.selected
  end

  def self.load!
    deserialize_from_file('team.dat')
  end

  def self.save!
    serialize_to_file('team.dat')
  end
end
