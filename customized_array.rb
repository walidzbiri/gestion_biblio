require 'document'
require 'adherent'
require 'materiel'

# my customized array to overload include? and delete methods
class CustomizedArray < Array

    def include?(object)

        if object.is_a? Adherent
          self.each do |item|
            if(item.id == object.id)
              return true
            end
          end
        end
  
        if object.is_a? PC
          self.each do |item|
            if item.is_a? PC
              if(item.id == object.id)
                return true
              end
            end
          end
        end
  
        if object.is_a? Livre
          self.each do |item|
            if item.is_a? Livre
              if(item.isbn == object.isbn)
                return true
              end
            end
          end
        end
  
        return false
      end
    
      

    def delete(object)

      if object.is_a? Adherent
        self.each do |item|
          if(item.id == object.id)
            super(item)
          end
        end
      end

      if object.is_a? PC
        self.each do |item|
          if item.is_a? PC
            if(item.id == object.id)
              super(item)
            end
          end
        end
      end

      if object.is_a? Livre
        self.each do |item|
          if item.is_a? Livre
            if(item.isbn == object.isbn)
              super(item)
            end
          end
        end
      end

  end

  end