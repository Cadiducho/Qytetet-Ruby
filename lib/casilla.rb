require_relative "titulo_propiedad"

module ModeloQytetet
  class Casilla
    attr_reader :numero_casilla
    attr_accessor :coste
    attr_accessor :num_hoteles
    attr_accessor :num_casas
    attr_reader :tipo
    attr_accessor :titulo
    
    def initialize(tipo, numCasilla)
      @numero_casilla = numCasilla
      @tipo = tipo
      @coste = 0
      @num_hoteles = 0
      @num_casas = 0
    end
    
    def self.new_street(coste, numCasilla, titulo)
      cas = new(TipoCasilla::CALLE, numCasilla)
      cas.coste = coste
      cas.num_hoteles = 0
      cas.num_casas = 0
      cas.titulo = titulo
      cas.titulo.casilla = cas
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
      @titulo.isHipotecada
    end

    def get_coste_hipoteca
      @titulo.hipoteca_base + @num_casas * 0.5 + @titulo.hipoteca_base + @num_hoteles * @titulo.hipoteca_base
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
      @titulo != nil ? @titulo.propietario.encarcelado : false
    end

    def se_puede_edificar_casa
      raise NotImplementedError.new
    end

    def se_puede_edificar_hotel
      raise NotImplementedError.new
    end

    def soy_edificable
      @tipo == TipoCasilla::CALLE
    end

    def tengo_propietario
      @titulo != nil ? @titulo.tengo_propietario : false
    end

    def vender_titulo
      raise NotImplementedError.new
    end
    
    def to_s
      "NumeroCasilla #{@numero_casilla} \n Coste: #{@coste} \n NumHoteles: #{@num_hoteles} \n NumCasas #{@numCasas}\n Tipo: #{@tipo}"
    end

  end
end
