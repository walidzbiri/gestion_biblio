class Materiel
    @@id = 0
    attr_accessor :enPanne, :id
  
    def self.current_id
      @@id
    end
  
    def initialize(enPanne = false)
      @@id += 1
      @id = Materiel.current_id
      @enPanne = enPanne
    end
  
    def to_s
       "Materiel, panne :  #{@enPanne} "
    end
end

Os = ["Linux", "Windows"]

class PC < Materiel
  include Empruntable
  attr_accessor :marque, :os,:disponibilite

  def initialize(enPanne, marque, os, disponibilite)
    super(enPanne)
    @marque = marque
    @disponibilite=disponibilite
    if Os.include?(os)
      @os = os
    else
      @os = "Linux"
    end
  end
  def isDisponible?
    @disponibilite
  end

  def to_s
     "PC id: #{@id}, panne: #{@enPanne}, Marque: #{@marque}, OS: #{@os}, Disponible: #{@disponibilite},"
  end
end