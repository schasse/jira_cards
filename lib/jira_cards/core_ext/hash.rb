unless Hash.new.respond_to? :compact
  class Hash
    # Returns a hash with non +nil+ values.
    #
    #   hash = { a: true, b: false, c: nil}
    #   hash.compact # => { a: true, b: false}
    #   hash # => { a: true, b: false, c: nil}
    #   { c: nil }.compact # => {}
    def compact
      self.select { |_, value| !value.nil? }
    end
  end
end
