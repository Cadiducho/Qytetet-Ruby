#encoding: utf-8

require_relative "titulo_propiedad"

module ModeloQytetet
  class Casilla
    attr_reader :numero_casilla
    attr_accessor :coste
    attr_reader :tipo
    
    def initialize(tipo, num_casilla)
      @numero_casilla = num_casilla
      @tipo = tipo
      @coste = 0
    end

    def soy_edificable
      false
    end
    
    def to_s
      "Casilla ##{@numero_casilla} (#{@tipo}). "
    end

  end
end
