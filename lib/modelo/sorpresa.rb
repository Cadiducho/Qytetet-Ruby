#encoding: utf-8

require_relative "qytetet"

module ModeloQytetet
  class Sorpresa
    
    attr_reader :texto
    attr_reader :valor
    attr_reader :tipo
      
    def initialize(texto, valor, tipo)
      @texto = texto
      @valor = valor
      @tipo = tipo
    end
    
    def to_s
      resumen = @texto
      pagas_cobras = @valor < 0 ? "Pagas" : "Cobras"
      case @tipo
        when TipoSorpresa::PAGARCOBRAR
          resumen += pagas_cobras + " #{@valor.abs}"
        when TipoSorpresa::IRACASILLA
          resumen += "\n * Vas a la " + (Qytetet.instance.tablero.es_casilla_carcel(@valor) ? "cárcel" : "casilla #{@valor}")
        when TipoSorpresa::PORCASAHOTEL
          resumen += pagas_cobras + " por cada casa y hotel #{@valor.abs}"
        when TipoSorpresa::PORJUGADOR
          resumen += pagas_cobras + " a cada jugador #{@valor.abs}"
        when TipoSorpresa::SALIRCARCEL
          resumen += "Podrás salir de la cárcel"
      end
      resumen
    end 
  end
end
