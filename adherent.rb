$LOAD_PATH << File.dirname(__FILE__)
require 'exceptions'
require 'customized_array'
status = ["Etudiant", "Enseignant"]

class Adherent
    @@compteur=0
    def self.compteur_id
        @@compteur
    end
    attr_accessor :nom,:prenom,:statut,:empruntes,:id

    def initialize(nom,prenom,statut)
        @@compteur+=1
        @id=Adherent.compteur_id
        @prenom = prenom
        @statut = statut
        @empruntes = CustomizedArray.new()
        @nom=nom
    end

    def emprunter(item,biblio)
        if(!biblio.adherents.include?(self))
            raise(Inconnu, "Vous êtes pas un adherent")
        else
            if(@empruntes.length>5)
                raise MaxEmpruntes, "Vous avez atteint le maximum"
            else
                if(biblio.est_dans_biblio(item))
                    if(item.isDisponible?)
                        @empruntes<<item
                        biblio.emprunts[item]=self
                        item.disponibilite=false
                    else
                        raise(DejaEmprunte, "Cet element n'es pas disponible")
                    end
                else
                    raise(Indsiponible, "Cet element n'est pas dans la biblio")
                end
            end
        end
    end

    
    def rendre(item,biblio)
        if(!biblio.adherents.include?(self))
            raise(Inconnu, "Vous êtes pas un adherent")
        else
            if(@empruntes.include?(item))
                @empruntes.delete(item)###### overloading
                biblio.emprunts.delete(item)
                item.disponibilite=true
            else
                raise(PasEmpruntable,"Cet element #{item.to_s} n'est pas encore emprunté!")
            end
        end
    end



    def afficherEmpruntes()
        @empruntes.each { |item| puts item.to_s }
        puts "Total #{@empruntes.length}"
    end

    def to_s
        print "Adherent : #{@id} #{@nom} #{@prenom} : #{@statut}  "
    end

end