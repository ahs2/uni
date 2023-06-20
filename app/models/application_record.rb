class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.human_enum_name(enum_name, enum_value)
    enum_i18n_key = enum_name.to_s.pluralize
    I18n.t("enum.#{model_name.i18n_key}.#{enum_i18n_key}.#{enum_value}")
  end

  def self.human_enum_collection(enum_name)
    send(enum_name.to_s.pluralize).keys.collect { |val| [self.human_enum_name(enum_name, val), val] }
  end

  def valid_attributes?(*attributes)
    attributes.each do |attribute|
      self.class.validators_on(attribute).each do |validator|
        validator.validate_each(self, attribute, send(attribute))
      end
    end
    errors.none?
  end
end
