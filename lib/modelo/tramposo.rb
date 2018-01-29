#encoding: utf-8

require_relative "jugador"

module ModeloQytetet
  class Tramposo < Jugador
    
    attr_reader :numero_trampas, :fraude
    
    def initialize(jugador)
      super(jugador.nombre)
      constructor_copia(jugador)
      
      @numero_trampas = 0
      @fraude = 0
    end
    
    def modificar_saldo(cantidad) 
      if cantidad < 0
        if rand(2) == 0
          cantidad /= 2
          
          @fraude += (-1) * cantidad
          @numero_trampas += 1
        end
      end
      
      super
    end
    
    def perdonar
      @numero_trampas = 0
      @fraude = 0
    end

    def to_s
      resumen = super
      resumen += "\n Ha hecho trampas #{@numero_trampas} veces.";
      resumen += "\n Ha defraudado un total de #{@fraude}$";
      
      resumen
    end
  end
end