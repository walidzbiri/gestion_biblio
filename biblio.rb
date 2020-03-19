$LOAD_PATH << File.dirname(__FILE__)
require 'empruntable'
require'adherent'
require 'document'
require 'materiel'
require 'csv'

class Biblio
    attr_accessor :adherents,:documents,:materiels,:emprunts
    def initialize(adherents=[],documents=[],materiels=[])  
        @adherents=adherents
        @materiels=materiels
        @documents=documents
        @emprunts={}
    end

    def get_adherent(id)
        adh = @adherents.select{ |ad| ad.id == id}.first
        adh
    end

    def get_document(isbn)
        dooc = @documents.select{|doc| doc.isbn == isbn}.first
        dooc
    end

    def get_materiel(id)
        matr = @materiels.select{ |mat| mat.id == id}.first
        matr
    end

    def est_dans_biblio(element)
        if @documents.include?(element) || @materiels.include?(element)
            true
        else
            false
        end
    end


    def save()
        CSV.open("adherents.csv", "wb"){|csv|
         csv << ["Nom","Prenom","Statut","Emprunts"]
         @adherents.each{|ad|
            mes_emprunts_obj=[]
            @emprunts.each{|emprunt,adherent|
                if (ad.id==adherent.id)
                    mes_emprunts_obj<< emprunt
                
                end
            }
            mes_emprunts_str=[]
            mes_emprunts_obj.each{|obj|
                mes_emprunts_str<<obj.to_s
            }
             csv << [ad.nom, ad.prenom, ad.statut,mes_emprunts_str.join("//")]
         }
        }

        CSV.open("livres.csv", "wb") do |csv|
            csv << ["ISBN","Titre","Dispo","Auteur"]
            @documents.each{|doc|
                csv << [doc.isbn,doc.titre,doc.disponibilite,doc.auteur]
            }
        end
        CSV.open("pc.csv", "wb") do |csv|
            csv << ["id","marque","os","disponibilite","enPanne"]
            @materiels.each{|m|
                csv << [m.id,m.marque,m.os,m.disponibilite,m.enPanne]
            }
        end
     end

    def load()
        # define me please
    end
    def add_adherent(adherent)
        if(adherent.is_a?(Adherent))
            @adherents<<adherent
        else
            puts "Adherent invalid"
            exit
        end
    end


    def add_Document(document)
        if(document.is_a?(Document))
            @documents<<document
        else
            puts "Document invalid"
            exit
        end
    end



    def add_Materiel(materiel)
        if(materiel.is_a?(Materiel))
            @materiels<<materiel
        else
            puts "Materiel invalid"
            exit
        end
    end

    def supprimez_adherent(adherent)
        if @adherents.include? adherent
          adherent.empruntes.each{|item|
            adherent.rendre(self, item)
            }
          @adherents.delete adherent
        else
          puts "Adherent inconnu"
          exit
        end
    end




    def supprimez_document(doc)
        if @documents.include? doc
          @documents.delete doc
        else
            puts "Document inconnu"
            exit
        end
    end


    def supprimez_materiel(mat)
        if @materiels.include? mat
          @materiels.delete mat
        else
          puts "Materiel inconnu"
          exit
        end
    end    


    def rechercherTitre(titre)
        found=[]
        @@documents.each{|doc|
            if(doc.titre.eql?(titre))
                found<<doc
            end
        }
        return found
    end


    def afficherFonds
        @emprunts.each{|emprunt,adherent|
            print "#{adherent.to_s}"
            print "=>"
            print "#{emprunt.to_s}\n"
        }
    end
    
end