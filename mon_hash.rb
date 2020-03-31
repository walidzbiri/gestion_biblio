# Notre hash customisé pour assurer la fonctionnalité de suppression avec id/isbn
class MonHash < Hash

    def delete(object)
        if(object.is_a?(Livre))
            self.each{|key,value|
                if(key.is_a?(Livre))
                    if(key.isbn==object.isbn)
                        super(key)
                    end
                end
            }
                
        elsif(object.is_a?(PC)) 
            self.each{|key,value|
                if(key.is_a?(PC))
                    if(key.id==object.id)
                        super(key)
                    end
                end
            }
        end
    end
end