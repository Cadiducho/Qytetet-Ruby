#encoding: utf-8

require_relative "casilla"
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

      add_casilla(salida)
      add_casilla(sorpresa1)
      add_casilla(sorpresa2)
      add_casilla(sorpresa3)
      add_casilla(juez)
      add_casilla(@carcel)
      add_casilla(parking)
      add_casilla(impuesto)

      breaking_bad = Casilla.new_street(2000, 19)
      breaking_bad.titulo = TituloPropiedad.new("Breaking Bad", 100, 20, 1000, 750)
      breaking_bad.titulo.casilla = breaking_bad
      
      narcos = Casilla.new_street(1900, 17)
      stranger_things = Casilla.new_street(1600, 16)
      thirteenrw = Casilla.new_street(1500, 13)
      the_crown = Casilla.new_street(1350, 12)
      oitnb = Casilla.new_street(1300, 11)
      house_of_cards = Casilla.new_street(1100, 9)
      jessica = Casilla.new_street(1000, 7)
      gilmoregirls = Casilla.new_street(950, 6)
      senseeight = Casilla.new_street(900, 4)
      daredevil = Casilla.new_street(800, 2)
      shadowhunters = Casilla.new_street(700, 1)

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

    def add_casilla(insertar)
      casillas.each { |agregada|
        if insertar.numeroCasilla == agregada.numeroCasilla
          puts "La casilla nº: " + insertar.numeroCasilla + " ya esta ocupada"
          return
        end
      }
      casillas << insertar
    end
    private :add_casilla

    def es_casilla_carcel(casilla)
      casilla.numeroCasilla == @carcel.numeroCasilla
    end

    def obtener_casilla_numero(numero)
      casillas.each { |casilla|
        if casilla.numeroCasilla = numero
            return casilla
        end
      }
      nil
    end

    def obtener_nueva_casilla(origen, desplazamiento)
        obtener_casilla_numero((origen.numeroCasilla + desplazamiento) % Qytetet.instance.MAX_CASILLAS)
    end

    def to_s
      "Carcel:#{@carcel} \n Casillas: #{@casillas}"
    end
  end
end
