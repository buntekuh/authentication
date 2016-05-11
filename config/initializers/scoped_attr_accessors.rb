# 
# # Scopes attributes to be private or protected
# 
# @author [buntekuh]
# 
module ScopedAttrAccessors
  
  # 
  # All listed attributes will be privately accessible in the object
  # @param *names [List of symbols] the attributes to be declared as private
  # 
  def private_attr_accessor(*names)
    attr_accessor(*names)
    names.each do |name|
      private name
      private "#{name}="
    end
  end

  # 
  # All listed attributes will be protected accessible in the object
  # @param *names [List of symbols] the attributes to be declared as protected
  # 
  def protected_attr_accessor(*names)
    protected
    attr_accessor(*names)
  end
end


# 
# Insert ScopedAttrAccessors into Object
# 
# @author [buntekuh]
# 
class Object
  extend ScopedAttrAccessors
end
