$LOAD_PATH << File.dirname(__FILE__)
require 'exceptions'

status = ["Etudiant", "Enseignant"]

class Adherent
    @@id=0
    def self.compteur_id
        @@id
    end
    attr_accessor :nom,:prenom,:statut,:empruntes,:id
    def initialize(nom,prenom,statut)
        @@id+=1
        @id=Adherent.compteur_id
        @prenom = prenom
        @statut = statut
        @empruntes = []
        @nom=nom
    end

    def emprunter(item,biblio)
        if(!biblio.adherents.include?(self))
            raise(Inconnu, "You are not an adherent to our Library")
        else
            if(@empruntes.length>=5)
                raise MaxEmpruntes, "You have reached the limited Times"
            else
                if(biblio.est_dans_biblio(item))
                    if(item.isDisponible?)
                        @empruntes<<item
                        biblio.emprunts[item]=self
                        item.disponibilite=false
                    else
                        raise(DejaEmprunte, "This item is unavailable right now")
                    end
                else
                    raise(Indsiponible, "This item does not exists in Library")
                end
            end
        end
    end

    def rendre(item,biblio)
        if(!biblio.adherents.include?(self))
            raise(Inconnu, "You are not an adherent to our Library")
        else
            if(@empruntes.include?(item))
                @empruntes.delete(item)
                biblio.emprunts.delete(item)
                item.disponibilite=true
            else
                raise(PasEmpruntable,"This #{item.to_s} is not borrowed yet!")
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