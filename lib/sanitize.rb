module Sanitize
  extend ActiveSupport::Concern

  module InstanceMethods
    def sanitize(str)
      return '' if str.nil?
      str = str.downcase
      str = str.gsub(/\s/, '-')
      str.gsub(/[^\w\-\.\/]/, '')
    end
  end

  module ClassMethods
    def sanitize(*args)
      args.each do |v|
        define_method("sanitize_#{v}") {
          return nil unless self.respond_to?(v)
          value = self.send(v)
          value = sanitize(value)
          return value unless self.respond_to?("#{v}=")
          self.send("#{v}=", value)
        }
      end
    end
  end
end
