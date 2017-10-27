module ModeloQytetet
  class TituloPropiedad
    
    attr_reader :nombre
    attr_accessor :hipotecada
    attr_reader :alquilerBase
    attr_reader :factorRevalorizacion
    attr_reader :hipotecaBase
    attr_reader :precioEdificar
    attr_accessor :propietario
    attr_accessor :casilla
    def initialize(nombre, alquilerBase, factorRevalorizacion, hipotecaBase, precioEdificar)
      @nombre = nombre
      @hipotecada = false;
      @alquilerBase = alquilerBase
      @factorRevalorizacion = factorRevalorizacion
      @hipotecaBase = hipotecaBase
      @precioEdificar = precioEdificar
      @casilla = nil
      @propietario = nil
    end

    def tengo_propietario
      @propietario != nil
    end

    def propietaro_encarcelado
      tengo_propietario ? @propietario.encarcelado : false
    end
    
    def to_s
      "Nombre #{nombre} \n Hipotecada #{hipotecada} \n AlquilerBase #{@alquilerBase} 
        \n FactorRevalorizacion #{@factorRevalorizacion}\n HipotecaBase #{@hipotecaBase} PrecioEdificar #{@precioEdificar}"
    end 
  end
end
