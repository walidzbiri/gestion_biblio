# get rid of warnings
$VERBOSE = nil
$LOAD_PATH << File.dirname(__FILE__)

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

# Lancer le main qui est une methode de classe Test
Test.main()