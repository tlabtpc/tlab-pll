class CrossCheck < ApplicationRecord
  STEPS = %w(start details info deadlines residence consulted actions support complete).freeze
  belongs_to :assessment, required: true

  attr_accessor :begun

  def self.next_step_for(action_name)
    STEPS[current_step_index(action_name) + 1]
  end

  def self.previous_step_for(action_name)
    STEPS[current_step_index(action_name) - 1] unless action_name.to_s == STEPS.first
  end

  def self.current_step_index(action_name)
    STEPS.index(action_name.to_s).tap do |index|
      raise ArgumentError.new("Cannot find step named #{action_name}") if index.nil?
    end
  end
end
