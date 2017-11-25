module ModeloQytetet
  class TituloPropiedad
    
    attr_reader :nombre
    attr_accessor :hipotecada
    attr_reader :alquiler_base
    attr_reader :factor_revalorizacion
    attr_reader :hipoteca_base
    attr_reader :precio_edificar
    attr_accessor :propietario
    attr_accessor :casilla
    def initialize(nombre, alquiler_base, factor_reval, hipoteca_base, precio_edificar)
      @nombre = nombre
      @hipotecada = false
      @alquiler_base = alquiler_base
      @factor_revalorizacion = factor_reval
      @hipoteca_base = hipoteca_base
      @precio_edificar = precio_edificar
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
      "Nombre #{nombre} \n Hipotecada #{hipotecada} \n AlquilerBase #{@alquiler_base}
        \n FactorRevalorizacion #{@factor_revalorizacion}\n HipotecaBase #{@hipoteca_base} PrecioEdificar #{@precio_edificar}"
    end 
  end
end
