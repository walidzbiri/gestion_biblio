# Un ensemble d'Exceptions qui hérite depuis la classe RuntimeError
class Inconnu  < RuntimeError

end

class Indisponible < RuntimeError

end

class MaxEmpruntes < RuntimeError

end

class PasEmpruntable < RuntimeError

end

class DejaEmprunte < RuntimeError

end