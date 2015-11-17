class String
  def to_bool
    return true if ['true', '1', 'yes', 'on', 't'].include? self
    return false if ['false', '0', 'no', 'off', 'f'].include? self
    return nil
  end

  def numeric?
    return true if self =~ /\A\d+\Z/
    true if Float(self) rescue false
  end
end