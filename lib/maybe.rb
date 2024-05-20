# frozen_string_literal: true

class Maybe
  extend T::Sig
  extend T::Generic

  Elem = type_member

  # Creation

  def initialize(value)
    @value = value
    freeze
  end

  def self.from_block
    new(yield)
  end

  def self.return(value)
    new(value)
  end

  def self.none
    new(nil)
  end

  def self.from_present(value)
    if value.present?
      Maybe.return(value)
    else
      Maybe.return(nil)
    end
  end

  private_class_method :new

  # Querying the type

  sig { returns T::Boolean }
  def some?
    !@value.nil?
  end

  sig { returns T::Boolean }
  def none?
    @value.nil?
  end

  # Equality

  def ==(other)
    other.is_a?(Maybe) && @value == other.instance_variable_get(:@value)
  end

  # Unwrapping the value

  def value!(message = 'No value is present')
    raise message if @value.nil?

    @value
  end

  def value_or(default)
    @value.nil? ? default : @value
  end

  def value_or_yield
    @value.nil? ? yield : @value
  end

  def value_or_nil
    @value.nil? ? nil : @value
  end

  # Running code conditionally

  def and_then
    yield(@value) unless @value.nil?

    self
  end

  def or_else
    yield(@value) if @value.nil?

    self
  end

  # Mapping to other values

  def map
    if @value
      Maybe.from_block { yield(@value) }
    else
      self
    end
  end

  def bind
    if @value
      yield(@value)
    else
      self
    end
  end
end
