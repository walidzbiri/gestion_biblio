$LOAD_PATH << File.dirname(__FILE__)
require 'empruntable'
require'adherent'
require 'document'
require 'materiel'
require 'csv'
require 'exceptions'
require 'customized_array'
require 'mon_hash'

class Biblio
    attr_accessor :adherents,:documents,:materiels,:emprunts

    def initialize(adherents=CustomizedArray.new,documents=CustomizedArray.new,materiels=CustomizedArray.new)  
        @adherents=adherents
        @materiels=materiels
        @documents=documents
        @emprunts=MonHash.new()
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
            @documents<< Livre.new(livre["Titre"],livre["Auteur"],livre["Dispo"],livre["ISBN"].to_i)
            
        }

        pcs = CSV.parse(File.read("pc.csv"), headers: true)
        pcs.each{|pc|
            @materiels<< PC.new(pc["enPanne"],pc["marque"],pc["os"],pc["disponibilite"],pc["id"].to_i)
        }

        adherents = CSV.parse(File.read("adherents.csv"), headers: true)
        i=0
        adherents.each{|ad|
            @adherents<< Adherent.new(ad["Nom"],ad["Prenom"],ad["Statut"])
            livres=[]
            pcs=[]
            ad["Emprunts"].split("//").each{|emp|
                if emp.start_with?('Livre')
                    livres<< Livre.new(emp[/Titre: (.*?),/m, 1],emp[/Auteur: (.*?),/m, 1],emp[/Disponible: (.*?),/m, 1],emp[/ISBN: (.*?),/m, 1].to_i)
                else
                    pcs<< PC.new(emp[/panne: (.*?),/m, 1],emp[/Marque: (.*?),/m, 1],emp[/OS: (.*?),/m, 1],emp[/Disponible: (.*?),/m, 1],emp[/id: (.*?),/m, 1].to_i)
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
            i+=1
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
                adherent.empruntes.delete(item)
                self.emprunts.delete(item)
                item.disponibilite=true
            }
            @adherents.delete adherent
        else
            raise Inconnu, "Adherent non valide"
        end
    end


    def supprimez_document(doc)
        if @documents.include? doc
            @emprunts.each{|item,adh|
                if(item.equal?(doc))
                    adh.rendre(doc,self)
                end
            }
          @documents.delete doc
        else
            raise Inconnu, "Document non valide"
        end
    end


    def supprimez_materiel(mat)
        if @materiels.include? mat
            @emprunts.each{|item,adh|
                if(item.equal?(mat))
                    adh.rendre(mat,self)
                end
            }
          @materiels.delete mat
        else
            raise Inconnu, "Materiel non valide"
        end
    end    


    def rechercherTitre(titre)
        found=[]
        @documents.each{|doc|
            if(doc.titre.eql?(titre))
                found<<doc
            end
        }
        found
    end


    def afficherFonds
        @emprunts.each{|emprunt,adherent|
            print "#{adherent.to_s}"
            print "=>"
            print "#{emprunt.to_s}\n"
        }
    end
    
end