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

        #si esta en la carcel, trato especial
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

        #gestionar movimiento
        if sigue_jugando
          tiene_propietario = @juego.jugar

          if @jugador.casilla_actual.tipo == TipoCasilla::SORPRESA
            @vista.mostrar("Has caído en una casilla sorpresa")
            @vista.mostrar(@juego.get_sorpresa_actual)
            @juego.aplicar_sorpresa
          end
          if tiene_propietario
            @vista.mostrar("Has caído en una casilla con propietario")
          else
            @vista.mostrar("Esta casila no tiene propietario")
            comprar = @vista.elegir_quiero_comprar
            if comprar == 1
              puedo_comprar = @juego.comprar_titulo_propiedad
              if puedo_comprar
                @vista.mostrar("Has comprado la casilla #{@jugador.casilla_actual.numero_casilla}")
              else
                @vista.mostrar("No puedes comprar la casilla #{@jugador.casilla_actual.numero_casilla}")
              end
            end
          end
        end

        if @jugador.tengo_propiedades && !@jugador.encarcelado && @jugador.saldo > 0
          gestion = @vista.menu_gestion_inmobiliaria
          unless gestion == 0
            num_casilla = @vista.menu_elegir_propiedad(@jugador.propiedades)
            edit_casilla = @juego.tablero.obtener_casilla_numero(num_casilla)
            case gestion
              when 1
                @juego.edificar_casa(edit_casilla)
              when 2
                @juego.edificar_hotel(edit_casilla)
              when 3
                @juego.vender_propiedad(edit_casilla)
              when 4
                @juego.hipotecar_propiedad(edit_casilla)
              when 5
                @juego.cancelar_hipoteca(edit_casilla)
            end
          end
        end

        if @jugador.saldo <= 0
          #bancarrota
          @vista.mostrar("Ha terminado el juego porque #{@jugador.nombre} ha caído en bancarrota")
          fin = true
        else
          #gestionar final de turno
          @jugador = @juego.siguiente_jugador
          @casilla = @jugador.casilla_actual
          ver_estado_juego

          @vista.press_to_continue
        end
      end until fin

      #final del juego
      @juego.obtener_ranking.each{ |nombre, saldo|
        @vista.mostrar("#{nombre} - #{saldo}$")
      }
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
      @vista.mostrar("\tCasilla\tTitulo")

      lista_propiedades= Array.new
      propiedades.each { |prop|  # crea una lista de strings con numeros y nombres de propiedades
        prop_string = prop.numeroCasilla.to_s + ' ' + prop.titulo.nombre
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

