#encoding: utf-8

require_relative "titulo_propiedad"

module ModeloQytetet
  class Casilla
    attr_reader :numero_casilla
    attr_accessor :coste
    attr_accessor :num_hoteles
    attr_accessor :num_casas
    attr_reader :tipo
    attr_accessor :titulo
    
    def initialize(tipo, num_casilla)
      @numero_casilla = num_casilla
      @tipo = tipo
      @coste = 0
      @num_hoteles = 0
      @num_casas = 0
      @titulo = nil
    end
    
    def self.new_street(coste, num_casilla, titulo)
      cas = new(TipoCasilla::CALLE, num_casilla)
      cas.coste = coste
      cas.num_hoteles = 0
      cas.num_casas = 0
      cas.titulo = titulo
      cas.titulo.casilla = cas
      cas
    end

    def asignar_propietario(jugador)
      @titulo.propietario = jugador

      @titulo
    end

    def calcular_valor_hipoteca
      (@titulo.hipoteca_base * num_casas * 0.5 * @titulo.hipoteca_base + num_hoteles * @titulo.hipoteca_base).round
    end

    def cancelar_hipoteca
      @titulo.hipotecada = false

      (calcular_valor_hipoteca * 1.10).round
    end

    def cobrar_alquiler
      (@titulo.alquiler_base + (num_casas * 0.5 + num_hoteles * 2)).round
    end

    def edificar_casa
      @num_casas += 1
      get_precio_edificar
    end

    def edificar_hotel
      @num_hoteles += 1
      @num_casas -= 4
      get_precio_edificar
    end

    def esta_hipotecada
      @titulo.hipotecada
    end

    def get_coste_hipoteca
      @titulo.hipoteca_base + @num_casas * 0.5 + @titulo.hipoteca_base + @num_hoteles * @titulo.hipoteca_base
    end

    def get_precio_edificar
      @titulo.precio_edificar
    end

    def hipotecar
      @titulo.hipotecada = true
      calcular_valor_hipoteca
    end

    def precio_total_comprar
      raise NotImplementedError.new
    end

    def propietario_encarcelado
      if @titulo != nil
        @titulo.propietario != nil ? @titulo.propietario.encarcelado : false
      else
        false
      end
    end

    def se_puede_edificar_casa
      @num_casas < 4
    end

    def se_puede_edificar_hotel
      @num_hoteles < 4 && @num_casas >= 4
    end

    def soy_edificable
      @tipo == TipoCasilla::CALLE
    end

    def tengo_propietario
      @titulo != nil ? @titulo.tengo_propietario : false
    end

    def vender_titulo
      (coste + @titulo.factor_revalorizacion * (@coste + (@num_casas + @num_hoteles) * @titulo.get_precio_edificar)).round
    end
    
    def to_s
      resumen = "Casilla ##{@numero_casilla} (#{@tipo}). "
      if soy_edificable
        if tengo_propietario
          resumen += "\n * Propietario: #{@titulo.propietario.nombre}. Tiene #{@num_casas} casas y #{@num_hoteles} hoteles. Alquiler: #{cobrar_alquiler}$. Hipoteca: #{calcular_valor_hipoteca}$. Hipotecada: #{esta_hipotecada}"
        else
          resumen += "\n * En venta por #{coste}$: #{@titulo}"
        end
      end
      if propietario_encarcelado
        resumen += "\n * Su propietario está encarcelado. "
      end
      resumen
    end

  end
end
