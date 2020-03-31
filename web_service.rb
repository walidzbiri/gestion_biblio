$VERBOSE = nil
$LOAD_PATH << File.dirname(__FILE__)
require 'includes'

meth = SOAP::RPC::Driver.new('http://localhost:33733','urn:ruby:menu2','RubyServer')
meth.add_method('menu2')
meth.menu2 # lancer la methode menu2 dans le serveur