# get rid of warnings
$VERBOSE = nil
$LOAD_PATH << File.dirname(__FILE__)
require 'test'

module Menus

    def Menus::menu2(bib)
      puts "-------------------------------Sous Menu--------------------------------------"

      puts "1- Ajouter-adhérent"
      puts "2- Ajouter-Livre"
      puts "3- Ajouter-PC"
  
      puts "--------------"
      puts "4- Retourner adhérent"
      puts "5- Retourner Document"
      puts "6- Retourner Matériel"
  
      puts "--------------"
      puts "7- Lister les adherents"
      puts "8- Lister les documents"
      puts "9- Lister les matériels"
      puts "10-Lister les ids des matériels"
  
  
      puts "--------------"
      puts "11- Supprimer Adherent de la bibliothèque"
      puts "12- Supprimer Documment de la bibliothèque"
      puts "13- Supprimer Matériel de la bibliothèque"
  
      puts "--------------"
      puts "14- Emprunter Livre"
      puts "15- Emprunter Ordinateur"
  
      puts "--------------"
      puts "16- Rendre un livre"
      puts "17- Rendre un Ordinateur"
  
      puts "--------------"
      puts "18- Afficher les emprunts d'un adhérent"
      puts "19- Afficher tous les emprunts"

      puts "--------------"
      puts "20- Charger la biblio dans des csv"
      puts "21- Charger la biblio depuis des csv"

      puts "--------------"
      puts "22- Recherche une chaine de caractères dans le livre war_and_peace.txt"
      puts "23- Affiche les 10 mots les plus utilisés dans le livre war_and_peace.txt"

      print "Saisir votre choix: "
  
      second_choice =gets.chomp
      j = second_choice.to_i
  
      case j
        when 1
          print "Entrer le nom de l'adhérent: "
          nom = gets.chomp
          print "Entrer le prénom de l'adhérent: "
          prenom = gets.chomp
          print "Choisir le Statut de l'adhérent: \n"
          puts "1-Etudiant"
          puts "2-Enseignant"
          print "=>"
          statut = ["Etudiant","Enseignant"]
          num = gets.chomp.to_i
          num == 1 ? sta = statut[0] : sta= statut[1]
          a = Adherent.new(nom,prenom,sta)
          begin
            bib.add_adherent(a)
          rescue  Inconnu => e
            puts e.message
          end
  
        when 2
          print "Entrer le titre du livre: "
          titre= gets.chomp
          print "Choisir la disponibilité du livre: \n"
          puts "1- Disponible"
          puts "2- Non diponible"
          print "=>"
          num = gets.chomp.to_i
          num==1 ? dispo=true  : dispo=false
          print "Entrer l'auteur du livre: "
          auteur= gets.chomp
          l = Livre.new(titre,auteur,dispo)
          begin
          bib.add_Document(l)
          rescue  Inconnu => e
            puts e.message
          end

        when 3  
          print "Entrer la marque du PC: "
          marque= gets.chomp
          print "Quel OS ? \n"
          puts "1-Linux"
          puts "2-Windows"
          print "=>"
          num = gets.chomp.to_i
          num == 1 ? os = "Linux" : os = "Windows"
          print "Choisir la dispo du pc: \n"
          puts "1-Disponible"
          puts "2-Non diponible"
          print "=>"
          num=gets.chomp.to_i
          num==1 ? dispo=true  : dispo=false
          print "L'état du pc: \n"
          puts "1- En panne"
          puts "2- En marche"
          print "=>"
          num2=gets.chomp.to_i
          num2==1 ? panne=true  : panne = false
          m = PC.new(panne,marque,os,dispo)
          begin
          bib.add_Materiel(m)
          rescue  Inconnu => e
            puts e.message
          end
  
        when 4
          print "Saisir l'id de l'adherent à rechercher: "
          id = gets.chomp.to_i
          begin
          puts bib.get_adherent(id)
          rescue  Inconnu => e
            puts e.message
          end
  
        when 5
          print "Saisir l'ISBN du document à rechercher: "
          isbn = gets.chomp.to_i
          begin
          puts bib.get_document(isbn)
          rescue  Inconnu => e
            puts e.message
          end
  
        when 6
          print "Saisir l'id du Matériel à rechercher: "
          id = gets.chomp.to_i
          begin
          puts bib.get_materiel(id)
          rescue  Inconnu => e
            puts e.message
          end
          
  
        when 7
          puts "Liste des adherents: "
          bib.adherents.each{|adh|
            puts adh.to_s
          }
  
        when 8
          puts "Liste des Livres: "
          bib.documents.each{|doc|
            puts doc.to_s
          }
        when 9
          puts "Liste des PC: "
          bib.materiels.each{|mat|
            puts mat.to_s
          }
        
        when 10
          puts "Liste ID des PC: "
          bib.materiels.each{|mat|
            puts mat.id
          }
  
        when 11
          print "Saisir l'id d'adherent à supprimez:"
          id = gets.chomp.to_i
          begin
          goal = bib.get_adherent(id)
          rescue  Inconnu => e
            puts e.message
          end
          begin
          bib.supprimez_adherent(goal)
          rescue  Inconnu => e
            puts e.message
          end

        when 12
          print "Saisir l'ISBN du livre à supprimez: "
          isbn = gets.chomp.to_i
          begin
          goal = bib.get_document(isbn)
          rescue  Inconnu => e
            puts e.message
          end
          begin
          bib.supprimez_document(goal)
          rescue  Inconnu => e
            puts e.message
          end


        when 13
          print "Saisir l'id du Matériel à supprimez: "
          id = gets.chomp.to_i
          begin
          goal = bib.get_materiel(id)
          rescue  Inconnu => e
            puts e.message
          end
          begin
           bib.supprimez_materiel(goal)
          rescue  Inconnu => e
            puts e.message
          end
  
        when 14
          print "Saisir l'id d'adhérent: "
          i = gets.chomp.to_i
          begin
              a = bib.get_adherent(i)
              print "Saisir l'ISBN du livre: "
              isbn = gets.chomp.to_i
              goal = bib.get_document(isbn)
              a.emprunter(goal,bib)
          rescue  Inconnu => e
              puts e.message
          rescue DejaEmprunte => d
              puts d.message
          rescue Indisponible => c
              puts c.message
          rescue MaxEmpruntes => m
              puts m.message
          rescue PasEmpruntable => pa
              puts pa.message
          end


        when 15
          print "Saisir l'id d'adhérent: "
          id=gets.chomp.to_i
          begin
              a=bib.get_adherent(id)
              print "Saisir l'id de l'Ordinateur: "
              id_o=gets.chomp.to_i
              pc = bib.get_materiel(id_o)
              a.emprunter(pc,bib)
          rescue  Inconnu => e
              puts e.message
          rescue DejaEmprunte => d
              puts d.message
          rescue Indisponible => c
              puts c.message
          rescue MaxEmpruntes => m
              puts m.message
            rescue PasEmpruntable => pa
              puts pa.message
          end


        when 16
          print "Saisir l'ID d'adhérent: "
          id=gets.chomp.to_i
          begin
              a=bib.get_adherent(id)
              print "Saisir l'ISBN du livre à rendre: "
              isbn = gets.chomp.to_i
              l = bib.get_document(isbn)
              a.rendre(l,bib)
          rescue  Inconnu => e
              puts e.message
          rescue DejaEmprunte => d
              puts d.message
          rescue Indisponible => c
              puts c.message
          rescue MaxEmpruntes => m
              puts m.message
          rescue PasEmpruntable => pa
              puts pa.message
          end


        when 17
          print "Saisir l'id d'adhérent: "
          id = gets.chomp.to_i
          begin
              a = bib.get_adherent(id)
              print "Saisir l'ID de l'Ordinateur: "
              id = gets.chomp.to_i
              goal = bib.get_materiel(id)
              a.rendre(goal,bib)
          rescue  Inconnu => e
              puts e.message
          rescue DejaEmprunte => d
              puts d.message
          rescue Indisponible => c
              puts c.message
          rescue MaxEmpruntes => m
              puts m.message
          rescue PasEmpruntable => pa
              puts pa.message
          end

        when 18
            print "Saisir l'id d'adhérent: "
            id = gets.chomp.to_i
            begin
              a = bib.get_adherent(id)
              a.afficherEmpruntes()
            rescue  Inconnu => e
              puts e.message
            rescue DejaEmprunte => d
                puts d.message
            rescue Indisponible => c
                puts c.message
            rescue MaxEmpruntes => m
                puts m.message
            rescue PasEmpruntable => pa
                puts pa.message
            end
            
        when 19
          begin
            bib.afficherFonds()
          rescue  Inconnu => e
            puts e.message
          rescue DejaEmprunte => d
              puts d.message
          rescue Indisponible => c
              puts c.message
          rescue MaxEmpruntes => m
              puts m.message
          rescue PasEmpruntable => pa
              puts pa.message
          end

        when 20
          begin
            bib.save()
            puts "Sauvegarde Avec succéss"
          rescue  Inconnu => e
            puts e.message
          rescue DejaEmprunte => d
              puts d.message
          rescue Indisponible => c
              puts c.message
          rescue MaxEmpruntes => m
              puts m.message
          rescue PasEmpruntable => pa
              puts pa.message
          end

        when 21
          begin
            bib.load()
            puts "Chargement Avec succéss" 
          rescue  Inconnu => e
            puts e.message
          rescue DejaEmprunte => d
              puts d.message
          rescue Indisponible => c
              puts c.message
          rescue MaxEmpruntes => m
              puts m.message
          rescue PasEmpruntable => pa
              puts pa.message
          end 
        
        when 22
          begin
            print "Entrez le mot que vous voulez: "
            mot=gets.chomp.downcase
            mon_hash =Hash.new(0)
            text=File.read("livre.txt")
            mon_tab=text.downcase.tr(".,!:","").split(" ")
            mon_tab.each{ |i|
              mon_hash[i]+=1
            }
            puts "Le mot #{mot} apparait "+mon_hash[mot].to_s+ " fois"
          rescue  Inconnu => e
            puts e.message
          rescue DejaEmprunte => d
              puts d.message
          rescue Indisponible => c
              puts c.message
          rescue MaxEmpruntes => m
              puts m.message
          rescue PasEmpruntable => pa
              puts pa.message
          end

        when 23
          begin
            text=File.read("livre.txt");
            mon_hash =Hash.new(0)
            mon_tab=text.downcase.tr(".,!:","").split(" ")
            mon_tab.each{ |i|
                mon_hash[i]+=1
            }
            result=mon_hash.sort_by {|key,value| value}.reverse.to_h
            result.keys[0..9].each{|key| puts "#{key}=>#{result[key]}"}
          rescue  Inconnu => e
            puts e.message
          rescue DejaEmprunte => d
              puts d.message
          rescue Indisponible => c
              puts c.message
          rescue MaxEmpruntes => m
              puts m.message
          rescue PasEmpruntable => pa
              puts pa.message
          end

      end
      Test.main()
    end


    def Menus::menu1
      puts "-------------------------------Menu Principale--------------------------------------"
      puts "Accueil: "
      puts "1-Sous Menu (manuel)"
      puts "2-Lancer tous le sous menu"
      puts "3-Lancer le sous menu via un web service"
      puts "4-Terminer"
      print "Saisir votre choix: "
      choice = gets.chomp
      i = choice.to_i
    end

    # automatique test hard coded
    def Menus::test(bib)
      adherent = Adherent.new("Zbiri","Walid","Etudiant")
      livre = Livre.new("12687","ReactJS","Oreilly",true)
      pc = PC.new(false,"HP","Linux",true)
      bib.add_adherent(adherent)
      puts "Adhérent #{adherent.to_s} est ajouté"
      bib.add_Materiel(pc)
      puts "PC #{pc.to_s} ajouté"
      bib.add_Document(livre)
      puts "Livre #{livre.to_s} ajouté"
      puts "Liste des documents"
      puts bib.documents.inspect
      puts "Liste des ordinateurs"
      puts bib.materiels.inspect
      puts "Liste des adhérents:"
      puts bib.adherents.inspect
      adherent.emprunter(livre,bib)
      puts "#{livre.to_s} emprunté par l'adhérent #{adherent.to_s }"
      adherent.rendre(livre,bib)
      puts"#{livre.to_s} => rendu"
      bib.afficherFonds()
      bib.supprimez_adherent(adherent)
      puts "Adhérent #{adherent.to_s} =>  supprimé"
      bib.supprimez_materiel(pc)
      puts "PC #{pc.to_s} => supprimé\n"
    end

end