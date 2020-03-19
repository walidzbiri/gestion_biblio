$VERBOSE = nil
# get rid of warnings
$LOAD_PATH << File.dirname(__FILE__)
# include all the includes :)
require 'test'
module Menus
    def Menus::menu2(bib)
      puts " MENU 2"
      puts "--------------"
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

      print "Saisir votre choix : "
  
      second_choice =gets.chomp
      j = second_choice.to_i
  
      case j
        when 1
          print "Entrer le nom de l'adhérent: "
          nom = gets.chomp
          print "Entrer le prénom de l'adhérent: "
          prenom = gets.chomp
          print "Choisir le Statut de l'adhérent: "
          puts "1-Etudiant"
          puts "2-Enseignant"
          print "=>"
          statut = ["Etudiant","Enseignant"]
          num = gets.chomp.to_i
          num == 1 ? sta = statut[0] : sta= statut[1]
          a = Adherent.new(nom,prenom,sta)
          bib.add_adherent(a)
  
        when 2
          print "Entrer ISBN: "
          isbn = gets.chomp.to_i
          print "Entrer le titre du livre: "
          titre= gets.chomp
          print "Choisir la disponibilité du livre: "
  
          puts "1-Disponible"
          puts "2-Non diponible"
          print "=>"
          num = gets.chomp.to_i
          num==1 ? dispo=true  : dispo=false
          print "Entrer l'auteur du livre: "
          auteur= gets.chomp
          l = Livre.new(isbn, titre,auteur,dispo)
          bib.add_Document(l)
  
        when 3  
          print "Entrer la marque du PC: "
          marque= gets.chomp
          print "Quel OS ? "
          puts "1-Linux"
          puts "2-Windows"
          print "=>"
          num = gets.chomp.to_i
          num == 1 ? os = "Linux" : os = "Windows"
          print "Choisir la dispo du pc: "
          puts "1-Disponible"
          puts "2-Non diponible"
          print "=>"
          num=gets.chomp.to_i
          num==1 ? dispo=true  : dispo=false
          print "L'état du pc: "
          puts "1 - En panne"
          puts "2 - En marche"
          print "=>"
          num2=gets.chomp.to_i
          num2==1 ? panne=true  : panne = false
          m = PC.new(panne,marque,os,dispo)
          bib.add_Materiel(m)
  
        when 4
          print "Saisir l'id de l'adherent à rechercher: "
          id = gets.chomp.to_i
          print bib.get_adherent(id)

  
        when 5
  
          print "Saisir l'ISBN du document à rechercher: "
          isbn = gets.chomp.to_i
          print bib.get_document(isbn)
  
        when 6
          print "Saisir l'id du Matériel à rechercher: "
          id = gets.chomp.to_i
          print bib.get_materiel(id)
          
  
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
  
        when 11
          print "Saisir l'id d'adherent à supprimez:"
          id = gets.chomp.to_i
          goal = bib.get_adherent(id)
          bib.supprimez_adherent(goal)
          puts "suppression avec success!"
        when 12
          print "Saisir l'ISBN du livre à supprimez: "
          isbn = gets.chomp.to_i
          goal = bib.get_document(isbn)
          bib.supprimez_document(goal)
          puts "suppression avec success!"
        when 13
  
          print "Saisir l'id du Matériel à supprimez: "
          id = gets.chomp.to_i
          goal = bib.get_materiel(id)
          bib.supprimez_materiel(goal)
          puts "suppression avec success!"
  
        when 14
  
          print "Saisir l'id d'adhérent: "
          i = gets.chomp.to_i
          a = bib.get_adherent(i)
          print "Saisir l'ISBN du livre: "
          isbn = gets.chomp.to_i
          goal = bib.get_document(isbn)
          a.emprunter(goal,bib)
          puts "Emprunt livre avec success!"
        when 15
  
          print "Saisir l'id d'adhérent: "
          id=gets.chomp.to_i
          a=bib.get_adherent(id)
          print "Saisir l'id de l'Ordinateur: "
          id_o=gets.chomp.to_i
          pc = bib.get_materiel(id_o)
          a.emprunter(pc,bib)
          puts "Emprunt pc avec success!"
        when 16
  
          print "Saisir l'ID d'adhérent: "
          id=gets.chomp.to_i
          a=bib.get_adherent(id)
          print "Saisir l'ISBN du livre à rendre: "
          isbn = gets.chomp.to_i
          l = bib.get_document(isbn)
          a.rendre(l,bib)
          puts "Rendre livre avec success!"
        when 17
  
          print "Saisir l'id d'adhérent: "
          id = gets.chomp.to_i
          a = bib.get_adherent(id)
          print "Saisir l'ID de l'Ordinateur: "
          id = gets.chomp
          goal = bib.get_materiel(id)
          a.rendre(goal,bib)
          puts "Rendre PC avec success!"
        when 18

            print "Saisir l'id d'adhérent: "
            id = gets.chomp.to_i
            a = bib.get_adherent(id)
            a.afficherEmpruntes()
            
    
        when 19
          bib.afficherFonds()
        when 20
          bib.save()
          puts "Avec succéss" 
      end
      Test.main()
    end

    def Menus::menu1
      puts "-------------------------------------------------------------------------------"
    puts "Accueil: "
    puts "1-Sous Menu (manuel)"
    puts "2-Lancer tous le sous menu"
    puts "3-Lancer le sous menu via un web service"
    puts "4-Terminer"
    print "Saisir votre choix: "
    choice = gets.chomp
    i = choice.to_i
    end


    def Menus::test(bib)
      adherent = Adherent.new("Ayoub","Ed-dafali","Etudiant")
      livre = Livre.new("SDFG65S","Deduction","Sherlock Holmes",true)
      pc = PC.new(false,"HP","Windows",true)
      bib.add_adherent(adherent)
      print "Adhérent #{adherent.to_s} est ajouté"
      bib.add_Document(livre)
      print "Livre #{livre.to_s} ajouté"
      bib.add_Materiel(pc)
      print "PC #{pc.to_s} ajouté"
      print "Liste des adhérents:"
      print bib.adherents.inspect
      print "Liste des documents"
      print bib.documents.inspect
      print "Liste des ordinateurs"
      print bib.materiels.inspect
  
      adherent.emprunter(livre,bib)
      print "Livre #{livre.to_s} emprunté par l'adhérent #{adherent.to_s }"
  
      # adherent.rendre(livre,bib)
      # print"Livre #{livre.to_s} rendu"
      # bib.afficherFonds()
  
      # bib.supprimez_adherent(adherent)
      # print "Adhérent #{adherent.to_s} supprimé"
      # bib.supprimez_materiel(pc)
      # print "PC #{pc.to_s} supprimé"
    end
  end