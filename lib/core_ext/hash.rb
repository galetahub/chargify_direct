class Hash
  def deep_transform_keys!(&block)
    keys.each do |key|
      value = delete(key)
      self[yield(key)] = value.is_a?(Hash) ? value.deep_transform_keys!(&block) : value
    end
    self
  end

  def deep_symbolize_keys!
    deep_transform_keys!{ |key| key.to_sym rescue key }
  end

  def slice(*keys)
    keys.map! { |key| convert_key(key) } if respond_to?(:convert_key, true)
    keys.each_with_object(self.class.new) { |k, hash| hash[k] = self[k] if has_key?(k) }
  end

  protected
  
  def convert_key(key)
    key.kind_of?(Symbol) ? key.to_s : key
  end
end
