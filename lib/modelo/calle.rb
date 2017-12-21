#encoding: utf-8

require_relative "casilla"

module ModeloQytetet
  class Calle < Casilla

    attr_accessor :titulo
    attr_accessor :num_hoteles
    attr_accessor :num_casas

    def initialize(coste, num_casilla, titulo)
      super(TipoCasilla::CALLE, num_casilla)

      @coste = coste
      @num_hoteles = 0
      @num_casas = 0
      @titulo = titulo
      @titulo.calle = self
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

    def propietario_encarcelado
      @titulo.propietario.encarcelado
    end

    def se_puede_edificar_casa
      @num_casas < (4 * @titulo.propietario.factor_especulador)
    end

    def se_puede_edificar_hotel
      @num_hoteles < (4 * @titulo.propietario.factor_especulador) && @num_casas >= 4
    end

    def soy_edificable
      true
    end

    def tengo_propietario
      @titulo != nil ? @titulo.tengo_propietario : false
    end

    def vender_titulo
      (@coste + @titulo.factor_revalorizacion * (@coste + (@num_casas + @num_hoteles) * @titulo.get_precio_edificar)).round
    end

    def to_s
      resumen = "Calle ##{@numero_casilla}. "
      if tengo_propietario
         resumen += "\n * Propietario: #{@titulo.propietario.nombre}. Tiene #{@num_casas} casas y #{@num_hoteles} hoteles. Alquiler: #{cobrar_alquiler}$. Hipoteca: #{calcular_valor_hipoteca}$. Hipotecada: #{esta_hipotecada}"
         if propietario_encarcelado
           resumen += "\n * Su propietario está encarcelado. "
         end
      else
         resumen += "\n * En venta por #{coste}$: #{@titulo}"
      end
      resumen
    end

  end
end