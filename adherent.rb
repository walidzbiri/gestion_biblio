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
        @statut = "Etudiant"
        @empruntes = []
        @nom=nom
    end

    def emprunter(item,biblio)
        if(!biblio.adherents.include?(self))
            puts "vous etes pas un membre!"
            exit
        else
            if(@empruntes.length>=5)
                puts "vous avez atteint les limites!"
                exit
            else
                if(biblio.est_dans_biblio(item))
                    if(item.isDisponible?)
                        @empruntes<<item
                        biblio.emprunts[item]=self
                        item.disponibilite=false
                    else
                        puts "l element n est pas dispo!"
                        exit
                    end
                else
                    puts "l element n est pas dans la biblio"
                    exit
                end
            end
        end
    end

    def rendre(item,biblio)
        if(!biblio.adherents.include?(self))
            puts "vous etes pas un membre!"
            exit
        else
            if(@empruntes.include?(item))
                @empruntes.delete(item)
                biblio.emprunts.delete(item)
                item.disponibilite=true
            else
                puts "vous l avez pas encore empruntez!"
                exit
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