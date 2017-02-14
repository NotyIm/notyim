class Assertion
  include Mongoid::Document
  include Mongoid::Timestamps

  field :subject, type: String
  field :condition, type: String
  field :operand

  # Part before dot has to match
  # @reference Check::Types
  SUBJECT_TYPES = %W(
    #{Check::TYPE_TCP}.status
    #{Check::TYPE_TCP}.body
    #{Check::TYPE_TCP}.response_time

    #{Check::TYPE_HTTP}.status
    #{Check::TYPE_HTTP}.body
    #{Check::TYPE_HTTP}.code
    #{Check::TYPE_HTTP}.response_time
  ).freeze

  # Condition key has to match with check type:
  # @reference Check::Types
  CONDITION_TYPES = {
    Check::TYPE_TCP => {
      :down => 'Down',
      :up   => 'Up',
      :slow => 'Slow',
    },

    Check::TYPE_HTTP => {
      :down => 'Down',
      :up   => 'Up',
      :slow => 'Slow',

      :eq => 'Equal',
      :ne => 'Not equal',
      :gt => 'Greater than',
      :lt => 'Less than',
      :contain => 'Contains',
      :in => 'Includes in'
    }
  }.freeze

  belongs_to :check
  has_many :incidents # We don't want to destroy incident when removing assertion

  validates_presence_of :subject, :condition
  validates :subject, :inclusion => { :in => SUBJECT_TYPES }

  def subject_enum
    SUBJECT_TYPES
  end

  def condition_enum
    CONDITION_TYPES
  end

  def ongoing_incident
    @__ongoing_incident ||= incidents.open.first
  end
end
