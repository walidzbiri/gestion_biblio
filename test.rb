# module utlisé comme namespace
module T
    BIB = Biblio.new
end

class Test
  include T
  def self.main
      bib = T::BIB # access to BIB variable in namespace T
      fini = false
      while !fini
        # Menu 1
        i=Menus.menu1
        case i
          when 1
              Menus.menu2(bib)
          when 2
              Menus.test(bib)
          when 3
              server = MyServer.new('RubyServer','urn:ruby:menu2','localhost',33733)
              server.start# server start listening
          when 4
              fini = true
        end
      end
    end
end