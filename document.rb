class Document
    attr_accessor :titre

    def initialize(titre)
      @titre = titre
    end
    def to_s
       "Document : #{@titre};"
    end

end

class Revue < Document
    attr_accessor :numero
    def initialize(titre, numero )
        super(titre)
        @numero = numero
    end

    def to_s
        "Revue : #{@titre}  Numero #{@numero}; "
    end
end




class Volume < Document
    attr_accessor :auteur
    def initialize(titre, auteur)
      super(titre)
      @auteur=auteur
    end
  
    def to_s
      print "Volume : #{@titre} "
      print " Auteur: #{@auteur}"
    end
  
end


class BandeDessiner < Volume
    attr_accessor :dessinateur
    def initialize(titre, auteur , dessinateur)
      super(titre, auteur)
      @dessinateur = dessinateur
    end
  
    def to_s
      print "BandeDessiner: #{@titre}  Dessinateur #{@dessinateur},"
      print " Auteur: #{@auteur}"
    end

end


class Dictionnnaire < Volume
    attr_accessor :theme
    def initialize(titre, auteur , theme )
      super(isbn , titre, auteur)
      @theme = theme
    end
  
    def to_s
      print "Dictionnaire : #{@titre} Theme #{@theme} , "
      print " Auteur: #{@auteur}"
    end
  
end

class Livre < Volume
    include Empruntable
    
    attr_accessor :isbn,:disponibilite
    def initialize(isbn,titre, auteur, disponibilite = true)
      super(titre, auteur)
      @disponibilite=disponibilite
      @isbn=isbn
    end
  
    def isDisponible?
        @disponibilite
    end

    def to_s
      return "Livre " +
       "ISBN: #{@isbn}, "+
       "Titre: #{@titre}, "+
       "Auteur: #{@auteur}, " +
       "Disponible: #{@disponibilite},"
    end
  
end