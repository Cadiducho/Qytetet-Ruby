#encoding: utf-8

require_relative "sorpresa"
require_relative "tipo_sorpresa"
require_relative "tablero"
require "singleton"

module ModeloQytetet
  class Qytetet

    include Singleton

    attr_reader :mazo
    attr_reader :tablero
    attr_reader :jugador_actual
    attr_reader :jugadores

    MAX_JUGADORES = 4
    MAX_CARTAS = 10
    MAX_CASILLAS = 20
    PRECIO_LIBERTAD = 200
    SALDO_SALIDA = 1000

    def initialize
      inicializar_tablero
      inicializar_sorpresas
    end

    def inicializar_tablero
      @tablero = Tablero.new
    end

    def inicializar_sorpresas
      @mazo = Array.new
      mazo << Sorpresa.new("La DEA te ha pillado con cocaína y pasarás un tiempo en Litchfield", tablero.carcel.numero_casilla, TipoSorpresa::IRACASILLA)
      mazo << Sorpresa.new("Encuentras un acceso al Upside Down y te lleva directo a Jackson", 16, TipoSorpresa::IRACASILLA)
      mazo << Sorpresa.new("Te han invitado a una fiesta por la noche en casa de Jessica", 13, TipoSorpresa::IRACASILLA)
      mazo << Sorpresa.new("Los otros jugadores han probado tu producto azul y te pagan unos cuantos gramos", 500, TipoSorpresa::PORJUGADOR)
      mazo << Sorpresa.new("Jessica Jones ha expuesto tus secretos y pagas a los testigos para que nadie hable", -400, TipoSorpresa::PORJUGADOR)
      mazo << Sorpresa.new("Cada celda de pabellón te pagan por tus servicios al protegerles", 300, TipoSorpresa::PORCASAHOTEL)
      mazo << Sorpresa.new("Taylor ha decidido que tu hotel está contruido en un lugar histórico de Stars Hollow", -400, TipoSorpresa::PORCASAHOTEL)
      mazo << Sorpresa.new("El Presidente te otorga un presupuesto solicitado", 600, TipoSorpresa::PAGARCOBRAR)
      mazo << Sorpresa.new("Matt Murdock te ha defendido en un juicio y debes pagar sus honorarios", -700, TipoSorpresa::PAGARCOBRAR)
      mazo << Sorpresa.new("Elisabeth II te ha dado un indulto y puedes abandonar la prisión", 0, TipoSorpresa::SALIRCARCEL)
      
      puts "final"
    end

    def get_sopresas_valor_mayor_cero
      lista = Array.new
      mazo.each { |sorpresa|
        lista << sorpresa if sorpresa.valor > 0
      }
      lista
    end

    def get_sopresas_ir_casilla
      get_sopresas_de_tipo(TipoSorpresa::IRACASILLA)
    end

    def get_sopresas_de_tipo(tipo)
      lista = Array.new
      mazo.each { |sorpresa|
        lista << sorpresa if sorpresa.tipo == tipo
      }
      lista
    end

    def aplicar_sorpresa
      raise NotImplementedError.new
    end

    def cancelar_hipoteca(casilla)
      raise NotImplementedError.new
    end

    def comprar_titulo_propiedad
      raise NotImplementedError.new
    end

    def edificar_casa(casilla)
      raise NotImplementedError.new
    end

    def edificar_hotel(casilla)
      raise NotImplementedError.new
    end

    def get_sorpresa_actual
      raise NotImplementedError.new
    end

    def get_jugador_actual
      raise NotImplementedError.new
    end

    def hipotecar_propiedad(casilla)
      raise NotImplementedError.new
    end

    def inicializar_juego(nombres)
      raise NotImplementedError.new
    end

    def intentar_salir_carcel(metodo)
      raise NotImplementedError.new
    end

    def jugar
      raise NotImplementedError.new
    end

    def obtener_ranking
      raise NotImplementedError.new
    end

    def propiedades_hipotecadas_jugador(hipotecadas)
      @jugador_actual.obtener_propiedades_hipotecadas(hipotecadas)
    end

    def siguiente_jugador
      nextPlayer = 0
      if @jugador_actual != nil
        index = @jugadores.index(@jugador_actual)
        if index > (@jugadores.size - 1)
          nextPlayer = index
        end
      end
      @jugador_actual = jugadores[nextPlayer]
    end

    def vender_propiedad(casilla)
      raise NotImplementedError.new
    end

    private
    def encarcelar_jugador
      raise NotImplementedError.new
    end

    def inicializar_jugadores(nombres)
      nombres.each {|n|
        @jugadores << Jugador.new(n)
      }
    end
    
    def salida_jugadores()
      @jugadores.each{ |j|
        j.casilla_actual = @tablero.obtener_casilla_numero(0)
        j.saldo = 7500
      }
    end
  end
end