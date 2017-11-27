#encoding: utf-8

require_relative "sorpresa"
require_relative "tipo_sorpresa"
require_relative "metodo_salir_carcel"
require_relative "tablero"
require_relative "jugador"
require_relative "dado"
require "singleton"

module ModeloQytetet
  class Qytetet

    include Singleton

    attr_reader :mazo
    attr_reader :tablero
    attr_reader :jugador_actual
    attr_reader :carta_actual
    attr_reader :jugadores

    MAX_JUGADORES = 4
    MAX_CARTAS = 10
    MAX_CASILLAS = 20
    PRECIO_LIBERTAD = 200
    SALDO_SALIDA = 1000

    def inicializar_juego(nombres)
      inicializar_jugadores(nombres)
      inicializar_tablero
      inicializar_sorpresas
      salida_jugadores
    end

    def inicializar_tablero
      @tablero = Tablero.new
    end

    def inicializar_sorpresas
      @mazo = Array.new
      @mazo << Sorpresa.new("La DEA te ha pillado con cocaína y pasarás un tiempo en Litchfield", @tablero.carcel.numero_casilla, TipoSorpresa::IRACASILLA)
      @mazo << Sorpresa.new("Encuentras un acceso al Upside Down y te lleva directo a Jackson", 16, TipoSorpresa::IRACASILLA)
      @mazo << Sorpresa.new("Te han invitado a una fiesta por la noche en casa de Jessica", 13, TipoSorpresa::IRACASILLA)
      @mazo << Sorpresa.new("Los otros jugadores han probado tu producto azul y te pagan unos cuantos gramos", 500, TipoSorpresa::PORJUGADOR)
      @mazo << Sorpresa.new("Jessica Jones ha expuesto tus secretos y pagas a los testigos para que nadie hable", -400, TipoSorpresa::PORJUGADOR)
      @mazo << Sorpresa.new("Cada celda de pabellón te pagan por tus servicios al protegerles", 300, TipoSorpresa::PORCASAHOTEL)
      @mazo << Sorpresa.new("Taylor ha decidido que tu hotel está contruido en un lugar histórico de Stars Hollow", -400, TipoSorpresa::PORCASAHOTEL)
      @mazo << Sorpresa.new("El Presidente te otorga un presupuesto solicitado", 600, TipoSorpresa::PAGARCOBRAR)
      @mazo << Sorpresa.new("Matt Murdock te ha defendido en un juicio y debes pagar sus honorarios", -700, TipoSorpresa::PAGARCOBRAR)
      @mazo << Sorpresa.new("Elisabeth II te ha dado un indulto y puedes abandonar la prisión", 0, TipoSorpresa::SALIRCARCEL)
    end

    def get_sopresas_valor_mayor_cero
      lista = Array.new
      @mazo.each { |sorpresa|
        lista << sorpresa if sorpresa.valor > 0
      }
      lista
    end

    def get_sopresas_ir_casilla
      get_sopresas_de_tipo(TipoSorpresa::IRACASILLA)
    end

    def get_sopresas_de_tipo(tipo)
      lista = Array.new
      @mazo.each { |sorpresa|
        lista << sorpresa if sorpresa.tipo == tipo
      }
      lista
    end

    def aplicar_sorpresa
      tiene_propietario = false

      case @carta_actual.tipo
        when TipoSorpresa::PAGARCOBRAR
          @jugador_actual.modificar_saldo(@carta_actual.valor)
        when TipoSorpresa::IRACASILLA
          if @tablero.es_casilla_carcel(@carta_actual.valor)
            encarcelar_jugador
          else
            nueva_casilla = @tablero.obtener_casilla_numero(@carta_actual.valor)
            tiene_propietario = @jugador_actual.actualizar_posicion(nueva_casilla)
          end
        when TipoSorpresa::PORCASAHOTEL
          @jugador_actual.pagar_cobrar_por_casa_y_hotel(@carta_actual.valor)
        when TipoSorpresa::PORJUGADOR
          @jugadores.each{ |j|
            if j != @jugador_actual
              j.modificar_saldo(@carta_actual.valor)
            end
            @jugador_actual.modificar_saldo(-1 * @carta_actual.valor)
          }
        when TipoSorpresa::SALIRCARCEL
          @jugador_actual.carta_libertad = @carta_actual
        else
          @mazo << @carta_actual
      end

      tiene_propietario
    end

    def cancelar_hipoteca(casilla)
      cancelada = @jugador_actual.puedo_pagar_hipoteca(casilla)
      if cancelada
        pagar = casilla.cancelar_hipoteca
        @jugador_actual.modificar_saldo(-1 * pagar)
      end

      cancelada
    end

    def comprar_titulo_propiedad
      @jugador_actual.comprar_titulo
    end

    def edificar_casa(casilla)
      puedo_edificar = false

      if casilla.soy_edificable
        if casilla.se_puede_edificar_casa
          puedo_edificar = @jugador_actual.puedo_edificar_casa(casilla)
          if puedo_edificar
            coste_edificar = casilla.edificar_casa
            @jugador_actual.modificar_saldo(coste_edificar)
          end
        end
      end
      puedo_edificar
    end

    def edificar_hotel(casilla)
      puedo_edificar = false

      if casilla.soy_edificable
        if casilla.se_puede_edificar_hotel
          puedo_edificar = @jugador_actual.puedo_edificar_hotel(casilla)
          if puedo_edificar
            coste_edificar = casilla.edificar_hotel
            @jugador_actual.modificar_saldo(coste_edificar)
          end
        end
      end
      puedo_edificar
    end

    def get_sorpresa_actual
      @carta_actual
    end

    def get_jugador_actual
      @jugador_actual
    end

    def hipotecar_propiedad(casilla)
      puedo_hipotecar = false

      if casilla.soy_edificable
        se_puede_hipotecar = !casilla.esta_hipotecada
        if se_puede_hipotecar
          puedo_hipotecar = @jugador_actual.puedo_hipotecar
          if puedo_hipotecar
            cantidad_recibida = casilla.hipotecar
            @jugador_actual.modificar_saldo(cantidad_recibida)
          end
        end
      end
      puedo_hipotecar
    end

    def intentar_salir_carcel(metodo)
      libre = false

      if metodo == MetodoSalirCarcel::TIRANDODADO
        dado = Dado.instance.tirar
        libre = dado > 5
      elsif metodo == MetodoSalirCarcel::PAGANDOLIBERTAD
        libre = @jugador_actual.pagar_libertad(PRECIO_LIBERTAD)
      end

      if libre
        @jugador_actual.encarcelado = false
      end
      libre
    end

    def jugar
      valor_dado = Dado.instance.tirar
      casilla_posicion = @jugador_actual.casilla_actual
      nueva_casilla = @tablero.obtener_nueva_casilla(casilla_posicion, valor_dado)
      tiene_propietario = @jugador_actual.actualizar_posicion(nueva_casilla)

      unless nueva_casilla.soy_edificable
        if nueva_casilla.tipo == TipoCasilla::JUEZ
          encarcelar_jugador
        elsif nueva_casilla.tipo == TipoCasilla::SORPRESA
          @carta_actual = @mazo[0]
          @mazo.delete_at(0)
        end
      end
      tiene_propietario
    end

    def obtener_ranking
      ranking = Hash.new
      @jugadores.each{ |j|
        ranking[j.nombre] = j.obtener_capital
      }
      ranking
    end

    def propiedades_hipotecadas_jugador(hipotecadas)
      @jugador_actual.obtener_propiedades_hipotecadas(hipotecadas)
    end

    def siguiente_jugador
      next_player = 0
      if @jugador_actual != nil
        index = @jugadores.index(@jugador_actual)
        if index < (@jugadores.size - 1)
          next_player = index + 1
        end
      end
      @jugador_actual = jugadores[next_player]
    end

    def vender_propiedad(casilla)
      puedo_vender = @jugador_actual.puedo_vender_propiedad(casilla)
      if puedo_vender
        @jugador_actual.vender_propiedad(casilla)
      end
      puedo_vender
    end

    private
    def encarcelar_jugador
      if @jugador_actual.tengo_carta_libertad
        carta = @jugador_actual.devolver_carta_libertad
        @mazo << carta
      else
        @jugador_actual.ir_a_carcel(@tablero.carcel)
      end
    end

    def inicializar_jugadores(nombres)
      @jugadores = Array.new
      nombres.each { |n|
        @jugadores << Jugador.new(n)
      }

      #se asigna valor a jugador_actual
      siguiente_jugador
    end
    
    def salida_jugadores
      @jugadores.each{ |j|
        j.casilla_actual = @tablero.obtener_casilla_numero(0)
        j.saldo = 7500
      }
    end
  end
end