#encoding: utf-8

require_relative "../modelo/qytetet"
require_relative "vista_textual_qytetet"
module InterfazTextualQytetet
  class ControladorQytetet

    include ModeloQytetet

    def main
      inicializacion_juego
      desarrollo_juego
    end

    def inicializacion_juego
      @juego = Qytetet.instance
      @vista = VistaTextualQytetet.new

      nombres = @vista.obtener_nombre_jugadores
      @juego.inicializar_juego(nombres)

      @jugador = @juego.jugador_actual
      @casilla = @jugador.casilla_actual

      ver_estado_juego
      @vista.press_to_continue
    end

    def desarrollo_juego
      fin = false
      begin
        @vista.mostrar("Es el turno de #{@jugador.nombre}, tirando desde la casilla #{@casilla.numero_casilla}")

        sigue_jugando = true
        if @jugador.encarcelado
          @vista.mostrar("Estás en la cárcel")
          metodo = @vista.menu_salir_carcel

          sale = @juego.intentar_salir_carcel(metodo)
          if sale
            @vista.mostrar("Has salido de la cárcel. Ahora puedes seguir jugando")
          else
            @vista.mostrar("No has podido salir de la cárcel. Se pasa el turno")
            sigue_jugando = false
          end
          @vista.press_to_continue
        end

        if sigue_jugando
          @juego.jugar
        end

        @jugador = @juego.siguiente_jugador
        ver_estado_juego
        @vista.press_to_continue
      end until fin
    end

    def ver_estado_juego
      @vista.mostrar("Jugadores: ")
      jugadores = @juego.jugadores
      jugadores.each { |j|
        @vista.mostrar("#{j.nombre} está en la casilla #{j.casilla_actual.numero_casilla} y tiene #{j.saldo}$ ")
      }
      @vista.mostrar("Es el turno de #{@jugador.nombre}, tirando desde la casilla #{@casilla.numero_casilla}")
    end

    def elegir_propiedad(propiedades) # lista de propiedades a elegir
      @vista.mostrar("\tCasilla\tTitulo");

      lista_propiedades= Array.new
      propiedades.each { |prop|  # crea una lista de strings con numeros y nombres de propiedades
        prop_string = prop.numeroCasilla.to_s + ' ' + prop.titulo.nombre;
        lista_propiedades << prop_string
      }

      seleccion = @vista.menu_elegir_propiedad(lista_propiedades)  # elige de esa lista del menu
      propiedades.at(seleccion)
    end
    private :elegir_propiedad

  end

  c = ControladorQytetet.new
  c.main
end

