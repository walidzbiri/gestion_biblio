$VERBOSE = nil
# get rid of warnings
$LOAD_PATH << File.dirname(__FILE__)
# include all the includes :)
require 'includes'


class MyServer < SOAP::RPC::StandaloneServer
  include T
  def on_init
    add_method(self, 'menu2')
  end

  def menu2()
      Menus.menu2(T::BIB)
  end
end

# class Test
#   include T
#   def self.main
#       bib = T::BIB
#       fini = false
#       while !fini
#         # Menu 1
#         i=Menus.menu1
#         case i
#           when 1
#               Menus.menu2(bib)
#           when 2
#               Menus.test(bib)
#           when 3
#               server = MyServer.new('RubyServer','urn:ruby:menu2','localhost',33733)
#               server.start
#           when 4
#               fini = true
#         end
#       end
#     end
# end

Test.main()