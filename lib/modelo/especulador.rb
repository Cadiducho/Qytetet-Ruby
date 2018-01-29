#encoding: utf-8

require_relative "jugador"

module ModeloQytetet
  class Especulador < Jugador
    def initialize(jugador, fianza)
      super(jugador.nombre)
      constructor_copia(jugador)

      @fianza = fianza
      @@factor_especulador = 2
    end

    protected
    def pagar_impuestos(cantidad)
      modificar_saldo(-1 * cantidad / 2)
    end

    def ir_a_carcel(casilla)
      if pagar_fianza(@fianza)
        super
      end
    end

    private
    def pagar_fianza(cantidad)
      tengo_saldo = tengo_saldo(cantidad)
      if tengo_saldo
          modificar_saldo(-1 * cantidad)
      end
      tengo_saldo
    end
  end
end