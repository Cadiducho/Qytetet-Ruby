#encoding: utf-8

require_relative "casilla"
require_relative "calle"
require_relative "qytetet"
require_relative "tipo_casilla"
require_relative "titulo_propiedad"

module ModeloQytetet
  class Tablero

    attr_reader :casillas
    attr_reader :carcel

    def initialize
      inicializar_tablero
    end

    def inicializar_tablero
      @casillas = Array.new

      salida = Casilla.new(TipoCasilla::SALIDA, 0)
      sorpresa1 = Casilla.new(TipoCasilla::SORPRESA, 3)
      sorpresa2 = Casilla.new(TipoCasilla::SORPRESA, 8)
      sorpresa3 = Casilla.new(TipoCasilla::SORPRESA, 14)
      @carcel = Casilla.new(TipoCasilla::CARCEL, 15)
      juez = Casilla.new(TipoCasilla::JUEZ, 5)
      parking = Casilla.new(TipoCasilla::PARKING, 10)
      impuesto = Casilla.new(TipoCasilla::SORPRESA, 18)
      impuesto.coste = 700

      add_casilla(salida)
      add_casilla(sorpresa1)
      add_casilla(sorpresa2)
      add_casilla(sorpresa3)
      add_casilla(juez)
      add_casilla(@carcel)
      add_casilla(parking)
      add_casilla(impuesto)

      breaking_bad = Calle.new(2000, 19, TituloPropiedad.new("Breaking Bad", 100, 20, 1000, 750))
      narcos = Calle.new(1900, 17, TituloPropiedad.new("Narcos", 100, 19, 950, 750))
      stranger_things = Calle.new(1600, 16, TituloPropiedad.new("Stranger Things", 95, 18, 875, 650))
      thirteenrw = Calle.new(1500, 13, TituloPropiedad.new("Thirteen Reasons Why", 90, 17, 800, 600))
      the_crown = Calle.new(1350, 12, TituloPropiedad.new("The Crown", 85, 16, 650, 500))
      oitnb = Calle.new(1300, 11, TituloPropiedad.new("Orange is the new Black", 80, 15, 500, 425))
      house_of_cards = Calle.new(1100, 9, TituloPropiedad.new("House of Cards", 75, 14, 450, 350))
      jessica = Calle.new(1000, 7, TituloPropiedad.new("Jessica Jones", 70, 13, 350, 350))
      gilmoregirls = Calle.new(950, 6, TituloPropiedad.new("Girlmore Girls", 65, 12, 300, 300))
      senseeight = Calle.new(900, 4, TituloPropiedad.new("Sense8", 60, 11, 250, 300))
      daredevil = Calle.new(800, 2, TituloPropiedad.new("Daredevil", 55, 10, 200, 250))
      shadowhunters = Calle.new(700, 1, TituloPropiedad.new("ShadowHunters", 50, 10, 150, 250))

      add_casilla(breaking_bad)
      add_casilla(narcos)
      add_casilla(stranger_things)
      add_casilla(thirteenrw)
      add_casilla(the_crown)
      add_casilla(oitnb)
      add_casilla(house_of_cards)
      add_casilla(jessica)
      add_casilla(senseeight)
      add_casilla(gilmoregirls)
      add_casilla(daredevil)
      add_casilla(shadowhunters)
    end
    private :inicializar_tablero

    def add_casilla(insertar)
      casillas.each { |agregada|
        if insertar.numero_casilla == agregada.numero_casilla
          puts "La casilla nº: " + insertar.numeroCasilla + " ya esta ocupada"
          return
        end
      }
      casillas << insertar
    end
    private :add_casilla

    def es_casilla_carcel(num_casilla)
      num_casilla == @carcel.numero_casilla
    end

    def obtener_casilla_numero(numero)
      casillas.each { |casilla|
        if casilla.numero_casilla == numero
          return casilla
        end
      }
      nil
    end

    def obtener_nueva_casilla(origen, desplazamiento)
        obtener_casilla_numero((origen.numero_casilla + desplazamiento) % Qytetet::MAX_CASILLAS)
    end

    def to_s
      "Carcel:#{@carcel} \n Casillas: #{@casillas}"
    end
  end
end
