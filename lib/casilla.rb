require_relative "titulo_propiedad"

module ModeloQytetet
  class Casilla
    attr_reader :numeroCasilla
    attr_accessor :coste
    attr_accessor :numHoteles
    attr_accessor :numCasas
    attr_reader :tipo
    attr_accessor :titulo
    
    def initialize(tipo, numCasilla)
      @numeroCasilla = numCasilla
      @tipo = tipo
      @coste = 0
      @numHoteles = 0
      @numCasas = 0
    end
    
    def self.new_street(coste, numCasilla)
      cas = new(TipoCasilla::CALLE, numCasilla)
      cas.coste = coste
      cas.numHoteles = 0
      cas.numCasas = 0
      cas
    end

    def asignar_propietario(jugador)
      raise NotImplementedError.new
    end

    def calcular_valor_hipoteca
      raise NotImplementedError.new
    end

    def cancelar_hipoteca
      raise NotImplementedError.new
    end

    def cobrar_alquiler
      raise NotImplementedError.new
    end

    def edificar_casa
      raise NotImplementedError.new
    end

    def edificar_hotel
      raise NotImplementedError.new
    end

    def esta_hipotecada
      raise NotImplementedError.new
    end

    def get_coste_hipoteca
      raise NotImplementedError.new
    end

    def get_precio_edificar
      raise NotImplementedError.new
    end

    def hipotecar
      raise NotImplementedError.new
    end

    def precio_total_comprar
      raise NotImplementedError.new
    end

    def propietario_encarcelado
      raise NotImplementedError.new
    end

    def se_puede_edificar_casa
      raise NotImplementedError.new
    end

    def se_puede_edificar_hotel
      raise NotImplementedError.new
    end

    def soy_edificable
      raise NotImplementedError.new
    end

    def tengo_propietario
      raise NotImplementedError.new
    end

    def vender_titulo
      raise NotImplementedError.new
    end
    
    def to_s
      "NumeroCasilla #{@numeroCasilla} \n Coste: #{@coste} \n NumHoteles: #{@numHoteles} \n NumCasas #{@numCasas}\n Tipo: #{@tipo}"
    end 
  end
end
