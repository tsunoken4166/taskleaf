module CapybaraReactHelper
  def filtered_attr_names(instance)
    attr_names = instance.attribute_names
    attr_names.each_with_object({}) do |attr_name, hash|
      value = instance.send(attr_name.to_sym)
      value = I18n.l(value) if attr_name.include?('created_at') || attr_name.include?('updated_at')

      hash[instance.class.human_attribute_name(attr_name)] = value.to_s
    end
  end
end