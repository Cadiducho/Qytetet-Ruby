#encoding: utf-8

module InterfazTextualQytetet
  class VistaTextualQytetet

    def seleccion_menu(menu)
      begin #Hasta que se hace una seleccion valida
        valido = true
        menu.each { |m| #se muestran las opciones del menuº
          mostrar( "#{m[0]}" + " : " + "#{m[1]}")
        }

        mostrar( "\n Elige un numero de opcion: ")
        captura = gets.chomp
        valido = comprobar_opcion(captura, 0, menu.length-1); #metodo para comprobar la eleccion correcta

        unless valido
          mostrar( "\n\n ERROR !!! \n\n Seleccion erronea. Intentalo de nuevo.\n\n")
        end
      end while (! valido)
      Integer(captura)
    end

    def comprobar_opcion(captura, min, max)
      # metodo para comprobar si la opcion introducida es correcta, usado por seleccion_menu
      valido = true
      begin
        opcion = Integer(captura)
        if opcion < min || opcion > max #No es un entero entre los validos
          valido = false
          mostrar('el numero debe estar entre min y max')
        end
      rescue Exception => e  #No se ha introducido un entero
        valido = false
        mostrar('debes introducir un numero')
      end
      valido
    end

    def menu_gestion_inmobiliaria
      mostrar( 'Elige la gestion inmobiliaria que deseas hacer')
      menu_gi = [[0, 'Siguiente Jugador'], [1, 'Edificar casa'], [2, 'Edificar Hotel'], [3, 'Vender propiedad'],[4, 'Hipotecar Propiedad'], [5, 'Cancelar Hipoteca']]
      salida = seleccion_menu(menu_gi)
      mostrar( 'has elegido')
      mostrar(salida)
      salida
    end

    def menu_salir_carcel
      mostrar( 'Elige el metodo para salir de la carcel')
      menu_so = [[0, 'Tirando el dado'], [1, 'Pagando mi libertad']]
      salida = seleccion_menu(menu_so)
      mostrar( 'has elegido')
      mostrar(salida)
      salida
    end

    def elegir_quiero_comprar
      mostrar( 'Elige si quieres comprar la casilla')
      menu_so = [[0, 'No'], [1, 'Sí']]
      salida = seleccion_menu(menu_so)
      mostrar( 'has elegido')
      mostrar(salida)
      salida
    end

    def menu_elegir_propiedad(lista_propiedades) # numero y nombre de propiedades
      menu_ep = Array.new
      numero_opcion = 0
      lista_propiedades.each { |prop|
        menu_ep << [numero_opcion, prop] # opcion de menu, numero y nombre de propiedad
        numero_opcion = numero_opcion+1
      }
      #mostrar(menu_ep.inspect)
      seleccion_menu(menu_ep) # Método para controlar la elección correcta en el menú
    end

    def obtener_nombre_jugadores
      nombres = Array.new
      valido = true
      begin
        self.mostrar("Escribe el numero de jugadores: (de 2 a 4):")
        lectura = gets.chomp #lectura de teclado
        valido = comprobar_opcion(lectura, 2, 4) #método para comprobar la elección correcta
      end while(!valido)

      for i in 1..Integer(lectura)  #pide nombre de jugadores y los mete en un array
        mostrar('Jugador:  '+ i.to_s)
        nombre = gets.chomp
        nombre
        nombres << nombre
      end
      nombres
    end

    def mostrar(texto)  #metodo para mostrar el string que recibe como argumento
      puts texto
    end

    def press_to_continue
      mostrar("Pulse una tecla para continuar")
      gets.chomp
      mostrar("            \r")
    end

    private :comprobar_opcion, :seleccion_menu


  end
end
