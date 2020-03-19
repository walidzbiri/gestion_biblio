$LOAD_PATH << File.dirname(__FILE__)
require 'empruntable'
require'adherent'
require 'document'
require 'materiel'
require 'csv'
require 'exceptions'

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
        if adh==nil
            raise Inconnu, "ID non valide"
        else
            adh
        end
    end

    def get_document(isbn)
        dooc = @documents.select{|doc| doc.isbn == isbn}.first
        if dooc==nil
            raise Inconnu, "ISBN non valide"
        else
            dooc
        end
    end

    def get_materiel(id)
        matr = @materiels.select{ |mat| mat.id == id}.first
        if matr==nil
            raise Inconnu, "ID non valide"
        else
            matr
        end
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
        livres = CSV.parse(File.read("livres.csv"), headers: true)
        livres.each{|livre|
            #puts "#{row["ISBN"]} #{row["Titre"]} #{row["Dispo"]} #{row["Auteur"]}"
            @documents<< Livre.new(livre["ISBN"],livre["Titre"],livre["Auteur"],livre["Dispo"])
            
        }

        pcs = CSV.parse(File.read("pc.csv"), headers: true)
        pcs.each{|pc|
            #puts "#{row["id"]} #{row["marque"]} #{row["os"]} #{row["disponibilite"]} #{row["enPanne"]}"
            @materiels<< PC.new(pc["enPanne"],pc["marque"],pc["os"],pc["disponibilite"])
        }

        adherents = CSV.parse(File.read("adherents.csv"), headers: true)
        i=0
        adherents.each{|ad|
            #puts "#{row["id"]} #{row["marque"]} #{row["os"]} #{row["disponibilite"]} #{row["enPanne"]}"
            @adherents<< Adherent.new(ad["Nom"],ad["Prenom"],ad["Statut"])
            livres=[]
            pcs=[]
            ad["Emprunts"].split("//").each{|emp|
                if emp.start_with?('Livre')
                    livres<< Livre.new(emp[/ISBN: (.*?),/m, 1],emp[/Titre: (.*?),/m, 1],emp[/Auteur: (.*?),/m, 1],emp[/Disponible: (.*?),/m, 1])
                else
                    pcs<< PC.new(emp[/panne: (.*?),/m, 1],emp[/Marque: (.*?),/m, 1],emp[/OS: (.*?),/m, 1],emp[/Disponible: (.*?),/m, 1])
                end
            }
            livres.each{|l|
                @adherents[i].empruntes<< l
                @emprunts[l]=@adherents[i]
            }
            pcs.each{|pc|
                @adherents[i].empruntes<< pc
                @emprunts[pc]=@adherents[i]
            }
            i+=1######################""
        }

    end


    def add_adherent(adherent)
        if(adherent.is_a?(Adherent))
            @adherents<<adherent
        else
            raise Inconnu, "Adherent non valide"
        end
    end


    def add_Document(document)
        if(document.is_a?(Document))
            @documents<<document
        else
            raise Inconnu, "Document non valide"
        end
    end



    def add_Materiel(materiel)
        if(materiel.is_a?(Materiel))
            @materiels<<materiel
        else
            raise Inconnu, "Materiel non valide"
        end
    end

    def supprimez_adherent(adherent)
        if @adherents.include? adherent
          adherent.empruntes.each{|item|
            adherent.rendre(self, item)
            }
          @adherents.delete adherent
        else
            raise Inconnu, "Adherent non valide"
        end
    end




    def supprimez_document(doc)
        if @documents.include? doc
          @documents.delete doc
        else
            raise Inconnu, "Document non valide"
        end
    end


    def supprimez_materiel(mat)
        if @materiels.include? mat
          @materiels.delete mat
        else
            raise Inconnu, "Materiel non valide"
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